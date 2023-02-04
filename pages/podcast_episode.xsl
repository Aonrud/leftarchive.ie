<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:math="http://exslt.org/math"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
	xmlns:podcast="https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md"
	exclude-result-prefixes="exsl math dc atom itunes podcast">

<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/general-datetime.xsl"/>
<xsl:import href="../utilities/section-podcast.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:variable name="valid">
	<xsl:choose>
		<xsl:when test="/data/podcast-rss-feed/rss/channel/item/itunes:episode = /data/params/no">Yes</xsl:when>
		<xsl:otherwise>No</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:template match="/data">
	<xsl:choose>
		<xsl:when test="$valid = 'Yes'">
			<xsl:apply-templates select="podcast-rss-feed/rss/channel/item[itunes:episode = /data/params/no]" />
		</xsl:when>
		<xsl:otherwise>
			<!--This should really be 404-->
			<h1>Episode Not Found: <xsl:value-of select="/data/params/no" /></h1>
			<p>The episode you requested doesn't exist.</p>
			<p><a href="/podcast/" class="btn btn-success"><span class="fas fa-arrow-left"></span> Return to the podcast index</a></p>
		</xsl:otherwise>
	</xsl:choose>		
</xsl:template>

<xsl:template match="channel/item">
	<header class="page-header">
		<h1 about="#episode">#<span property="schema:episodeNumber"><xsl:value-of select="itunes:episode" /></span>: <span property="schema:name"><xsl:value-of select="title" /></span></h1>
	</header>
	<div class="row">
		<div class="col-sm-9" resource="#episode" typeof="schema:PodcastEpisode">
			<xsl:apply-templates select="." mode="meta" />
			<iframe frameborder="0" scrolling="no" src="{link}/embed" width="100%" class="segmented"></iframe>
			<div class="alert alert-warning">
				To comment, subscribe and follow, <a href="{link}" property="schema:url schema:discussionUrl" class="alert-link">view this episode on our podcast site <span class="fas fa-arrow-right"></span></a>
			</div>
			<xsl:value-of select="description" disable-output-escaping="yes" />
			<div class="lead text-center">
				<xsl:apply-templates select="/data/podcast-rss-feed/rss/channel" mode="icons" />
			</div>
		</div>
		<aside class="col-sm-3">
			<xsl:apply-templates select="/data/podcast-rss-feed/rss/channel" mode="aside">
				<xsl:with-param name="current" select="/data/params/no" />
			</xsl:apply-templates>
		</aside>
	</div>
</xsl:template>

<xsl:template name="head-insert">
	<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/podcastfont.min.css" />
</xsl:template>

<xsl:template name="page-title">
	<xsl:choose>
		<xsl:when test="$valid = 'Yes'">
			Episode #<xsl:value-of select="/data/params/no" />: <xsl:value-of select="/data/podcast-rss-feed/rss/channel/item[itunes:episode = /data/params/no]/title" />
		</xsl:when>
		<xsl:otherwise>Not Found</xsl:otherwise>
	</xsl:choose>
	<xsl:text> — Irish Left Archive Podcast</xsl:text>
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Podcast'" />
		<xsl:with-param name="link" select="'/podcast/'" />
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active">
			<xsl:if test="/data/params/filter = ''">Yes</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="concat('Episode ', /data/params/no)" />
		<xsl:with-param name="link" select="concat('/podcast/episode/', /data/params/no, '/')" />
		<xsl:with-param name="position" select="'3'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
