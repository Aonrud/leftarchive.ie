<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="dc">

<xsl:import href="layout-search.xsl"/>
<xsl:import href="general-datetime.xsl"/>
<xsl:import href="general-year-range.xsl" />
<xsl:import href="section-comments-recent.xsl"/>
<xsl:import href="section.xsl"/>
<xsl:import href="section-podcast.xsl"/>
<xsl:import href="section-demonstrations.xsl"/>

<!--# Provides templates to be called by name for use in the sidecolumn.
	#
	# sidecolumn-podcast
	# sidecolumn-snapshots
	# sidecolumn-related
	#	Shows related organisations, internationals or publications, depending on relevant page
	# sidecolumn-comments
	# sidecolumn-clr
	# sidecolumn-fediverse
-->

<!--# Named template with default order of all blocks.
-->
<xsl:template name="sidecolumn">
	<hr class="visible-xs" />
	<div class="visible-sm">
		<xsl:call-template name="search-small" />
	</div>
	<xsl:call-template name="sidecolumn-fediverse" />
	<xsl:if test="not(/data/demonstrations-document/entry)">
        <xsl:call-template name="sidecolumn-snapshots" />
	</xsl:if>
	<xsl:call-template name="sidecolumn-related" />
	<xsl:call-template name="sidecolumn-podcast" />
	<xsl:call-template name="sidecolumn-personal-accounts" />
	<xsl:call-template name="sidecolumn-comments" />
</xsl:template>

<xsl:template name="sidecolumn-personal-accounts">
    <div class="pa">
        <h2>Personal Accounts</h2>
        <p>The Irish Left Archive hopes to collate first-hand political reminiscences or observations from people involved in Irish Left political activity over the years. We'd be grateful to anyone who has been involved in political parties, campaigns or activism who would like to provide us an account of their personal experience.</p>
        <div class="text-center"><a class="btn btn-success" href="/personal-accounts/submit/">Add your experience <span class="fas fa-arrow-right"></span></a></div>
    </div>
</xsl:template>

<!--# Podcast
-->
<xsl:template name="sidecolumn-podcast">
    <xsl:apply-templates select="/data/podcast-rss-feed/rss/channel" mode="aside">
        <xsl:with-param name="footer" select="'No'" />
    </xsl:apply-templates>
</xsl:template>


<!--# Show related entries in a panel block.
	# @depends (page specific)
	#	Org page - 'international-links-list-organisation' DS
	#	Int page - 'organisation-links-international' DS
-->
<xsl:template name="sidecolumn-related">
	<!--Linked internationals, for organisation pages-->
	<xsl:apply-templates select="/data/international-links-list-organisation" mode="linked-info" />
	
	<!--Linked organisations, for international pages-->
	<xsl:apply-templates select="/data/organisation-links-international" mode="linked-info" />
	
	<!--Linked org. or pub., for document pages-->
	<xsl:apply-templates select="/data/document-single/entry" mode="linked-info" />
	
	<!--Linked org., for publication pages-->
	<xsl:apply-templates select="/data/publication-single/entry" mode="linked-info" />
</xsl:template>

<!--# List recent comments.
	# @depends 'comments-recent' DS
-->
<xsl:template name="sidecolumn-comments">
	<xsl:apply-templates select="/data/comments-recent" />
</xsl:template>

<!--# Latest CLR posts.
	# @depends 'clr' DS
-->
<xsl:template name="sidecolumn-clr">
	<xsl:apply-templates select="/data/clr" />
</xsl:template>

<!--# Link to Microblog.pub instance to follow
-->
<xsl:template name="sidecolumn-fediverse">
    <div class="card">
        <div class="social-header">
            <a href="https://posts.leftarchive.ie/">
                <h3>Irish Left Archive</h3>
                <p>@ila@leftarchive.ie</p>
            </a>
        </div>
        <div class="card-body">
            <p>Follow us on the <a href="#" class="tooltip-def" data-toggle="tooltip" data-placement="bottom" title="The Fediverse includes Mastodon, Pixelfed, Peertube and many other compatible platforms">Fediverse</a> for updates.</p>
            <a href="https://posts.leftarchive.ie/remote_follow" class="btn btn-primary" title="Follow us from any federated account like Mastodon, Pixelfed or Peertube"><span class="fas fa-user-plus"></span> Follow <span class="fas fa-arrow-right"></span></a>
        </div>
    </div>
</xsl:template>


<!-- Matching templates
#######################################################
-->

<xsl:template match="/data/comments-recent">
	<h4>Recent Comments</h4>
	<ul class="list-unstyled">
		<xsl:apply-templates select="entry" />
	</ul>
</xsl:template>

<xsl:template match="/data/clr">
	<h4>Latest on the <abbr title="Cedar Lounge Revolution">CLR</abbr></h4>
	<ul class="list-unstyled">
		<xsl:apply-templates select="item" />
	</ul>
</xsl:template>

<xsl:template match="/data/clr/item">
	<xsl:variable name="date-content">
		<xsl:value-of select="pubDate" />
	</xsl:variable>
	
	<li>
		<a href="{link}" class="external-link"><xsl:value-of select="title" /> <span class="fas fa-external-link-alt"></span></a>
		<br />
		<small class="text-muted">By: <xsl:value-of select="dc:creator" /> | <xsl:value-of select="substring-after(substring-before($date-content, '+'), ', ')" /></small>
	</li>
