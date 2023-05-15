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

<!--Variables to identify current view-->
<xsl:variable name="total-series">
	<xsl:value-of select="math:max(/data/podcast-rss-feed/rss/channel/item/itunes:season)" />
</xsl:variable>

<xsl:variable name="current-series">
	<xsl:choose>
		<xsl:when test="/data/params/series = ''"><xsl:value-of select="$total-series" /></xsl:when>
		<xsl:otherwise><xsl:value-of select="substring-after(/data/params/series, 'series-')" /></xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:variable name="valid">
	<xsl:choose>
		<xsl:when test="$current-series &gt; 0 and $current-series &lt;= $total-series">Yes</xsl:when>
		<xsl:otherwise>No</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:variable name="full-title">
	<xsl:text>Irish Left Archive Podcast</xsl:text>
	<xsl:if test="$valid = 'Yes' and /data/params/series != ''">: Series <xsl:value-of select="$current-series" /></xsl:if>
</xsl:variable>

<!--Main template to select view mode-->
<xsl:template match="/data">
	<xsl:choose>
		<xsl:when test="$valid = 'Yes'">
			<xsl:apply-templates select="podcast-rss-feed/rss/channel" />
		</xsl:when>
		<xsl:otherwise>
			<!--This should really be 404-->
			<h1>Series Not Found: <xsl:value-of select="$current-series" /></h1>
			<p>The series you requested doesn't exist.</p>
			<p><a href="/podcast/" class="btn btn-success"><span class="fas fa-arrow-left"></span> Return to the podcast index</a></p>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="podcast-rss-feed/rss/channel">
	<header class="page-header">
		<h1>
			<span about="#podcast" property="schema:name"><xsl:value-of select="title" /></span>
			<br class="hidden-lg" />
			<small> Exploring Left politics in Ireland past and present</small>
		</h1>
	</header>
	<div>
		<div class="row" resource="#podcast" typeof="schema:PodcastSeries">
			<span property="schema:sameAs" content="{link}"></span>
			<div class="col-xs-9">
				<div class="lead" property="schema:description">
					<xsl:value-of select="description" disable-output-escaping="yes" />
					
					<div class="alert alert-warning">
						To comment, subscribe and follow, <a href="{link}" class="alert-link">visit our podcast site <span class="fas fa-arrow-right"></span></a>
					</div>
				</div>
			</div>
			<div class="col-xs-3 ngl-xs">
				<img src="{image/url}" alt="{image/title}" class="img-responsive" property="image" />
				<div class="lead text-center">
					<xsl:apply-templates select="." mode="icons" />
				</div>
			</div>
		</div>
	</div>
	
	<nav class="segmented">
		<ul class="nav nav-tabs">
			<xsl:call-template name="series-menu-items">
				<xsl:with-param name="count" select="$total-series" />
				<xsl:with-param name="default" select="$total-series" />
			</xsl:call-template>
		</ul>
	</nav>
	
	<ul class="podcast-list media-list">		
		<xsl:apply-templates select="item[itunes:season = $current-series]" />
	</ul>
	
	<div class="text-center segmented">
		<nav class="btn-group">
			<a class="btn btn-default">
				<xsl:choose>
					<xsl:when test="$current-series &lt; $total-series">
						<xsl:attribute name="href">/<xsl:value-of select="/data/params/current-page" />/series-<xsl:value-of select="$current-series + 1" />/</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">btn btn-default disabled</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<span class="fas fa-arrow-left"></span> Newer Series
			</a>
			<a href="/{/data/params/current-page}/" class="btn btn-default">
				<xsl:choose>
					<xsl:when test="$current-series = 1">
						<xsl:attribute name="class">btn btn-default disabled</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="href">/<xsl:value-of select="/data/params/current-page" />/series-<xsl:value-of select="$current-series - 1" />/</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				Older Series <span class="fas fa-arrow-right"></span>
			</a>
		</nav>
	</div>
