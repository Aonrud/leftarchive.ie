<?php

class datasourcepublications_list_all extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'publications-list-all';
    public $dsParamORDER = 'asc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamSORT = 'sort-name';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        '169' => '{$ds-organisation-single.system-id},{$ds-organisations-minor.system-id}',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'name',
        'irish',
        'tagline',
        'organisations',
        'hidden',
        'irregular',
        'year-started',
        'start-est',
        'year-ended',
        'end-est',
        'publication-gaps',
        'sort-name'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'organisations' => array(
            'section_id' => '4',
            'field_id' => '13',
            'elements' => array(
                'name',
                'place',
                'minor',
                'parent',
                'minor-type'
            )
        )
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-organisation-single.system-id', '$ds-organisations-minor.system-id');
    }

    public function about()
    {
        return array(
            'name' => 'Publications - List - All',
            'author' => array(
                'name' => 'Aon Rud',
                'website' => 'https://www.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2023-07-22T17:16:41+00:00'
        );
    }

    public function getSource()
    {
        return '5';
    }

    public function allowEditorToParse()
    {
        return true;
    }

    public function execute(array &$param_pool = null)
    {
        $result = new XMLElement($this->dsParamROOTELEMENT);

        try {
            $result = parent::execute($param_pool);
        } catch (FrontendPageNotFoundException $e) {
            // Work around. This ensures the 404 page is displayed and
            // is not picked up by the default catch() statement below
            FrontendPageNotFoundExceptionHandler::render($e);
        } catch (Exception $e) {
            $result->appendChild(new XMLElement('error',
                General::wrapInCDATA($e->getMessage() . ' on ' . $e->getLine() . ' of file ' . $e->getFile())
            ));
            return $result;
        }

        if ($this->_force_empty_result) {
            $result = $this->emptyXMLSet();
        }

        if ($this->_negate_result) {
            $result = $this->negateXMLSet();
        }

        return $result;
    }
}