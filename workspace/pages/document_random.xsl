<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-pagination.xsl"/>
<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/layout-sidecolumn.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/section.xsl"/>
<xsl:import href="../utilities/meta-redirect.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<div class="page-header">
		<h1>Random Document</h1>
	</div>
	<p class="lead text-muted">This page randomly selects a document from our collection. If you are not redirected automatically, please follow this link.</p>
	<h2><span class="fas fa-level-up-alt fa-rotate-90 fa-sm"></span>&#160;
		<a title="{/data/document-random/entry/name}" href="/document/{/data/document-random/entry/@id}"><xsl:value-of select="/data/document-random/entry/name" /></a>
	</h2>
</xsl:template>

<xsl:template name="head-insert">
	<xsl:call-template name="redirect">
		<xsl:with-param name="url">/document/<xsl:value-of select="/data/document-random/entry/@id" /></xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="page-title">
	<xsl:text>Random Document (Redirect) | </xsl:text><xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Random Document'" />
		<xsl:with-param name="link" select="'/random/'" />
		<xsl:with-param name="position" select="'2'" />
	</xsl:call-template>

	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="/data/document-random/entry/name" />
		<xsl:with-param name="link">/document/<xsl:value-of select="/data/document-random/entry/@id" />/</xsl:with-param>
		<xsl:with-param name="position" select="'3'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
