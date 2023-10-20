<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcesection_count extends SectionDatasource {

		public $dsParamROOTELEMENT = 'section-count';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '20';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about() {
			return array(
				'name' => 'Section Count',
				'author' => array(
					'name' => 'Aonrud',
					'website' => 'https://www.leftarchive.ie',
					'email' => 'admin@leftarchive.ie'),
				'version' => 'Symphony 2.3.3',
				'release-date' => '2013-09-23T18:43:14+00:00'
			);
		}

		public function getSource() {
			return NULL;
		}

		public function allowEditorToParse() {
			return false;
		}

		public function execute(array &$param_pool = null) {
			
			$result = new XMLElement($this->dsParamROOTELEMENT);
			
			foreach(SectionManager::fetch() as $section) {
				$sid = $section->get('id');
				
				$section_item = new XMLElement('section', NULL, array(
					'id' => $sid,
					'name' =>  $section->get('name')
				  )
				);
				
				//Where we use a 'hidden' field to store entries but not display them,
				//filter out the hidden entries.
				$where = null;
				$joins = null;
				
				//Affected sections:
				// 5 = publications
				$filtered_sections = [ 5 ];
				if (in_array($sid, $filtered_sections)) {
					$field = FieldManager::fetchFieldIDFromElementName("hidden", $sid);
					$joins = "LEFT JOIN sym_entries_data_$field as `hidden` on (`e`.id = `hidden`.`entry_id`)";
					$where = "AND `hidden`.`value` = 'no'";
				}
				
				$entries = EntryManager::fetchCount($section->get('id'), $where, $joins);
				$section_item->appendChild(new XMLElement('count', (string)$entries));
				$result->appendChild($section_item);
			}
			
			return $result;
		}

	}
