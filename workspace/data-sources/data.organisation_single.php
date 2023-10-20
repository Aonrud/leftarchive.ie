<?php

class datasourceorganisation_single extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'organisation-single';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'yes';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'yes';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'yes';
    public $dsParamREQUIREDPARAM = '$id';
    public $dsParamPARAMOUTPUT = array(
        'system:id',
        'name',
        'precursor',
        'successor',
        'emerged',
        'merged',
        'related-organisations'
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
        'acronym',
        'about: formatted',
        'place',
        'year-founded',
        'year-dissolved',
        'logo',
        'precursor',
        'successor',
        'emerged',
        'merged',
        'related-organisations',
        'identifiers',
        'links',
        'minor',
        'parent',
        'minor-type',
        'type',
        'timeline'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'precursor' => array(
            'section_id' => '4',
            'field_id' => '13',
            'elements' => array(
                'name',
                'minor',
                'parent'
            )
        ),
        'successor' => array(
            'section_id' => '4',
            'field_id' => '13',
            'elements' => array(
                'name',
                'minor',
                'parent'
            )
        ),
        'emerged' => array(
            'section_id' => '4',
            'field_id' => '13',
            'elements' => array(
                'name',
                'minor',
                'parent'
            )
        ),
        'merged' => array(
            'section_id' => '4',
            'field_id' => '13',
            'elements' => array(
                'name',
                'minor',
                'parent'
            )
        ),
        'related-organisations' => array(
            'section_id' => '4',
            'field_id' => '13',
            'elements' => array(
                'name',
                'minor',
                'parent'
            )
        ),
        'type' => array(
            'section_id' => '40',
            'field_id' => '348',
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
            'name' => 'Organisation - Single',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://www.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2022-07-28T16:41:21+00:00'
        );
    }

    public function getSource()
    {
        return '4';
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
