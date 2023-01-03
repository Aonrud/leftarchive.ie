<?php

class datasourcedocuments_list extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'documents-list';
    public $dsParamORDER = 'asc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamPARAMOUTPUT = array(
        'authors',
        'contributors'
        );
    public $dsParamSORT = 'year';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        'system:id' => '{$ds-collection-single.documents}',
        '92' => '{$ds-publication-single.system-id},{$ds-publications-minor.system-id}',
        '149' => '{$ds-person-single.system-id},{$ds-people-minor.system-id}',
        '275' => '{$ds-subject-single.system-id},{$ds-subjects-included.system-id}',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'name',
        'subtitle',
        'organisation',
        'publication',
        'cover-image',
        'uncertain',
        'year',
        'authors',
        'type',
        'volume',
        'issue',
        'series',
        'issue-period',
        'subjects'
    );
    
    public $dsParamINCLUDEDASSOCIATIONS = array(
        'organisation' => array(
            'section_id' => '4',
            'field_id' => '13',
            'elements' => array(
                'name',
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
                'minor',
                'parent'
            )
        )
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-collection-single.documents', '$ds-publication-single.system-id', '$ds-publications-minor.system-id', '$ds-person-single.system-id', '$ds-people-minor.system-id', '$ds-subject-single.system-id', '$ds-subjects-included.system-id');
    }

    public function about()
    {
        return array(
            'name' => 'Documents - List',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://www.clririshleftarchive.org',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.3',
            'release-date' => '2018-05-03T07:04:36+00:00'
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
