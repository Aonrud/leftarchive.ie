<?php
	
	require_once(EXTENSIONS . '/search_index/lib/class.search_index.php');
	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourcesearch_custom extends SectionDatasource {
		
		public $dsParamROOTELEMENT = 'search';
		public $dsParamLIMIT = '1';
		public $dsParamSTARTPAGE = '1';
		
		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
		}
		
		public static function sortWordDistance($a, $b) {
			return $a['distance'] > $b['distance'];
		}
		
		public function about(){
			return array(
					'name' => 'Search Index - Customised',
					'author' => array(
							'name' => 'Aonrud',
							'website' => ''
						)
					);
		}
		
		public function getSource(){
			return NULL;
		}
		
		public function allowEditorToParse(){
			return FALSE;
		}
		
		private function errorXML($message) {
			$result = new XMLElement($this->dsParamROOTELEMENT);
			$result->appendChild(new XMLElement('error', $message));
			return $result;
		}
		
		public function execute(array &$param_pool = null) {
			
			$result = new XMLElement($this->dsParamROOTELEMENT);
			$config = (object)Symphony::Configuration()->get('search_index');
			
			
		// Setup
		/*-----------------------------------------------------------------------*/
			
			// look for key in GET array if it's specified
			if (!empty($config->{'get-param-prefix'})) {
				if ($config->{'get-param-prefix'} == 'param_pool') {
					$_GET = $this->_env['param'];
				} else {
					$_GET = $_GET[$config->{'get-param-prefix'}];
				}
			}
			
			// get input parameters from GET request
			$param_keywords = isset($_GET[$config->{'get-param-keywords'}]) ? trim($_GET[$config->{'get-param-keywords'}]) : '';
			
			//EDIT 9/11/2013 Quick fix - loses any non-UTF8 chars, but avoids htmlspecialchars() borking
			$param_keywords = mb_convert_encoding($param_keywords, 'UTF-8', 'UTF-8');
			$param_sort = isset($_GET[$config->{'get-param-sort'}]) ? $_GET[$config->{'get-param-sort'}] : $config->{'default-sort'};
			$param_direction = isset($_GET[$config->{'get-param-direction'}]) ? strtolower($_GET[$config->{'get-param-direction'}]) : $config->{'default-direction'};
			
			// set pagination on the data source
			$this->dsParamSTARTPAGE = isset($_GET[$config->{'get-param-page'}]) ? (int)$_GET[$config->{'get-param-page'}] : $this->dsParamSTARTPAGE;
			$this->dsParamLIMIT = (isset($_GET[$config->{'get-param-per-page'}]) && (int)$_GET[$config->{'get-param-per-page'}] > 0) ? (int)$_GET[$config->{'get-param-per-page'}] : $config->{'default-per-page'};
			
			// build ORDER BY statement for later
			switch($param_sort) {
				case 'date': $sql_order_by = "e.creation_date $param_direction"; break;
				case 'id': $sql_order_by = "e.id $param_direction"; break;
				default: $sql_order_by = "score $param_direction"; break;
			}
		
		
		// Find valid sections to query
		/*-----------------------------------------------------------------------*/
		
			if(isset($_GET[$config->{'get-param-sections'}]) && !empty($_GET[$config->{'get-param-sections'}])) {
				$param_sections = $_GET[$config->{'get-param-sections'}];
				// allow sections to be sent as an array if the user wishes (multi-select or checkboxes)
				if(is_array($param_sections)) {
					$param_sections = implode(',', $param_sections);
				}
			}
			elseif(!empty($config->{'default-sections'})) {
				$param_sections = $config->{'default-sections'};
			} else {
				$param_sections = '';
			}

			$sections = array();
			foreach(array_map('trim', explode(',', $param_sections)) as $handle) {
				$section = Symphony::Database()->fetchRow(0,
					sprintf(
						"SELECT `id`, `name` FROM `tbl_sections` WHERE handle = '%s' LIMIT 1",
						Symphony::Database()->cleanValue($handle)
					)
				);
				if ($section) $sections[$section['id']] = array('handle' => $handle, 'name' => $section['name']);
			}
			
			if (count($sections) == 0) return $this->errorXML('Invalid search sections');
		
		
		// Set up and manipulate keywords
		/*-----------------------------------------------------------------------*/
			
			// should we apply word stemming?
			$do_stemming = ($config->{'stem-words'} == 'yes') ? TRUE : FALSE;
			
			// replace synonyms
			$keywords = SearchIndex::applySynonyms($param_keywords);
			$keywords_boolean = SearchIndex::parseKeywordString($keywords, $do_stemming);
			$keywords_highlight = trim(implode(' ', $keywords_boolean['highlight']), '"');
		
		// Set up weighting
		/*-----------------------------------------------------------------------*/

			$sql_weighting = '';
			foreach(SearchIndex::getIndexes() as $section_id => $index) {
				$weight = isset($index['weighting']) ? $index['weighting'] : 2;
				switch ($weight) {
					case 0: $weight = 4; break;		// highest
					case 1: $weight = 2; break;		// high
					case 2: $weight = 1; break;		// none
					case 3: $weight = 0.5; break;	// low
					case 4: $weight = 0.25; break;	// lowest
				}
				$sql_weighting .= sprintf("WHEN e.section_id = %d THEN %d \n", $section_id, $weight);
			}
		
		
		// Build search SQL
		/*-----------------------------------------------------------------------*/
			
			$mode = !is_null($config->{'mode'}) ? $config->{'mode'} : 'like';
			$mode = strtoupper($mode);
			
			switch($mode) {
				
				case 'FULLTEXT':
				
					$sql = sprintf(
						"SELECT
							SQL_CALC_FOUND_ROWS
							e.id as `entry_id`,
							data,
							e.section_id as `section_id`,
							UNIX_TIMESTAMP(e.creation_date) AS `creation_date`,
							(
								MATCH(index.data) AGAINST ('%1\$s') *
								CASE
									%2\$s
									ELSE 1
								END
								%3\$s
							) AS `score`
						FROM
							tbl_search_index as `index`
							JOIN tbl_entries as `e` ON (index.entry_id = e.id)
						WHERE
							MATCH(index.data) AGAINST ('%4\$s' IN BOOLEAN MODE)
							AND e.section_id IN ('%5\$s')
						ORDER BY
							%6\$s
						LIMIT %7\$d, %8\$d",
						Symphony::Database()->cleanValue($keywords),
						$sql_weighting,
						($param_sort == 'score-recency') ? '/ SQRT(GREATEST(1, DATEDIFF(NOW(), creation_date)))' : '',
						Symphony::Database()->cleanValue($keywords),
						implode("','", array_keys($sections)),
						Symphony::Database()->cleanValue($sql_order_by),
						max(0, ($this->dsParamSTARTPAGE - 1) * $this->dsParamLIMIT),
						(int)$this->dsParamLIMIT
					);
				
				break;
				
				case 'LIKE':
				case 'REGEXP':
					
					$sql_locate = '';
					$sql_replace = '';
					$sql_where = '';
					
					// by default, no wildcard separators
					$prefix = '';
					$suffix = '';
					
					// append wildcard for LIKE
					if($mode == 'LIKE') {
						$prefix = $suffix = '%';
					}
					// apply word boundary separator
					if($mode == 'REGEXP') {
						$prefix = '[[:<:]]';
						$suffix = '[[:>:]]';
					}
					
					// all words to include in the query (single words and phrases)
					foreach($keywords_boolean['include-words-all'] as $keyword) {
						$keyword_stem = NULL;
						
						$keyword = Symphony::Database()->cleanValue($keyword);
						if($do_stemming) {
							$keyword_stem = Symphony::Database()->cleanValue(PorterStemmer::Stem($keyword));
						}
						
						// if the word can be stemmed, look for the word or the stem version
						if ($do_stemming && ($keyword_stem != $keyword)) {
							$sql_where .= "(index.data $mode '$prefix$keyword$suffix' OR index.data $mode '$prefix$keyword_stem$suffix') AND ";
						} else {
							$sql_where .= "index.data $mode '$prefix$keyword$suffix' AND ";
						}
						
						// if this keyword exists in the entry contents, add 1 to "keywords_matched"
						// which represents number of unique keywords in the search string that are found
						$sql_locate .= "IF(LOCATE('$keyword', LOWER(`data`)) > 0, 1, 0) + ";
						
						// see how many times this word is found in the entry contents by removing it from
						// the column text then compare length to see how many times it was removed
						$sql_replace .= "(LENGTH(`data`) - LENGTH(REPLACE(LOWER(`data`),LOWER('$keyword'),''))) / LENGTH('$keyword') + ";
					}
					
					// all words or phrases that we do not want
					foreach($keywords_boolean['exclude-words-all'] as $keyword) {
						$keyword = Symphony::Database()->cleanValue($keyword);
						$sql_where .= "index.data NOT $mode '$prefix$keyword$suffix' AND ";
					}
					
					// append to complete SQL
					$sql_locate = ($sql_locate == '') ? $sql_locate = '1' : $sql_locate .= '0';
					$sql_replace = ($sql_replace == '') ? $sql_replace = '1' : $sql_replace .= '0';
					$sql_where = ($sql_where == '') ? $sql_where = 'NOT 1' : $sql_where;
					
					// trim unnecessary boolean conditions from SQL
					$sql_where = preg_replace("/ OR $/", "", $sql_where);
					$sql_where = preg_replace("/ AND $/", "", $sql_where);
					
					// if ordering by score, use a function of the two columns
					// we are calculating rather than just "score"
					if(preg_match("/^score/", $sql_order_by)) {
						$sql_order_by = preg_replace("/^score/", "(keywords_matched * score)", $sql_order_by);
					}
					
					$sql_join = 'JOIN tbl_entries as `e` ON (index.entry_id = e.id)';
					
					//Filter by year
					$year1 = $_GET['year1'];
					$year2 = $_GET['year2'];
					if (!empty($year1) && !empty($year2)) {
						$filter_years = TRUE;
					//This should be generated properly, but covers all sections/fields required for now
						$year_join = "LEFT JOIN sym_entries_data_93 AS `dyear` ON (index.entry_id = dyear.entry_id)
										LEFT JOIN sym_entries_data_82 AS `oyear1` ON (index.entry_id = oyear1.entry_id)
										LEFT JOIN sym_entries_data_83 AS `oyear2` ON (index.entry_id = oyear2.entry_id)
										LEFT JOIN sym_entries_data_86 AS `pyear1` ON (index.entry_id = pyear1.entry_id)
										LEFT JOIN sym_entries_data_87 AS `pyear2` ON (index.entry_id = pyear2.entry_id)
										LEFT JOIN sym_entries_data_439 AS `syear` ON (index.entry_id = syear.entry_id)";
						$year_where = " AND (dyear.value BETWEEN '$year1' AND '$year2'
											OR dyear.entry_id IS NULL)
										AND (syear.value BETWEEN '$year1' AND '$year2-12-31'
											OR syear.entry_id IS NULL)
										AND (oyear1.value <= '$year2'
											OR oyear1.entry_id IS NULL)
										AND (oyear2.value >= '$year1'
											OR oyear2.entry_id IS NULL)
										AND (pyear1.value <= '$year2'
											OR pyear1.entry_id IS NULL)
										AND (pyear2.value >= '$year1'
											OR pyear2.entry_id IS NULL)";
						
						$sql_join .= $year_join;
						$sql_where .= $year_where;
						
					}
					
					$sql = sprintf(
						"SELECT
							SQL_CALC_FOUND_ROWS
							e.id as `entry_id`,
							data,
							e.section_id as `section_id`,
							UNIX_TIMESTAMP(e.creation_date) AS `creation_date`,
							(
								%1\$s
							) AS keywords_matched,
							(
								(%2\$s)
								*
								CASE
									%3\$s
									ELSE 1
								END
								%4\$s
							) AS score
						FROM
							tbl_search_index as `index`
							%5\$s
						WHERE
							%6\$s
							AND e.section_id IN ('%7\$s')
						ORDER BY
							%8\$s
						LIMIT
							%9\$d, %10\$d",
						$sql_locate,
						$sql_replace,
						$sql_weighting,
						($param_sort == 'score-recency') ? '/ SQRT(GREATEST(1, DATEDIFF(NOW(), creation_date)))' : '',
						$sql_join,
						$sql_where,
						implode("','", array_keys($sections)),
						Symphony::Database()->cleanValue($sql_order_by),
						max(0, ($this->dsParamSTARTPAGE - 1) * $this->dsParamLIMIT),
						(int)$this->dsParamLIMIT
					);
					
					//echo $sql;die;
				
				break;

			}
		
		
		// Add soundalikes ("did you mean?") to XML
		/*-----------------------------------------------------------------------*/
			
			// we have search words, check for soundalikes
			if(count($keywords_boolean['include-words-all']) > 0) {
				
				$sounds_like = array();
				
				foreach($keywords_boolean['include-words-all'] as $word) {
					$soundalikes = Symphony::Database()->fetchCol('keyword', sprintf(
						"SELECT keyword FROM tbl_search_index_keywords WHERE SOUNDEX(keyword) = SOUNDEX('%s')",
						Symphony::Database()->cleanValue($word)
					));
					foreach($soundalikes as $i => &$soundalike) {
						if($soundalike == $word) {
							unset($soundalikes[$i]);
							continue;
						}
						$soundalike = array(
							'word' => $soundalike,
							'distance' => levenshtein($soundalike, $word)
						);
					}
					usort($soundalikes, array('datasourcesearch_custom', 'sortWordDistance'));
					$sounds_like[$word] = $soundalikes[0]['word'];
				}
				
				// add words to XML
				if(count($sounds_like) > 0) {
					$alternative_spelling = new XMLElement('alternative-keywords');
					foreach($sounds_like as $word => $soundalike) {
						$alternative_spelling->appendChild(
							new XMLElement('keyword', NULL, array(
								'original' => General::sanitize($word),
								'alternative' => General::sanitize($soundalike),
								'distance' => levenshtein($soundalike, $word)
							))
						);
					}
					$result->appendChild($alternative_spelling);
				}
				
			}
		
		
		// Run search SQL!
		/*-----------------------------------------------------------------------*/
			
			// get our entries, returns entry IDs
			$entries = Symphony::Database()->fetch($sql);
			$total_entries = Symphony::Database()->fetchVar('total', 0, 'SELECT FOUND_ROWS() AS `total`');
			
			// append input values
			$result->setAttributeArray(
				array(
					'keywords' => General::sanitize($keywords),
					'sort' => General::sanitize($param_sort),
					'direction' => General::sanitize($param_direction),
				)
			);
			
			// append pagination
			$result->appendChild(
				General::buildPaginationElement(
					$total_entries,
					ceil($total_entries * (1 / $this->dsParamLIMIT)),
					$this->dsParamLIMIT,
					$this->dsParamSTARTPAGE
				)
			);
			
			// append list of sections
			$sections_xml = new XMLElement('sections');
			foreach($sections as $id => $section) {
				$sections_xml->appendChild(
					new XMLElement(
						'section',
						General::sanitize($section['name']),
						array(
							'id' => $id,
							'handle' => $section['handle']
						)
					)
				);
			}
			$result->appendChild($sections_xml);
		
		
		// Append entries to XML, build if desired
		/*-----------------------------------------------------------------------*/
			
			// if true then the entire entry will be appended to the XML. If not, only
			// a "stub" of the entry ID is provided, allowing other data sources to
			// supplement with the necessary fields
			$build_entries = ($config->{'build-entries'} == 'yes') ? TRUE : FALSE;
			if($build_entries) {
				$field_pool = array();
			}
			
			// container for entry ID output parameter
			$param_output = array();
			
			foreach($entries as $entry) {
				
				$param_output[] = $entry['entry_id'];
				
				$entry_xml = new XMLElement(
					'entry',
					NULL,
					array(
						'id' => $entry['entry_id'],
						'section' => $sections[$entry['section_id']]['handle'],
						//'score' => round($entry['score'], 3)
					)
				);
				
				// add excerpt with highlighted search terms
				$excerpt = SearchIndex::parseExcerpt($keywords_highlight, $entry['data']);
				$excerpt = html_entity_decode($excerpt);
				
				
				//Changed below to deal with invalid chars breaking XML processing on search page.
				//$excerpt = utf8_encode($excerpt);
				//$excerpt = iconv('UTF-8', 'UTF-8//IGNORE', $excerpt);
				//Escape entry content
				$excerpt = htmlspecialchars($excerpt);
				$entry_xml->appendChild(new XMLElement('excerpt', $excerpt));
				
 
				// build and append entry data
				if($build_entries) {
					$e = reset(EntryManager::fetch($entry['entry_id']));
					$data = $e->getData();
					foreach($data as $field_id => $values){
						if(!isset($field_pool[$field_id]) || !is_object($field_pool[$field_id])) {
							$field_pool[$field_id] = FieldManager::fetch($field_id);
						}
						$field_pool[$field_id]->appendFormattedElement($entry_xml, $values, FALSE, (!empty($values['value_formatted']) ? 'formatted' : null), $e->get('id'));
					}
				}
				
				$result->appendChild($entry_xml);
			}
			
			// send entry IDs as Output Parameterss
			$param_pool['ds-' . $this->dsParamROOTELEMENT . '.id'] = $param_output;
	
		// Log query
		/*-----------------------------------------------------------------------*/
		
			if ($config->{'log-keywords'} == 'yes' && trim($keywords)) {
				
				$section_handles = array_map('reset', array_values($sections));
				
				// has this search (keywords+sections) already been logged this session?
				$already_logged = Symphony::Database()->fetch(sprintf(
					"SELECT * FROM `tbl_search_index_logs` WHERE keywords='%s' AND sections='%s' AND session_id='%s'",
					Symphony::Database()->cleanValue($param_keywords),
					Symphony::Database()->cleanValue(implode(',', $section_handles)),
					session_id()
				));
				
				$log_sql = sprintf(
					"INSERT INTO `tbl_search_index_logs`
					(date, keywords, keywords_manipulated, sections, page, results, session_id)
					VALUES('%s', '%s', '%s', '%s', %d, %d, '%s')",
					date('Y-m-d H:i:s', time()),
					Symphony::Database()->cleanValue($param_keywords),
					Symphony::Database()->cleanValue($keywords),
					Symphony::Database()->cleanValue(implode(',', $section_handles)),
					$this->dsParamSTARTPAGE,
					$total_entries,
					session_id()
				);
				
				Symphony::Database()->query($log_sql);
				
			}
		
			return $result;

		}
	
	}
