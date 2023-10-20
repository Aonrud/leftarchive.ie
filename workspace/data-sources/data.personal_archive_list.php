<?php

class datasourcepersonal_archive_list extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'personal-archive-list';
    public $dsParamORDER = 'asc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamREQUIREDPARAM = '$id';
    public $dsParamSORT = 'year';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        '334' => '{$id}',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'name',
        'year',
        'document',
        'cover-image',
        'type',
        'journal',
        'volume',
        'issue',
        'pages',
        'publisher',
        'place'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'type' => array(
            'section_id' => '33',
            'field_id' => '301',
            'elements' => array(
                'type',
                'meta'
            )
        )
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'Personal Archive - List',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://www.clririshleftarchive.org',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.3',
            'release-date' => '2018-07-27T08:49:23+00:00'
        );
    }

    public function getSource()
    {
        return '38';
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
