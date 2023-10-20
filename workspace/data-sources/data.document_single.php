<?php

class datasourcedocument_single extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'document-single';
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
        'organisation',
        'publication',
        'clr-page',
        'authors',
        'contributors'
    );
    public $dsParamSORT = 'system:id';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'yes';

    public $dsParamFILTERS = array(
        'system:id' => '{$id}',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'name',
        'subtitle',
        'organisation',
        'publication',
        'front-text: formatted',
        'added',
        'document',
        'cover-image',
        'clr-page',
        'uncertain',
        'year',
        'month',
        'day',
        'about: formatted',
        'authors',
        'contributors',
        'uncredited',
        'volume',
        'issue',
        'series',
        'issue-period',
        'edition',
        'subjects',
        'type',
        'errata',
        'copyright'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'organisation' => array(
            'section_id' => '4',
            'field_id' => '13',
            'elements' => array(
                'name',
                'irish',
                'acronym',
                'about: formatted',
                'year-founded',
                'year-dissolved',
                'logo',
                'minor',
                'parent',
                'minor-type'
            )
        ),
        'publication' => array(
            'section_id' => '5',
            'field_id' => '16',
            'elements' => array(
                'name',
                'irish',
                'tagline',
                'about: formatted',
                'year-started',
                'year-ended',
                'masthead',
                'masthead-type',
                'minor',
                'parent'
            )
        ),
        'authors' => array(
            'section_id' => '19',
            'field_id' => '144',
            'elements' => array(
                'name',
                'sort-name',
                'minor',
                'parent',
                'minor-type'
            )
        ),
        'contributors' => array(
            'section_id' => '19',
            'field_id' => '144',
            'elements' => array(
                'name',
                'sort-name',
                'minor',
                'parent',
                'minor-type'
            )
        ),
        'uncredited' => array(
            'section_id' => '19',
            'field_id' => '144',
            'elements' => array(
                'name',
                'sort-name',
                'minor',
                'parent',
                'minor-type'
            )
        ),
        'subjects' => array(
            'section_id' => '31',
            'field_id' => '277',
            'elements' => array(
                'name',
                'group',
                'linked'
            )
        ),
        'type' => array(
            'section_id' => '33',
            'field_id' => '301',
            'elements' => array(
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
            'name' => 'Document - Single',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://www.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2022-07-28T16:10:22+00:00'
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
