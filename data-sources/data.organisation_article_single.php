<?php

class datasourceorganisation_article_single extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'organisation-article-single';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamPARAMOUTPUT = array(
        'system:id'
        );
    public $dsParamSORT = 'system:id';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        'system:id' => '{$ds-article-single.associated}',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'name',
        'acronym',
        'about: formatted',
        'year-founded',
        'year-dissolved',
        'logo',
        'minor',
        'parent',
        'minor-type'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'parent' => array(
            'section_id' => '4',
            'field_id' => '13',
            'elements' => array(
                'name',
                'about: formatted'
            )
        )
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-article-single.associated');
    }

    public function about()
    {
        return array(
            'name' => 'Organisation - Article Single',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'http://dev.clririshleftarchive.org',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.6.7',
            'release-date' => '2016-11-01T12:36:11+00:00'
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
