<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/section-comments.xsl"/>
<xsl:import href="../utilities/general-datetime.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/layout-information-menu.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
<article>
<header class="page-header"><h1><xsl:value-of select="pages-single/entry/title" /><xsl:if test="pages-single/entry/sub-title"><xsl:text> </xsl:text><small> <xsl:value-of select="pages-single/entry/sub-title" /></small></xsl:if></h1></header>
<div class="row">


<div class="col-sm-9">
<section class="clearfix">
<xsl:if test="pages-single/entry/image">
<div>
<xsl:attribute name="class">
	<xsl:choose>
		<xsl:when test="pages-single/entry/image/meta/@width &gt; pages-single/entry/image/meta/@height">page-image</xsl:when>	
		<xsl:otherwise>col-xs-12 col-sm-4 col-md-3 page-image pull-right</xsl:otherwise>
	</xsl:choose>
</xsl:attribute>
	<xsl:choose>
	<xsl:when test="pages-single/entry/image-link">
		<a href="{pages-single/entry/image-link}">
			<img src="/image/1/900/0{pages-single/entry/image/@path}/{pages-single/entry/image/filename}" class="img-responsive" alt="" />
		</a>
	</xsl:when>
	<xsl:otherwise>
		<img src="/image/1/900/0{pages-single/entry/image/@path}/{pages-single/entry/image/filename}" class="img-responsive" alt="" />
	</xsl:otherwise>
</xsl:choose>
</div>
</xsl:if>

<xsl:apply-templates select="pages-single/entry/content/*" mode="html"/>
</section>
<xsl:if test="pages-single/entry/comments-enabled = 'Yes'">
<xsl:apply-templates select="comments" />
</xsl:if>
</div>

<div class="col-sm-3">
    <xsl:call-template name="information-menu" />
</div>

</div>
</article>
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="/data/pages-single/entry/title" />
	<xsl:if test="/data/pages-single/entry/sub-title != ''">
		<xsl:text> — </xsl:text>
		<xsl:value-of select="/data/pages-single/entry/sub-title" />
	</xsl:if>
	<xsl:text> | </xsl:text>
	<xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-image">
	<xsl:choose>
		<xsl:when test="/data/pages-single/entry/image">
			<xsl:apply-templates select="/data/pages-single/entry/image" mode="metadata-image-raw" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="metadata-image-default" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="longDesc">
		<xsl:value-of select="/data/pages-single/entry/content" />
	</xsl:variable>
	
	<xsl:variable name="description"><xsl:value-of select="substring($longDesc, 1, 300 + string-length(substring-before(substring($longDesc, 301),' ')))" />&#8230;</xsl:variable>

	<meta name="description" content="{$description}" />

	<meta property="og:type" content="article" />
	<meta property="og:title" content="{/data/pages-single/entry/title}" />
	<meta property="og:url" content="http://www.leftarchive.ie/information/{/data/params/title}/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name">Information: <xsl:value-of select="/data/pages-single/entry/title" /></xsl:with-param>
		<xsl:with-param name="link">/information/<xsl:value-of select="/data/params/title" />/</xsl:with-param>
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
