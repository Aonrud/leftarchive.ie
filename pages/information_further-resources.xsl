<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/general-datetime.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/layout-information-menu.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
<div class="page-header"><h1>Further Resources <small>Other online archives</small></h1></div>
<div class="row">



<div class="col-sm-9">
<p class="lead">Listed below are other archive sites related to the Irish left or Irish politics.</p>
<p><em>If you know of another archive that should be listed here, <a href="/submit/">let us know</a>.</em></p>
<h3>General</h3>
<dl>
<xsl:apply-templates select="further-resources/type[@handle = 'general']/entry" />
</dl>
<h3>Organisation, Publication or Subject Specific</h3>
<dl>
<xsl:apply-templates select="further-resources/type[@handle = 'specific']/entry" />
</dl>
</div>

<div class="col-sm-3">
    <xsl:call-template name="information-menu" />
</div><!--End col-->

</div>
</xsl:template>

<xsl:template match="further-resources/type/entry">
<dt><a href="{link}"><xsl:value-of select="title" /></a></dt>
<dd><xsl:copy-of select="description/*" /></dd>
</xsl:template>

<xsl:template match="pages-list/entry[title/@handle != 'about']">
<a href="/information/{title/@handle}/" class="list-group-item">
<xsl:value-of select="title" /></a>
</xsl:template>

<xsl:template name="page-title">
Further Resources — Other Online Archives | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">Other archives and sites related to Irish left politics.</xsl:variable>

	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Further Resources and Archives" />
	<meta property="og:url" content="http://www.leftarchive.ie/information/further-resources/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Information: Further Resources'" />
		<xsl:with-param name="link" select="'/information/further-resources/'" />
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
