<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:content="http://purl.org/rss/1.0/modules/content/"
	exclude-result-prefixes="content">

<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/layout-sidecolumn.xsl"/>
<xsl:import href="../utilities/layout-information-menu.xsl"/>
<xsl:import href="../utilities/general-strings.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<div class="page-header"><h1>Irish Left Archive News</h1></div>
	<div class="row">

		<div class="col-sm-9">
			<xsl:apply-templates select="ila-news/item" />
			<p>
				<em>This page shows the most recent news items, which we post on our sister site, the Cedar Lounge Revolution.</em><br />
				<a href="https://cedarlounge.wordpress.com/tag/irish-left-archive-news/" class="external">View older news items on the CLR <span class="fas fa-external-link-alt"></span></a>
			</p>
		</div>

		<aside class="col-sm-3">
			<xsl:call-template name="information-menu" />
			<xsl:call-template name="sidecolumn-fediverse" />
		</aside>

	</div>
</xsl:template>


<xsl:template match="ila-news/item">
	<xsl:variable name="hash">
		<xsl:text>post-</xsl:text>
		<xsl:call-template name="substring-after-last">
			<xsl:with-param name="string" select="guid" />
			<xsl:with-param name="delimiter" select="'?p='" />
		</xsl:call-template>
	</xsl:variable>
	
	<article id="{$hash}" resource="#{$hash}" class="bordered contained" typeof="schema:NewsArticle">
		<header>
			<h2 property="schema:headline"><xsl:value-of select="title" /></h2>
			<small class="text-muted" property="schema:datePublished" content="{pubDate}">
				<time><xsl:value-of select="substring-before(pubDate, '+')" /></time>
			</small>
		</header>
		<section property="schema:ArticleBody">
			<xsl:value-of select="content:encoded" disable-output-escaping="yes"/>
			<span property="schema:sameAs" content="{link}"></span>
		</section>
	</article>
</xsl:template>


<xsl:template name="page-title">
News | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">News and updates from the Irish Left Archive project.</xsl:variable>

	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Irish Left Archive News" />
	<meta property="og:url" content="http://www.leftarchive.ie/information/news/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Information: News'" />
		<xsl:with-param name="link" select="'/information/news/'" />
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
