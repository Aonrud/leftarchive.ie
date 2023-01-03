<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcecomments_rss extends SectionDatasource {

		public $dsParamROOTELEMENT = 'comments-rss';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '20';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'date';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		

		public $dsParamFILTERS = array(
				'58' => 'yes',
		);
		

		public $dsParamINCLUDEDELEMENTS = array(
				'title',
				'comment: formatted',
				'date',
				'name',
				'email',
				'website',
				'associated-page',
				'parent'
		);
		

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about() {
			return array(
				'name' => 'Comments - RSS',
				'author' => array(
					'name' => 'Aonrud',
					'website' => 'https://www.leftarchive.ie',
					'email' => 'admin@leftarchive.ie'),
				'version' => 'Symphony 2.3.3',
				'release-date' => '2014-01-21T10:54:48+00:00'
			);
		}

		public function getSource() {
			return '9';
		}

		public function allowEditorToParse() {
			return true;
		}

		public function execute(array &$param_pool = null) {
			$result = new XMLElement($this->dsParamROOTELEMENT);

			try{
				$result = parent::execute($param_pool);
			}
			catch(FrontendPageNotFoundException $e){
				// Work around. This ensures the 404 page is displayed and
				// is not picked up by the default catch() statement below
				FrontendPageNotFoundExceptionHandler::render($e);
			}
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage() . ' on ' . $e->getLine() . ' of file ' . $e->getFile()));
				return $result;
			}

			if($this->_force_empty_result) $result = $this->emptyXMLSet();

			return $result;
		}

	}
