<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="layout-breadcrumb.xsl"/>
<xsl:import href="layout-footer.xsl"/>
<xsl:import href="general-html.xsl"/>
<xsl:import href="metadata-dublincore.xsl"/>
<xsl:import href="metadata-general.xsl"/>
<xsl:import href="metadata-matomo.xsl"/>
<xsl:import href="layout-navigation.xsl"/>
<xsl:import href="entry.xsl" />

<xsl:template match="/">
	<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!DOCTYPE html<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
	<html lang="en" prefix="dc: http://purl.org/dc/elements/1.1/
							schema: http://schema.org/ 
							og: http://ogp.me/ns# 
							twitter: https://dev.twitter.com/cards/markup#">
		<head resource="#md">
			<meta charset="utf-8" />
			<title><xsl:call-template name="page-title" /></title>
			<xsl:call-template name="viewport" />
			<link rel="canonical">
				<xsl:attribute name="href">
					<xsl:choose>
						<xsl:when test="/data/params/page-types/item = 'index'"><xsl:value-of select="/data/params/root" />/</xsl:when>
						<xsl:otherwise><xsl:value-of select="/data/params/current-url" />/</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
			</link>
			
			<!--These are hidden on the podcast page, as they can create ambiguity with the podcast feed for crawlers-->
			<xsl:if test="/data/params/current-page-id != '52'">
				<link rel="alternate" type="application/rss+xml" title="Irish Left Archive Feed" href="/rss/" />
				<link rel="alternate" type="application/rss+xml" title="Irish Left Archive Comments Feed" href="/rss/comments/" />
			</xsl:if>
			
			<link href="{$workspace}/assets/css/leftarchive.css?v=20230123" rel="stylesheet" type="text/css" />    
			<link rel="search" type="application/opensearchdescription+xml" href="{/data/params/workspace}/assets/opensearch.xml" title="Irish Left Archive Search" />
			
			<!--All those bloody icons-->
			<link rel="apple-touch-icon" sizes="144x144" href="{$workspace}/assets/images/icons/apple-touch-icon-144x144.png" />
			<link rel="apple-touch-icon" sizes="114x114" href="{$workspace}/assets/images/icons/apple-touch-icon-114x114.png" />
			<link rel="apple-touch-icon" sizes="72x72" href="{$workspace}/assets/images/icons/apple-touch-icon-144x144.png" />
			<link rel="apple-touch-icon" sizes="57x57" href="{$workspace}/assets/images/icons/apple-touch-icon-114x114.png" />
			<link rel="shortcut icon" href="{$workspace}/assets/images/icons/favicon-32x32.png" />

			<script src="{$workspace}/assets/js/jquery.min.js"></script>
			<script src="{$workspace}/assets/js/cookies.min.js"></script>

			<xsl:call-template name="head-insert" />

			<script src="{$workspace}/assets/js/leftarchive.min.js?v=20221116"></script>

			<xsl:call-template name="metadata-dublincore" />
			<xsl:call-template name="metadata-site-ldjson" />
			<xsl:call-template name="metadata-general" />
			<xsl:call-template name="metadata-sm-shared" />
		</head>

		<body>
			<xsl:attribute name="class">
				<xsl:text>p-</xsl:text><xsl:value-of select="/data/params/current-page" />
				<xsl:if test="/data/params/page-types/item = 'image-overlay'">
					<xsl:text> t-image-overlay</xsl:text>
				</xsl:if>
			</xsl:attribute>
			<!--Add a class for each page type, so can be used as hooks for behaiour-->
			
		
			<xsl:call-template name="matomo" />
			
			<!--Pages with type 'full' show no header, with full-width top navigation and full content area.
				All others get default contained page layout-->
			<xsl:choose>
				<xsl:when test="/data/params/page-types/item = 'full'">
					<div class="wrap-all">
						<xsl:call-template name="navigation">
							<xsl:with-param name="top" select="'Yes'" />
						</xsl:call-template>
						
						<xsl:apply-templates />
					</div><!--wrap-->
				</xsl:when>
				<xsl:otherwise>
					<div class="container">
						<header id="header" class="hidden-xs"><a href="/" class="sitename">Irish Left Archive</a></header>
						<xsl:call-template name="navigation" />
						
						<xsl:if test="not(/data/params/page-types/item = 'index')">
							<xsl:call-template name="breadcrumb" />
						</xsl:if>

						<xsl:apply-templates />
						<xsl:call-template name="footer" />
					</div> <!-- /container -->
				</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="end-insert" />
		</body>
	</html>
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="/data/params/website-name" />
</xsl:template>

<!--The named templates need to exist, so are defined here with no content and can be over-written as needed on individual pages
	Weirdly, &#160; produces bad UTF8 and breaks validation for some reason. Empty text node seems to work ok...
-->
<xsl:template name="head-insert">
	<xsl:text></xsl:text>
</xsl:template>

<xsl:template name="end-insert">
	<xsl:text></xsl:text>
</xsl:template>

<!--
This needs an over-ride for the timeline custom page, to ensure the scaling works properly on mobile.
Otherwise, the below is used on all pages.
-->
<xsl:template name="viewport">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
</xsl:template>

</xsl:stylesheet>
