<?php

class datasourcepublication_single_dynamic extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'publication-single-dynamic';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'yes';
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
        'name',
        'irish',
        'tagline',
        'organisations',
        'about: formatted',
        'irregular',
        'year-started',
        'start-est',
        'year-ended',
        'end-est',
        'sample-issue',
        'masthead-jit',
        'masthead',
        'masthead-type',
        'identifiers',
        'links',
        'minor',
        'parent',
        'hidden'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'sample-issue' => array(
            'section_id' => '6',
            'field_id' => '26',
            'elements' => array(
                'cover-image'
            )
        ),
        'organisations' => array(
            'section_id' => '4',
            'field_id' => '13',
            'elements' => array(
                'name',
                'about: formatted',
                'year-founded',
                'year-dissolved',
                'logo',
                'minor',
                'parent',
                'minor-type'
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
            'name' => 'Publication - Single - Dynamic',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://www.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2022-10-06T13:14:24+00:00'
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
