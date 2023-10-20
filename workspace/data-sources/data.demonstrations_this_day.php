<?php

class datasourcedemonstrations_this_day extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'demonstrations-this-day';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamSORT = 'system:id';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        '439' => 'regexp: -{$this-month}-{$this-day}|-{$month}-{$day}',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'name',
        'summary: formatted',
        'documents',
        'date',
        'image'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'documents' => array(
            'section_id' => '6',
            'field_id' => '26',
            'elements' => array(
                'name',
                'organisation',
                'cover-image'
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
            'name' => 'Demonstrations - This Day',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://dev.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2022-11-13T22:47:50+00:00'
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
