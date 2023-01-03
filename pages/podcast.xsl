<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/general-strings.xsl"/>
<xsl:import href="../utilities/section-podcast.xsl" />
<xsl:import href="../utilities/section-comments.xsl"/>
<xsl:import href="../utilities/general-datetime.xsl" />
<xsl:import href="../utilities/layout-sidecolumn.xsl" />
	
<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<!-- Single episode page
-->
<xsl:template match="data">
	<header class="page-header">
		<h1 about="#episode" property="schema:name"><span property="schema:episodeNumber"><xsl:value-of select="podcast-single/entry/episode" /></span>: <xsl:value-of select="podcast-single/entry/name" /></h1>
	</header>
	
	<div class="row">
		<div class="col-sm-9">
			<xsl:apply-templates select="podcast-single/entry" />
			<xsl:call-template name="subscribe-box" />
			<xsl:apply-templates select="comments" />
		</div>
		<aside class="col-sm-3">
			<xsl:apply-templates select="podcast-list" mode="aside" />
		</aside>
	</div>
</xsl:template>

<xsl:template match="podcast-single/entry">
	
	<!--Only adds the tracking redirect to published episodes. Plays while in preview won't be logged.-->
	<xsl:variable name="mp3-link">
		<xsl:apply-templates select="mp3" mode="audio-link">
			<xsl:with-param name="add-podtrac">
				<xsl:choose>
					<xsl:when test="status/item = 'Published'">Yes</xsl:when>
					<xsl:otherwise>No</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:variable>
	
	<xsl:variable name="ogg-link">
		<xsl:apply-templates select="ogg" mode="audio-link">
			<xsl:with-param name="add-podtrac">
				<xsl:choose>
					<xsl:when test="status/item = 'Published'">Yes</xsl:when>
					<xsl:otherwise>No</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:variable>

	<article typeof="schema:PodcastEpisode" resource="#episode">
		<xsl:apply-templates select="." mode="meta" />
		
		<span property="schema:isPartOf" resource="/podcast/#podcast" />
		<p property="schema:description" class="hidden">
			<xsl:value-of select="description" />
		</p>
		
		<figure class="podcast-episode">
			<xsl:apply-templates select="image" />
			<audio id="player" controls="controls" preload="none" width="100%">
				<source src="{$ogg-link}" type="audio/ogg" />
				<source src="{$mp3-link}" type="audio/mpeg" />
			</audio>
			<figcaption class="text-muted">
				<p>Direct download:</p>
				<ul>
					<li property="schema:associatedMedia" typeof="schema:AudioObject">
						<a property="schema:contentUrl" href="{$mp3-link}">Mp3 format (<span property="schema:contentSize"><xsl:value-of select="mp3/@size" /></span>)</a>
						<meta property="schema:encodingFormat" content="audio/mpeg" />
					</li>
					<li property="schema:associatedMedia" typeof="schema:AudioObject">
						<a property="schema:contentUrl" href="{$ogg-link}">Ogg format (<span property="schema:contentSize"><xsl:value-of select="ogg/@size" /></span>)</a>
						<meta property="schema:encodingFormat" content="audio/ogg" />
					</li>
				</ul>
			</figcaption>
		</figure>
		
		<xsl:apply-templates select="notes/*" mode="html" />
		
		<footer>
			<xsl:apply-templates select="related" />
			<hr />
			<p><em><xsl:call-template name="podcast-disclaimer" /></em></p>
			<a href="/podcast/" class="btn btn-success btn-spaced"><span class="fas fa-arrow-left"></span> See all podcast episodes</a>
		</footer>
	</article>
</xsl:template>

<xsl:template match="mp3|ogg" mode="audio-link">
	<xsl:param name="add-podtrac" select="'Yes'" />

	<xsl:choose>
		<xsl:when test="$add-podtrac = 'Yes'">
			<xsl:text>https://dts.podtrac.com/redirect.</xsl:text><xsl:value-of select="name()" /><xsl:text>/</xsl:text>
			<xsl:value-of select="/data/params/http-host" />
			<xsl:value-of select="/data/params/workspace-path" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="/data/params/workspace" />
		</xsl:otherwise>
	</xsl:choose>
	<xsl:value-of select="@path" />/<xsl:value-of select="filename" />
