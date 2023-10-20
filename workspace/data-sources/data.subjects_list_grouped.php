<?php

class datasourcesubjects_list_grouped extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'subjects-list-grouped';
    public $dsParamORDER = 'asc';
    public $dsParamGROUP = '307';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamSORT = 'name';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        '307' => 'not:\"Organisation\",\"People\"',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'name',
        'group',
        'date'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'Subjects - List - Grouped',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://www.clririshleftarchive.org',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.3',
            'release-date' => '2018-05-06T11:15:01+00:00'
        );
    }

    public function getSource()
    {
        return '31';
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
