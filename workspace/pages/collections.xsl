<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/section-collections.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<div class="page-header">
		<h1>Collections</h1>
	</div>
	<p class="lead">The document collections highlight particular events or subjects that cut across the organisations and publications included in the archive.</p>
	<section>
		<xsl:apply-templates select="collections-list/entry" />
	</section>
</xsl:template>

<xsl:template name="page-title">
Collections | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">The document collections highlight particular events or subjects that cut across the organisations and publications included in the archive.</xsl:variable>
	
	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Document Collections in the Irish Left Archive" />
	<meta property="og:url" content="{/data/params/root}/collections/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Collections'" />
		<xsl:with-param name="link">/collections/</xsl:with-param>
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
