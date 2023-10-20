<?php

class datasourceinternational_links_list_organisation extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'international-links-list-organisation';
    public $dsParamORDER = 'asc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamREQUIREDPARAM = '$id';
    public $dsParamPARAMOUTPUT = array(
        'international'
    );
    public $dsParamSORT = 'year-in';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        '199' => '{$ds-organisations-minor.system-id},{$ds-organisation-single.system-id}',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'international',
        'organisation',
        'year-in',
        'year-out',
        'type'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'international' => array(
            'section_id' => '24',
            'field_id' => '187',
            'elements' => array(
                'name',
                'about: formatted',
                'year-founded',
                'year-dissolved',
                'type',
                'logo',
                'minor',
                'parent'
            )
        )
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-organisations-minor.system-id', '$ds-organisation-single.system-id');
    }

    public function about()
    {
        return array(
            'name' => 'International Links - List - Organisation',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://www.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2020-01-24T08:14:15+00:00'
        );
    }

    public function getSource()
    {
        return '26';
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
