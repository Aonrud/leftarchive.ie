<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="dc">

<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/general-datetime.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/page-home-carousel.xsl"/>
<xsl:import href="../utilities/page-home-tracker.xsl"/>
<xsl:import href="../utilities/general-strings.xsl"/>
<xsl:import href="../utilities/section-documents.xsl"/>
<xsl:import href="../utilities/section-podcast.xsl"/>
<xsl:import href="../utilities/section-demonstrations.xsl"/>
<xsl:import href="../utilities/section-comments-recent.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">

    <div class="intro">
        <div class="row">
            <div class="col-sm-4 intro-text">
                <p>The <strong>Irish Left Archive</strong> is an online archive of materials relating to Irish left politics<span class="hidden-sm">, freely accessible and easy to download and reproduce</span>.
                </p><p>
                It was initiated by the <a href="http://cedarlounge.wordpress.com" title="Visit the Cedar Lounge Revolution blog." class="external-link">Cedar Lounge Revolution<span class="fas fa-external-link-alt"> </span></a>.</p>
            </div>

            <div class="col-sm-8">
                <xsl:call-template name="carousel" />
            </div>
        </div>
    </div><!--intro-->
    
    <!--On this day-->
    <xsl:call-template name="on-this-day" />
        
    <div class="row">
        
        <div class="col-sm-8">
            <xsl:call-template name="search-form" mode="full" />
        </div>

        <div class="col-sm-4">
            <xsl:apply-templates select="/data/section-count" />
        </div>
    </div><!--row-->

    <!--Snapshots of poltical action-->
    <xsl:call-template name="snapshots-banner">
        <xsl:with-param name="button" select="'Yes'" />
    </xsl:call-template>
    
    <!--No row, due to full width-->
    <h4><span class="far fa-file-lines fa-fw text-muted"></span> Recent Material</h4>
    <div class="row">
        <xsl:apply-templates select="documents-recent/entry[position() &lt;= 6]" mode="documents-thumbnails">
            <xsl:with-param name="cols-xs" select="'6'" />
            <xsl:with-param name="cols-sm" select="'4'" />
            <xsl:with-param name="cols-md" select="'2'" />
        </xsl:apply-templates>
    </div>
    
    <!--Personal accounts strip-->
    <div class="pa">
        <div class="row">
        <div class="col-sm-4"><h2>Personal Accounts</h2></div>
        <div class="col-sm-8">
            <div class="content">
				<p>The Irish Left Archive hopes to collate first-hand political reminiscences or observations from people involved in Irish Left political activity over the years. <span class="hidden-xs">We'd be grateful to anyone who has been involved in political parties, campaigns or activism who would like to provide us an account of their personal experience.</span></p>
				<ul class="list-inline">
					<li><a class="btn btn-success" href="/personal-accounts/submit/">Add your experience <span class="fas fa-arrow-right"></span></a></li>
					<li><a class="btn btn-primary" href="/personal-accounts/">View Accounts</a></li>
				</ul>
            </div>
            <span class="fas fa-pen-fancy bg-icon"></span>
        </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-sm-4">
            <xsl:apply-templates select="podcast-list" mode="aside">
                <xsl:with-param name="max-episodes" select="'3'" />
                <xsl:with-param name="footer" select="'No'" />
            </xsl:apply-templates>
        </div>
        
        <div class="col-sm-4">
            <div class="panel panel-default latest-changes">
                <div class="panel-heading"><h4 class="panel-title">Latest Updates</h4></div>
                <div class="panel-body">
                    <ul class="list-unstyled">
                    <xsl:apply-templates select="/data/latest-changes/activity[position() &lt;= 5]" />
                    </ul>
                </div>
            </div>
            
            <div class="panel panel-default">
                <div class="panel-heading"><h4 class="panel-title">Latest Comments</h4></div>
                <div class="panel-body">
                    <ul class="list-unstyled">
                        <xsl:apply-templates select="comments-recent/entry" />
                    </ul>
                </div>
            </div>
        </div>
    
        <div class="col-sm-4">
            <div class="panel panel-default">
                <div class="panel-heading"><h4 class="panel-title">Collections</h4></div>
                <div class="list-group">
                    <xsl:apply-templates select="collections-recent/entry[position() &lt;= 3]" />
                </div>
            </div>
            
            <div class="panel panel-default">
                <div class="panel-heading"><h4 class="panel-title">Articles</h4></div>
                <div class="list-group">
                    <xsl:apply-templates select="articles-recent/entry[position() &lt;= 5]" />
                </div>
            </div>
            
        </div>
    </div>

    <aside class="row">
        <hr />
        <div class="col-xs-12">
            <h4>Latest on the <abbr title="Cedar Lounge Revolution">CLR</abbr><xsl:text> </xsl:text><span class="fas fa-rss text-muted"></span></h4>
            <div class="row">
                <xsl:apply-templates select="clr/item[position() &lt;= 4]" />
            </div>
        </div>
    </aside>

</xsl:template>

<xsl:template match="section-count">
<div class="panel panel-primary panel-browse">
    <div class="panel-heading"><h3 class="panel-title"><span class="fas fa-box fa-fw"></span> In the Archive</h3></div>
    <div class="list-group">
        <xsl:apply-templates select="section[@id = '6']" />
        <xsl:apply-templates select="section[@id = '4']" />
        <xsl:apply-templates select="section[@id = '24']" />
        <xsl:apply-templates select="section[@id = '5']" />
        <xsl:apply-templates select="section[@id = '19']" />
        <xsl:apply-templates select="section[@id = '46']" />
        <xsl:apply-templates select="section[@id = '17']" />
        <xsl:apply-templates select="section[@id = '15']" />
    </div>
