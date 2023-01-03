<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-pagination.xsl"/>
<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/layout-sidecolumn.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/section.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<div class="page-header">
		<h1>Document Extracts</h1>
		<p class="text-right"><em>Page <xsl:value-of select="extracts-list/pagination/@current-page" /> of <xsl:value-of select="extracts-list/pagination/@total-pages" /></em></p>
	</div>

	<xsl:apply-templates select="extracts-list/entry" />
	
	<div class="text-center">
		<xsl:call-template name="pagination">
			<xsl:with-param name="pagination" select="extracts-list/pagination"/>
			<xsl:with-param name="pagination-url" select="'/extracts/$/'"/>
			<xsl:with-param name="class-selected" select="'active'"/>
		</xsl:call-template>
	</div>
</xsl:template>

<xsl:template match="extracts-list/entry">

	<h2><xsl:value-of select="name" /></h2>
	<div class="row">
		<div class="col-md-6">
			<table class="table">
				<xsl:if test="document/item">
					<tr>
						<th scope="row"  class="text-nowrap">Document:</th>
						<td><xsl:apply-templates select="document/item" mode="entry-link" /></td>
					</tr>
					<tr>
						<th scope="row"  class="text-nowrap">Direct link:</th>
						<td><a href="/document/view/{document/item/@id}/?page={document-page}">Page <xsl:value-of select="document-page" /></a></td>
					</tr>
				</xsl:if>
				<xsl:if test="caption">
					<tr>
						<th scope="row"  class="text-nowrap">Caption:</th>
						<td><xsl:value-of select="caption" /></td>
					</tr>
				</xsl:if>
				<xsl:if test="transcription">
					<tr>
						<th scope="row"  class="text-nowrap">Transcription:</th>
						<td><xsl:value-of select="transcription" /></td>
					</tr>
				</xsl:if>
				<tr>
					<th scope="row" class="text-nowrap">Use on site:</th>
					<td>
						<ul class="list-unstyled">
							<li><strong>Collections: </strong><xsl:value-of select="@collections" /></li>
							<li><strong>Articles: </strong><xsl:value-of select="@extended-articles" /></li>
							<li><strong>Podcast notes: </strong><xsl:value-of select="@podcast" /></li>
						</ul>
						<ul>
							<xsl:apply-templates select="/data/collections-list/entry[inline-images/item/@id = current()/@id]" />
							<xsl:apply-templates select="/data/articles-intro/entry[inline-images/item/@id = current()/@id]" />
							<xsl:apply-templates select="/data/podcast-list/entry[inline/item/@id = current()/@id]" />
						</ul>
					</td>
				</tr>
				<xsl:if test="notes">
					<tr>
						<th scope="row"  class="text-nowrap">Internal Notes:</th>
						<td><xsl:apply-templates select="notes[@mode='formatted']/*" mode="html" /></td>
					</tr>
				</xsl:if>
			</table>
		</div>
		<div class="col-md-6">
			<img src="/image/4/600/600{image/@path}/{image/filename}" class="img-responsive center-block viewer" data-full="/image/0{image/@path}/{image/filename}" alt="{caption}" />
			<p class="hidden caption"><xsl:value-of select="caption" /></p>
		</div>
	</div>
	<hr />
</xsl:template>

<xsl:template match="collections-list/entry|articles-intro/entry">
	<li>
		<a>
			<xsl:attribute name="href">
				<xsl:call-template name="get-url">
					<xsl:with-param name="id" select="@id" />
					<xsl:with-param name="section-id" select="../section/@id" />
				</xsl:call-template>
			</xsl:attribute>
			<xsl:value-of select="name" />
		</a>
	</li>
</xsl:template>

<xsl:template match="podcast-list/entry">
	<li>
		<a href="/podcast/{url}/"><xsl:value-of select="episode" />: <xsl:value-of select="name" /></a>
	</li>
</xsl:template>

<xsl:template name="page-title">
Extracts | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">Extracts and images from material in the Irish Left Archive.</xsl:variable>
	
	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Extracts in the Irish Left Archive" />
	<meta property="og:url" content="{/data/params/root}/extracts/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Extracts'" />
		<xsl:with-param name="link">/extracts/</xsl:with-param>
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
