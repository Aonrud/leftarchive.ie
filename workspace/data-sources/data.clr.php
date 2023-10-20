<?php

require_once(EXTENSIONS . '/remote_datasource/data-sources/datasource.remote.php');

class datasourceclr extends RemoteDatasource {

    public $dsParamROOTELEMENT = 'clr';
    public $dsParamURL = 'https://cedarlounge.wordpress.com/feed/';
    public $dsParamFORMAT = 'xml';
    public $dsParamXPATH = '/rss/channel/item[position() &lt; 6]';
    public $dsParamCACHE = 5;
    public $dsParamTIMEOUT = 6;

    public $dsParamNAMESPACES = array(
			'content' => 'http://purl.org/rss/1.0/modules/content/',
			'wfw' => 'http://wellformedweb.org/CommentAPI/',
			'dc' => 'http://purl.org/dc/elements/1.1/',
			'atom' => 'http://www.w3.org/2005/Atom',
			'sy' => 'http://purl.org/rss/1.0/modules/syndication/',
			'slash' => 'http://purl.org/rss/1.0/modules/slash/',
			'georss' => 'http://www.georss.org/georss',
			'geo' => 'http://www.w3.org/2003/01/geo/wgs84_pos#',
			'media' => 'http://search.yahoo.com/mrss/',
		);

    public function __construct($env=NULL, $process_params=true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'CLR',
            'author' => array(
                'name' => 'Aonrud',
                'website' => 'http://dev.clririshleftarchive.org',
                'email' => 'admin@leftarchive.ie'),
            'version' => 'Symphony 2.6.2',
            'release-date' => '2015-05-26T09:05:32+00:00'
        );
    }

    public function allowEditorToParse()
    {
        return true;
    }

}
