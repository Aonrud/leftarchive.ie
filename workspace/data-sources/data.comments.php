<?php

class datasourcecomments extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'comments';
    public $dsParamORDER = 'asc';
    public $dsParamGROUP = '59';
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
        '55' => '{$ds-document-single.system-id:$ds-document-random.system-id:$ds-organisation-single.system-id:$ds-publication-single.system-id:$ds-pages-single.system-id:$ds-collection-single.system-id:$ds-person-single.system-id:$ds-person-single.system-id:$ds-article-single.system-id:$ds-international-single.system-id:$ds-podcast-single.system-id:$ds-demonstration-single.system-id}',
        '58' => 'yes',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'title',
        'comment: formatted',
        'name',
        'email',
        'website',
        'date',
        'associated-page',
        'parent'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-document-single.system-id', '$ds-document-random.system-id', '$ds-organisation-single.system-id', '$ds-publication-single.system-id', '$ds-pages-single.system-id', '$ds-collection-single.system-id', '$ds-person-single.system-id', '$ds-article-single.system-id', '$ds-international-single.system-id', '$ds-podcast-single.system-id', '$ds-demonstration-single.system-id');
    }

    public function about()
    {
        return array(
            'name' => 'Comments',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://dev.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2022-11-12T14:00:54+00:00'
        );
    }

    public function getSource()
    {
        return '9';
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
