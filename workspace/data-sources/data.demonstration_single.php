<?php

class datasourcedemonstration_single extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'demonstration-single';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'yes';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'yes';
    public $dsParamREQUIREDPARAM = '$id';
    public $dsParamPARAMOUTPUT = array(
        'system:id'
    );
    public $dsParamSORT = 'system:id';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        'system:id' => '{$id}',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'system:date',
        'name',
        'summary: formatted',
        'documents',
        'subjects',
        'related',
        'date',
        'added',
        'place',
        'image',
        'photo',
        'photo-caption'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'documents' => array(
            'section_id' => '6',
            'field_id' => '26',
            'elements' => array(
                'name',
                'subtitle',
                'organisation',
                'publication',
                'cover-image',
                'uncertain',
                'year',
                'month',
                'day'
            )
        ),
        'subjects' => array(
            'section_id' => '31',
            'field_id' => '277',
            'elements' => array(
                'name',
                'group'
            )
        ),
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
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'Demonstration - Single',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://www.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2022-12-02T15:15:48+00:00'
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