</div>
</xsl:template>

<xsl:template match="section-count/section">
    <a class="list-group-item">
        <xsl:attribute name="href">
            <xsl:call-template name="section-root">
                <xsl:with-param name="section-id" select="@id" />
            </xsl:call-template>
        </xsl:attribute>
        <xsl:call-template name="section-icon">
            <xsl:with-param name="section-id" select="@id" />
        </xsl:call-template>
        <span><xsl:value-of select="count" />&#160;</span>
        <xsl:call-template name="section-shortname">
            <xsl:with-param name="section-id" select="@id" />
        </xsl:call-template>
    </a>
</xsl:template>

<xsl:template name="on-this-day">
    <xsl:if test="/data/calendar-events-this-day[entry]|/data/demonstrations-this-day[entry]">
        <xsl:variable name="display-date">
            <xsl:call-template name="format-date">
                <xsl:with-param name="date" select="/data/params/today" />
                <xsl:with-param name="format" select="'D M'" />
            </xsl:call-template>
        </xsl:variable>
        
        <div class="flex-row otd">
        <div class="otd-entry">
            <h3><span class="fas fa-calendar"></span> On this day <xsl:value-of select="$display-date" />…</h3>
        </div>
        
        <xsl:apply-templates select="(/data/calendar-events-this-day/entry|/data/demonstrations-this-day/entry)[position() &lt;= 3]" />

        <xsl:if test="count(/data/calendar-events-this-day/entry|/data/demonstrations-this-day/entry) &lt; 3 and (/data/documents-this-day/entry or /data/subjects-this-day/entry)">
            <div class="otd-extra">
                <h5>… Also:</h5>
                <ul>
                    <xsl:if test="/data/documents-this-day/entry">
                        <li>
                            <xsl:call-template name="section-icon"><xsl:with-param name="section" select="'documents'" /></xsl:call-template><a href="/on-this-day/#documents">Documents published on <xsl:value-of select="$display-date" /></a>
                        </li>
                    </xsl:if>
                    <xsl:if test="/data/subjects-this-day/entry">
                    <li>
                        <xsl:call-template name="section-icon"><xsl:with-param name="section" select="'Subjects'" /></xsl:call-template><a href="/on-this-day/#subjects">Subject headings from <xsl:value-of select="$display-date" /></a>
                    </li>
                    </xsl:if>
                </ul>
            </div>
        </xsl:if>
    </div>
    </xsl:if>
</xsl:template>

<xsl:template match="calendar-events-this-day/entry|demonstrations-this-day/entry">
    <div class="otd-entry">
        <a href="/on-this-day/#event-{@id}">
            <div class="label label-primary">
                <xsl:call-template name="format-date">
                    <xsl:with-param name="date" select="date" />
                    <xsl:with-param name="format" select="'Y'" />
                </xsl:call-template>
            </div>
            <h5>… <xsl:value-of select="name" /></h5>
        </a>
    </div>
</xsl:template>

<xsl:template match="collections-recent/entry">
    <a href="/collection/{@id}/" class="list-group-item">
        <h5 class="list-group-item-heading"><xsl:value-of select="name" /></h5>
        <p class="list-group-item-text"><small><xsl:value-of select="summary" /></small></p>
    </a>
</xsl:template>

<xsl:template match="articles-recent/entry">
    <a href="/article/{@id}/" class="list-group-item">
        <h5 class="list-group-item-heading"><xsl:value-of select="name" /></h5>
        <p class="list-group-item-text">
			<xsl:call-template name="section-icon">
				<xsl:with-param name="section" select="associated/item/@section-handle" />
			</xsl:call-template>
			<xsl:value-of select="associated/item" /><br />
			<small>
				Commentary from <xsl:value-of select="from" />
			</small>
		</p>
    </a>
</xsl:template>

<xsl:template match="clr/item">
    <xsl:variable name="description-content">
        <xsl:value-of select="description" />
    </xsl:variable>
    
    <xsl:variable name="date-content">
        <xsl:value-of select="pubDate" />
    </xsl:variable>
    
    <div class="col-sm-3">
        <h5><a href="{link}" class="external-link"><xsl:value-of select="title" /><span class="fas fa-external-link-alt"> </span></a></h5>
        <p class="text-muted"><small>By: <xsl:value-of select="dc:creator" /> | <xsl:value-of select="substring-before($date-content, '+')" /></small></p>
        <!--This was here to strip the tracking pixel from Wordpress. Possibly removed-->
        <!--<p><xsl:value-of select="substring-before($description-content,'&lt;img')" disable-output-escaping="yes" /></p>-->
        <p><xsl:value-of select="$description-content" disable-output-escaping="yes" /></p>
    </div>
</xsl:template>

<xsl:template name="page-title">
Irish Left Archive — Digital archive of Irish left politics
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">The Irish Left Archive is an online archive of documents and material relating to the Irish political left, freely accessible and easily downloaded and reproduced.</xsl:variable>

	<meta name="description" content="{$description}" />

	<meta property="og:type" content="website" />
	<meta property="og:title" content="Irish Left Archive" />
	<meta property="og:url" content="https://www.leftarchive.ie/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

</xsl:stylesheet>
