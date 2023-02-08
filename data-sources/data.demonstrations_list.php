<?php

class datasourcedemonstrations_list extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'demonstrations-list';
    public $dsParamORDER = 'asc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamSORT = 'date';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        '450' => '{$ds-subject-single.system-id},{$ds-subjects-included.system-id}',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'system:date',
        'name',
        'date',
        'place',
        'image'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'place' => array(
            'section_id' => '47',
            'field_id' => '447',
            'elements' => array(
                'town',
                'county'
            )
        )
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-subject-single.system-id', '$ds-subjects-included.system-id');
    }

    public function about()
    {
        return array(
            'name' => 'Demonstrations - List',
            'author' => array(
                'name' => 'Aon Rud',
                'website' => 'https://www.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2023-02-08T11:12:20+00:00'
        );
    }

    public function getSource()
    {
        return '46';
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