<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcepages_single extends SectionDatasource {

		public $dsParamROOTELEMENT = 'pages-single';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '20';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'yes';
		public $dsParamREQUIREDPARAM = '$title';
		public $dsParamPARAMOUTPUT = array(
				'system:id'
		);
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		

		public $dsParamFILTERS = array(
				'97' => '{$title}',
				'168' => 'yes',
		);
		

		public $dsParamINCLUDEDELEMENTS = array(
				'title',
				'sub-title',
				'content: formatted',
				'comments-enabled',
				'image',
				'image-link'
		);
		

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about() {
			return array(
				'name' => 'Pages Single',
				'author' => array(
					'name' => 'Aonrud',
					'website' => 'https://www.leftarchive.ie',
					'email' => 'admin@leftarchive.ie'),
				'version' => 'Symphony 2.3.3',
				'release-date' => '2014-10-14T16:20:50+00:00'
			);
		}

		public function getSource() {
			return '13';
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
