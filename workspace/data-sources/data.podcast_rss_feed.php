<?php

require_once(EXTENSIONS . '/remote_datasource/data-sources/datasource.remote.php');

class datasourcepodcast_rss_feed extends RemoteDatasource {

    public $dsParamROOTELEMENT = 'podcast-rss-feed';
    public $dsParamURL = 'https://podcast.leftarchive.ie/@ILAPodcast/feed.xml';
    public $dsParamFORMAT = 'xml';
    public $dsParamXPATH = '/';
    public $dsParamCACHE = 1440;
    public $dsParamTIMEOUT = 10;

    public $dsParamNAMESPACES = array(
        'itunes' => 'http://www.itunes.com/dtds/podcast-1.0.dtd',
        'podcast' => 'https://podcastindex.org/namespace/1.0',
        'atom' => 'http://www.w3.org/2005/Atom',
        'content' => 'http://purl.org/rss/1.0/modules/content/',
    );

    public function __construct($env=NULL, $process_params=true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'Podcast RSS Feed',
            'author' => array(
                'name' => 'Aon Rud',
                'website' => 'https://www.leftarchive.ie',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.7.10',
            'release-date' => '2023-02-06T13:00:28+00:00'
        );
    }

    public function allowEditorToParse()
    {
        return true;
    }

}
