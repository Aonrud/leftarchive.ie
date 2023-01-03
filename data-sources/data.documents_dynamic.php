<?php

class datasourcedocuments_dynamic extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'documents-dynamic';
    public $dsParamORDER = 'asc';
    public $dsParamPAGINATERESULTS = 'yes';
    public $dsParamLIMIT = '{$url-length:30}';
    public $dsParamSTARTPAGE = '{$url-page}';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamSORT = 'year';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        '294' => 'regexp: {$url-search.value}',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'system:pagination',
        'name',
        'subtitle',
        'organisation',
        'publication',
        'uncertain',
        'year',
        'authors'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'organisation' => array(
            'section_id' => '4',
            'field_id' => '13',
            'elements' => array(
                'name',
                'minor',
                'parent'
            )
        ),
        'publication' => array(
            'section_id' => '5',
            'field_id' => '16',
            'elements' => array(
                'name',
                'minor',
                'parent'
            )
        ),
        'authors' => array(
            'section_id' => '19',
            'field_id' => '144',
            'elements' => array(
                'name',
                'sort-name'
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
            'name' => 'Documents - Dynamic',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://www.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.6.7',
            'release-date' => '2017-12-18T11:43:53+00:00'
        );
    }

    public function getSource()
    {
        return '6';
    }

    public function allowEditorToParse()
    {
        return true;
    }

    public function execute(array &$param_pool = null)
    {
        $result = new XMLElement($this->dsParamROOTELEMENT);

        try{
            $result = parent::execute($param_pool);
        } catch (FrontendPageNotFoundException $e) {
            // Work around. This ensures the 404 page is displayed and
            // is not picked up by the default catch() statement below
            FrontendPageNotFoundExceptionHandler::render($e);
        } catch (Exception $e) {
            $result->appendChild(new XMLElement('error', $e->getMessage() . ' on ' . $e->getLine() . ' of file ' . $e->getFile()));
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