</xsl:template>

<xsl:template match="podcast-single/entry/image">
	<div class="image">
		<img src="/image/1/500/0{@path}/{filename}" class="img-responsive" alt="" />
	</div>
</xsl:template>


<!--Podcast list page
-->
<xsl:template match="data[params/episode = '']">
	<header class="page-header">
		<h1><span about="#podcast" property="schema:name">Irish Left Archive Podcast</span><br class="hidden-lg" />
		<small><xsl:value-of select="$podcast-tagline" /></small>
		</h1>
	</header>
	<div class="page-top">
		<div class="row">
			<div class="col-sm-8 col-sm-push-4" resource="#podcast" typeof="schema:PodcastSeries">
				<xsl:call-template name="subscribe-box" />
				
				<div property="schema:description">
					<xsl:attribute name="content">
						<xsl:call-template name="podcast-description" />
					</xsl:attribute>
					<xsl:call-template name="podcast-description-html" />
				</div>
			</div>
			
			<div class="col-sm-4 col-sm-pull-8">
				<img src="/image/1/500/0{$podcast-image}" class="img-responsive hidden-xs" alt="Irish Left Archive Podcast" />
			</div>
		</div>
	</div>
<!--	
	<p class="alert alert-info segmented">
		<span class="fas fa-info-circle fa-lg"></span>
		The podcast is taking a break, but we'll be back with more episodes later in 2022.
	</p>-->
	
	<ul class="podcast-list media-list" data-pages="{podcast-list/pagination/@total-pages}">
		<xsl:apply-templates select="podcast-list/entry" />
	</ul>
	
	<p class="alert alert-info"><xsl:call-template name="podcast-disclaimer" /></p>
</xsl:template>

<xsl:template match="entry/related">
	<aside>
		<h4>Related archive entries:</h4>
		<ul class="list-unstyled">
			<xsl:apply-templates select="item" />
		</ul>
	</aside>
</xsl:template>

<xsl:template match="related/item">
	<li>
		<xsl:call-template name="section-icon">
			<xsl:with-param name="section" select="@section-handle" />
		</xsl:call-template>
		<xsl:apply-templates select="." mode="entry-link" />
	</li>
</xsl:template>

<xsl:template name="subscribe-box">
	<div class="panel panel-success">
		<div class="panel-heading"><h4>Subscribe!</h4></div>
		<div class="panel-body">
			<img src="/image/1/500/0{$podcast-image}" class="img-responsive visible-xs" alt="Irish Left Archive Podcast" />
			<p>Find us in your preferred podcast app by searching for <strong>"Irish Left Archive Podcast"</strong>.</p>
			<p>Or use one of these links:</p>
			<ul class="list-unstyled">
				<li><a href="/podcast/feed/"><span class="fas fa-fw fa-rss-square"></span> RSS Podcast Feed</a></li>
				<li><a href="https://open.spotify.com/show/1JSK1YUbFcO6Lgde0S0Vay"><span class="fab fa-fw fa-spotify"></span> Spotify</a></li>
				<li><a href="https://podcasts.apple.com/ie/podcast/irish-left-archive-podcast/id1526951277"><span class="fab fa-fw fa-apple"></span> Apple Podcasts</a></li>
			</ul>
		</div>
	</div>
</xsl:template>

<xsl:template name="page-title">
	<xsl:if test="/data/params/episode != ''">
		Episode <xsl:value-of select="/data/podcast-single/entry/episode" />: <xsl:value-of select="/data/podcast-single/entry/name" /> — 
	</xsl:if>
	<xsl:text>Irish Left Archive Podcast</xsl:text>
</xsl:template>

