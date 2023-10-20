<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/master.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<div class="page-header">
		<h1>Articles</h1>
	</div>
	<p class="lead">These articles expand on the history of particular organisations or publications.</p>
	<section>
		<xsl:apply-templates select="articles-intro/entry" />
	</section>
</xsl:template>

<xsl:template match="articles-intro/entry">
	<xsl:variable name="icon">
		<xsl:choose>
			<xsl:when test="associated/item/@section-handle = 'organisations'">fa-users</xsl:when>
			<xsl:when test="associated/item/@section-handle = 'internationals'">fa-globe-europe</xsl:when>
			<xsl:when test="associated/item/@section-handle = 'publications'">fa-newspaper</xsl:when>
			<xsl:when test="associated/item/@section-handle = 'people'">fa-user</xsl:when>
		</xsl:choose>
	</xsl:variable>

	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				<a href="/article/{@id}/"><xsl:value-of select="name" /></a>
			</h3>
		</div>
		<div class="panel-body">
		<xsl:if test="image">
			<div class="pull-right collection-img">
				<a href="/article/{@id}/">
					<img src="/image/2/120/120/5{image/@path}/{image/filename}" class="img-responsive" alt="" />
				</a>
			</div>
		</xsl:if>
		<p>
			<xsl:value-of select="content/p[position() = 1]" />
		</p>
		<p class="text-muted"><span class="fas fa-fw {$icon}"></span>&#160;<xsl:value-of select="associated/item" /></p>
		</div>
	</div>
</xsl:template>

<xsl:template name="page-title">
Articles | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">Articles expanding on the history of particular organisations and publications in the Irish Left Archive.</xsl:variable>
	
	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Articles in the Irish Left Archive" />
	<meta property="og:url" content="{/data/params/root}/articles/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Articles'" />
		<xsl:with-param name="link">/articles/</xsl:with-param>
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
