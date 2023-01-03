<?php

class datasourcepodcast_url extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'podcast-url';
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
        'system:id' => '{$ds-comments-recent.associated-page:$ds-calendar-events-this-day.linked}',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'url'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-comments-recent.associated-page', '$ds-calendar-events-this-day.linked');
    }

    public function about()
    {
        return array(
            'name' => 'Podcast URL',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'https://www.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2022-06-11T13:03:55+00:00'
        );
    }

    public function getSource()
    {
        return '41';
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