</xsl:template>

<xsl:template match="channel/item">
	<li class="row" typeof="schema:PodcastEpisode">
		<span property="schema:isPartOf" content="#podcast"></span>
		<div class="col-xs-3">
			<a href="/{/data/params/current-page}/episode/{itunes:episode}/">
				<img alt="Series {itunes:season}, No. {itunes:episode}: " class="bordered img-responsive" src="/image/podcast/{substring-after(itunes:image/@href, 'https://')}" property="schema:image" />
			</a>
		</div>
		<div class="col-xs-9 ngl-xs">
			<h2 class="media-heading">
				<a href="/{/data/params/current-page}/episode/{itunes:episode}/">#<span property="schema:episodeNumber"><xsl:value-of select="itunes:episode" /></span>: <span property="schema:name"><xsl:value-of select="title" /></span></a>
			</h2>
			<xsl:apply-templates select="." mode="meta" />
			<!--This assumes that the first node is a paragraph. The alternative is chopping at the first closing tag,
				but that could be e.g. an <a>-->
			<p property="schema:description"><xsl:value-of select="substring-after(substring-before(description, '&lt;/p'), '&gt;')" disable-output-escaping="yes" /></p>
			
			<a href="/{/data/params/current-page}/episode/{itunes:episode}/" class="btn btn-success" property="schema:sameAs">Episode <xsl:value-of select="itunes:episode" />&#160;<span class="fas fa-arrow-right"></span></a>
		</div>
	</li>
</xsl:template>

<xsl:template name="series-menu-items">
	<xsl:param name="count" />	
	<li>
		<xsl:if test="(substring-after(/data/params/series, 'series-') = $count) or (/data/params/series = '' and $total-series = $count)">
			<xsl:attribute name="class">active</xsl:attribute>
		</xsl:if>
		<a href="/{/data/params/current-page}/series-{$count}/">Series <xsl:value-of select="$count" /></a>
	</li>
	
	<xsl:if test="$count != 1">
		<xsl:call-template name="series-menu-items">
			<xsl:with-param name="count" select="$count - 1" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="head-insert">
	<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/podcastfont.min.css" />
</xsl:template>

<xsl:template name="page-title">
	<xsl:if test="$valid != 'Yes'">Error — </xsl:if>
	<xsl:value-of select="$full-title" />
</xsl:template>


<xsl:template name="canonical-url">
	<xsl:choose>
		<xsl:when test="/data/params/series != ''">
			<xsl:text>https://podcast.leftarchive.ie/@ILAPodcast/episodes?season=</xsl:text>
			<xsl:value-of select="substring-after(/data/params/series, 'series-')" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="/data/params/current-url" />/
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="metadata-general">
	<!--TODO: Need to create a HTML output source of the escaped description in order to apply templates to the result-->
	<xsl:variable name="description"><xsl:value-of select="/data/podcast-rss-feed/rss/channel/description" /></xsl:variable>
	
	<meta name="description" content="{$description}" />
    <meta property="og:title" content="{$full-title}" />
    <meta property="og:url" content="{/data/podcast-rss-feed/rss/channel/link}" />
    <meta property="og:description" content="{$description}" />	
</xsl:template>

<xsl:template name="metadata-image">
	<meta property="og:image" content="{/data/podcast-rss-feed/rss/channel/image/url}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Podcast'" />
		<xsl:with-param name="link" select="'/podcast/'" />
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active">
			<xsl:if test="/data/params/series = ''">Yes</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	
	<xsl:if test="/data/params/series != ''">
		<xsl:call-template name="breadcrumb-list-item">
			<xsl:with-param name="name" select="concat('Series ', substring-after(/data/params/series, 'series-'))" />
			<xsl:with-param name="link" select="concat('/', /data/params/current-page , '/', /data/params/series, '/')" />
			<xsl:with-param name="position" select="'3'" />
			<xsl:with-param name="active" select="'Yes'" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