<xsl:template name="metadata-image">
	<xsl:choose>
		<xsl:when test="/data/params/episode = ''">
			<xsl:call-template name="metadata-image-list" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="metadata-image-single" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<xsl:variable name="metadata-twitter-card">
	<xsl:choose>
		<xsl:when test="/data/params/episode = ''">summary_large_image</xsl:when>
		<xsl:otherwise>summary</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:template name="metadata-image-list">
	<meta property="og:image" select="{/data/params/workspace}/assets/images/ila-podcast_meta.png" />
	<meta property="og:image:width" content="3438" />
	<meta property="og:image:height" content="1800" />
	<meta property="og:image:alt" content="Irish Left Archive Podcast" />
</xsl:template>

<xsl:template name="metadata-image-single">
	<xsl:apply-templates select="/data/podcast-single/entry/image" mode="metadata-image-raw">
		<xsl:with-param name="alt">Episode <xsl:value-of select="/data/podcast-single/entry/episode" /> of the Irish Left Archive Podcast</xsl:with-param>
	</xsl:apply-templates>
</xsl:template>

<xsl:template name="metadata-general">
	<meta property="og:type" content="article" />
	<xsl:choose>
		<xsl:when test="/data/params/episode = ''">
			<xsl:variable name="podcast-description">
				<xsl:call-template name="strip-newlines">
					<xsl:with-param name="string"><xsl:call-template name="podcast-description" /></xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			
			<meta name="description" content="{$podcast-description}" />
			<meta property="og:title" content="Irish Left Archive Podcast" />
			<meta property="og:description" content="{$podcast-description}" />
			<meta property="og:url" content="{$root}/podcast/" />
		</xsl:when>
		<xsl:otherwise>
			<meta name="description" content="{//data/podcast-single/entry/description}" />
			<meta property="og:title" content="Episode {//data/podcast-single/entry/episode}: {//data/podcast-single/entry/name} — Irish Left Archive Podcast" />
			<meta property="og:description" content="{//data/podcast-single/entry/description}" />
			<meta property="og:url" content="{$root}{/data/params/current-path}/" />
			
			<!--# In theory this is correct metadata, but it doesn't seem to be used by anyone.
			<meta property="og:audio">
				<xsl:attribute name="content">
					<xsl:apply-templates select="/data/podcast-single/entry/mp3" mode="audio-link" />
				</xsl:attribute>
			</meta>
			<meta property="og:audio:type" content="audio/mpeg" />
			<meta property="og:audio">
				<xsl:attribute name="content">
					<xsl:apply-templates select="/data/podcast-single/entry/ogg" mode="audio-link" />
				</xsl:attribute>
			</meta>
			<meta property="og:audio:type" content="audio/ogg" />
			-->
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Podcast'" />
		<xsl:with-param name="link" select="'/podcast/'" />
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active">
			<xsl:choose>
				<xsl:when test="/data/params/episode = ''">Yes</xsl:when>
				<xsl:otherwise>No</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
	</xsl:call-template>
	
	<xsl:if test="/data/params/episode != ''">
		<xsl:call-template name="breadcrumb-list-item">
			<xsl:with-param name="name">
				<xsl:call-template name="word-truncate">
					<xsl:with-param name="string">Episode <xsl:value-of select="/data/podcast-single/entry/episode" />: <xsl:value-of select="/data/podcast-single/entry/name" /></xsl:with-param>
					<xsl:with-param name="lenth" select="'50'" />
					<xsl:with-param name="ellipses" select="'Yes'" />
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="link">
				<xsl:text>/podcast/</xsl:text>
				<xsl:value-of select="/data/podcast-single/entry/url" />
				<xsl:text>/</xsl:text>
			</xsl:with-param>
			<xsl:with-param name="position" select="'3'" />
			<xsl:with-param name="active" select="'Yes'" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="head-insert">
	<link rel="alternate" type="application/rss+xml" title="Irish Left Archive Podcast" href="/podcast/feed/" />
	<link href="{/data/params/workspace}/assets/css/mediaelementplayer.min.css" rel="stylesheet" type="text/css" /> 
</xsl:template>

<xsl:template name="end-insert">
		<script src="{/data/params/workspace}/assets/js/mediaelement-and-player.min.js"></script>
	<script src="{/data/params/workspace}/assets/js/podcast.min.js"></script>
</xsl:template>

</xsl:stylesheet>
