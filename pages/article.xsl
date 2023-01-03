<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/page-article-sidecolumn.xsl"/>
<xsl:import href="../utilities/section-comments.xsl"/>
<xsl:import href="../utilities/master.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
<article>
<header class="page-header">
	<h1><xsl:value-of select="article-single/entry/name"/>
	<small> Commentary from <xsl:value-of select="article-single/entry/from/item" /></small>
	</h1>
</header>

<xsl:if test="article-single/entry/image">
<p class="text-center">
<!--Required because upscaling is switched on-->
<xsl:variable name="width">
	<xsl:choose>
		<xsl:when test="article-single/entry/image/meta/@width &lt; 1200"><xsl:value-of select="article-single/entry/image/meta/@width" /></xsl:when>
		<xsl:otherwise>1200</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<img class="img-responsive img-center" src="/image/1/{$width}/0{article-single/entry/image/@path}/{article-single/entry/image/filename}" alt="" />
</p>
</xsl:if>
<div class="row">
<div class="col-md-9 col-sm-9">

<p class="text-right text-muted"><small><xsl:call-template name="format-date"><xsl:with-param name="date" select="article-single/entry/added/@iso"/><xsl:with-param name="format" select="'D M Y'"/></xsl:call-template></small></p>
<xsl:apply-templates select="article-single/entry/content/*" mode="html" />

<xsl:if test="/data/articles-intro/entry[@id != /data/params/id]">
<hr />
<h3>See also:</h3>
<xsl:apply-templates select="/data/articles-intro/entry[@id != /data/params/id]" mode="list" />
</xsl:if>

<xsl:apply-templates select="comments" />
</div>
<aside class="col-md-3 col-sm-3">
<xsl:call-template name="sidecolumn-article" />
</aside>
</div>
</article>
</xsl:template>


<xsl:template match="articles-intro/entry" mode="list">
<article>
<h4><a href="/article/{@id}/"><xsl:value-of select="name" /></a></h4>
<xsl:if test="from/item"><p class="text-muted"> From <xsl:value-of select="from/item" /></p></xsl:if>
<p><xsl:value-of select="content/p[position() = 1]" /></p>
<p><a href="/article/{@id}/" title="{name}">Read more &#187;</a></p>
</article>
</xsl:template>

<xsl:template name="page-title">
<xsl:value-of select="/data/article-single/entry/name" /> | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:variable name="metadata-twitter-card">
	<xsl:choose>
		<xsl:when test="/data/article-single/entry/image or (not(/data/article-single/entry/image) and /data/article-single/entry/inline-images/item)">summary_large_image</xsl:when>
		<xsl:otherwise>summary</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:template name="metadata-image">
	<xsl:choose>
		<xsl:when test="/data/article-single/entry/image">
			<xsl:apply-templates select="/data/article-single/entry/image" mode="metadata-image-ratio">
				<xsl:with-param name="portrait-only" select="'Yes'" />
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="not(/data/article-single/entry/image) and /data/article-single/entry/inline-images/item">
			<xsl:apply-templates select="/data/inline-images/entry/image" mode="metadata-image-ratio">
				<xsl:with-param name="portrait-only" select="'Yes'" />
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="metadata-image-default" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="longDesc">
		<xsl:value-of select="/data/article-single/entry/content" />
	</xsl:variable>
	
	<xsl:variable name="description"><xsl:if test="/data/article-single/entry/from/item">From <xsl:value-of select="/data/article-single/entry/from/item" /></xsl:if>. <xsl:if test="string-length($longDesc) > 10"><xsl:value-of select="substring($longDesc, 1, 200 + string-length(substring-before(substring($longDesc, 201),' ')))" />&#8230;</xsl:if></xsl:variable>
	
	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="{/data/article-single/entry/name}" />
	<meta property="og:url" content="{$root}/article/{/data/article-single/entry/@id}/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Articles'" />
		<xsl:with-param name="link">/articles/</xsl:with-param>
		<xsl:with-param name="position" select="'2'" />
	</xsl:call-template>
	
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" >
			<xsl:call-template name="word-truncate">
				<xsl:with-param name="string" select="/data/article-single/entry/name" />
				<xsl:with-param name="lenth" select="'50'" />
				<xsl:with-param name="ellipses" select="'Yes'" />
			</xsl:call-template>
		</xsl:with-param>
		<xsl:with-param name="link">/article/<xsl:value-of select="/data/params/id" />/</xsl:with-param>
		<xsl:with-param name="position" select="'3'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
