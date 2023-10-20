<?php

class datasourceextracts_inline extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'extracts-inline';
    public $dsParamORDER = 'asc';
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
        'system:id' => '{$ds-article-single.inline-images:$ds-article-list-rss.inline-images:$ds-articles-list-rss:$ds-collection-single.inline-images:$ds-podcast-single.inline:$ds-podcast-feed.inline:$ds-calendar-events-this-day.inline:null}',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'name',
        'image',
        'caption',
        'transcription: unformatted',
        'document',
        'document-page'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-article-single.inline-images', '$ds-article-list-rss.inline-images', '$ds-articles-list-rss', '$ds-collection-single.inline-images', '$ds-podcast-single.inline', '$ds-podcast-feed.inline', '$ds-calendar-events-this-day.inline');
    }

    public function about()
    {
        return array(
            'name' => 'Extracts - Inline',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://www.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2022-06-08T17:00:36+00:00'
        );
    }

    public function getSource()
    {
        return '29';
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