</xsl:template>

<xsl:template match="international-links-list-organisation" mode="linked-info">
	<!-- Entry ordering filters:
		1. Show Internationals first, then others (EU group etc.)
		2. Show those linked to main org. entry first, then others (puts e.g. youth wing federation at the bottom).
		2. Don't show entries twice. Exclude if there is a previous sibling node containing the same international, by ID.
	-->
	
    <xsl:apply-templates select="entry[international/item/type/item = 'International'][organisation/item/@id = /data/organisation-single/entry/@id][not(preceding-sibling::entry/international/item/@id = international/item/@id)]" mode="linked-info" />
    <xsl:apply-templates select="entry[international/item/type/item != 'International'][organisation/item/@id = /data/organisation-single/entry/@id][not(preceding-sibling::entry/international/item/@id = international/item/@id)]" mode="linked-info" />
    
    <!--Internationals linked to associated minor org. entries-->
    <xsl:apply-templates select="entry[international/item/type/item = 'International'][organisation/item/@id != /data/organisation-single/entry/@id][not(preceding-sibling::entry/international/item/@id = international/item/@id)]" mode="linked-info" />
    <xsl:apply-templates select="entry[international/item/type/item != 'International'][organisation/item/@id != /data/organisation-single/entry/@id][not(preceding-sibling::entry/international/item/@id = international/item/@id)]" mode="linked-info" />
</xsl:template>

<xsl:template match="organisation-links-international" mode="linked-info">
	<!--Same filter logic as the reverse template above-->
    <xsl:apply-templates select="entry[organisation/item/place/item = 'Ireland'][not(preceding-sibling::entry/organisation/item/@id = organisation/item/@id)]" mode="linked-info" />
    <xsl:apply-templates select="entry[organisation/item/place/item != 'Ireland'][not(preceding-sibling::entry/organisation/item/@id = organisation/item/@id)]" mode="linked-info" />
</xsl:template>

<xsl:template match="entry" mode="linked-info">
    <xsl:apply-templates select="organisation[name(../..) != 'international-links-list-organisation']/item" mode="info" />
    <!--For publication pages, where inconsistency has caught me out-->
    <xsl:apply-templates select="organisations/item" mode="info" />
    <xsl:apply-templates select="publication/item" mode="info" />
    <xsl:apply-templates select="international/item" mode="info" />
</xsl:template>

<xsl:template match="item" mode="info">        
    <xsl:variable name="link-id">
        <xsl:choose>
            <xsl:when test="minor = 'Yes'"><xsl:value-of select="parent/item/@id" /></xsl:when>
            <xsl:otherwise><xsl:value-of select="@id" /></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="link">
        <xsl:call-template name="get-url">
            <xsl:with-param name="section" select="@section-handle" />
            <xsl:with-param name="id" select="$link-id" />
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="link-name">
        <xsl:choose>
            <xsl:when test="minor = 'Yes'"><xsl:value-of select="parent/item" /></xsl:when>
            <xsl:otherwise><xsl:value-of select="name" /></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">
                <xsl:call-template name="section-icon">
                    <xsl:with-param name="section" select="@section-handle" />
                </xsl:call-template>
                <a href="{$link}"><xsl:value-of select="name" /></a>
            </h3>
        </div>
        <div class="panel-body">
        
            <!--Organisations have logo image-->
            <xsl:if test="logo">
                <p><img src="/image/1/200/0/{logo/@path}/{logo/filename}" alt="{name}" class="img-responsive center-block" /></p>
            </xsl:if>
            
            <!--Publications have mastead image-->
            <xsl:if test="masthead">
                <p><img src="/image/1/200/0/{masthead/@path}/{masthead/filename}" alt="{name}" class="img-responsive center-block" /></p>
            </xsl:if>
            <p>
                <span class="fas fa-calendar fa-fw"></span>
                <xsl:call-template name="year-range">
                    <xsl:with-param name="first">
                        <xsl:choose>
                            <xsl:when test="@section-handle = 'organisations' or @section-handle = 'international'"><xsl:value-of select="year-founded" /></xsl:when>
                            <xsl:otherwise><xsl:value-of select="year-started" /></xsl:otherwise>
                        </xsl:choose>
                    </xsl:with-param>
                    <xsl:with-param name="last">
                        <xsl:choose>
                            <xsl:when test="@section-handle = 'organisations' or @section-handle = 'international'"><xsl:value-of select="year-dissolved" /></xsl:when>
                            <xsl:otherwise><xsl:value-of select="year-ended" /></xsl:otherwise>
                        </xsl:choose>
                    </xsl:with-param>
                </xsl:call-template>
            </p>
            
            <xsl:if test="normalize-space(about) != ''">
                <xsl:apply-templates select="about" mode="brief"/>
            </xsl:if>
            
            <p><a href="{$link}"><strong>See <xsl:value-of select="$link-name" /> in the archive <span class="fas fa-angle-double-right"></span></strong></a></p>
        </div>
    </div>
</xsl:template>

<xsl:template match="about" mode="brief">
    <p>
        <xsl:value-of select="substring(./*[1], 1, 300)" />
        <xsl:if test="string-length(./*[1] &gt; 300)">&#8230;</xsl:if>
    </p>
</xsl:template>

</xsl:stylesheet>
