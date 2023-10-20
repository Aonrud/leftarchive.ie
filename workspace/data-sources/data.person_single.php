<?php

class datasourceperson_single extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'person-single';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'yes';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'yes';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
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
        'sort-name',
        'date',
        'about: formatted',
        'organisations',
        'publications',
        'picture',
        'picture-credit-name',
        'picture-credit-url',
        'picture-licence-name',
        'picture-licence-url',
        'picture-manual-image-credit: formatted',
        'identifiers',
        'links',
        'minor',
        'parent',
        'minor-type'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'organisations' => array(
            'section_id' => '4',
            'field_id' => '13',
            'elements' => array(
                'name',
                'minor',
                'parent',
                'minor-type'
            )
        ),
        'publications' => array(
            'section_id' => '5',
            'field_id' => '16',
            'elements' => array(
                'name',
                'minor',
                'parent'
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
            'name' => 'Person - Single',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://www.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2022-01-26T10:22:22+00:00'
        );
    }

    public function getSource()
    {
        return '19';
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
