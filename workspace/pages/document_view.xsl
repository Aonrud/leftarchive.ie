<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="dc">

<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/metadata-coins.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<xsl:apply-templates select="/data/document-single/entry" />
</xsl:template>

<xsl:template match="document-single/entry">
	<div id="doc-details">
		<button type="button" class="close btn-doc-details pull-right" aria-label="Close"><span aria-hidden="true">&#215;</span></button>
		<h4><xsl:value-of select="/data/document-single/entry/name" /></h4>
		<ul class="list-inline">
			<li>
				<span class="fas fa-fw fa-calendar"></span>&#160;
				<xsl:value-of select="year" /><xsl:if test="uncertain = 'Yes'"> c.</xsl:if>
			</li>
			<xsl:apply-templates select="organisation" />
			<xsl:apply-templates select="publication" />
			<xsl:call-template name="all-people" />
		</ul>
		
		<xsl:apply-templates select="subjects" />
		
		<div class="btn-group" role="group">
			<a class="btn btn-default" href="/document/{@id}/"><span class="fas fa-info-circle"></span> Details and Commentary</a>
			<a class="btn btn-default" href="/workspace{document/@path}/{document/filename}" download="{document/filename}"> <span class="fas fa-fw fa-download"></span> Download</a>
			<a class="btn btn-default" href="/document/{@id}/#comments"><span class="fas fa-fw fa-comment"></span> Discuss</a>
		</div>
	</div>
	
	<xsl:call-template name="metadata-coins" />
	
	<object id="doc-pdf" type="application/pdf">
		<xsl:attribute name="data">/workspace<xsl:value-of select="document/@path" />/<xsl:value-of select="document/filename" /><xsl:if test="/data/params/url-page">#page=<xsl:value-of select="/data/params/url-page" /></xsl:if></xsl:attribute>
		<div class="panel panel-default" style="padding: 15px">
			<p class="text-danger">It appears your browser cannot display PDF files directly.</p>
			<div class="alert alert-info"><span class="fas fa-download"></span> <a class="alert-link" href="/workspace{document/@path}/{document/filename}"> Download <xsl:value-of select="name" /></a></div>
		</div>
	</object>
</xsl:template>

<!--
##Details tab templates
#
-->
<xsl:template match="document-single/entry/organisation">
	<li>
		<span class="fas fa-fw fa-users"></span>&#160;
		<xsl:apply-templates select="item" mode="entry-list" />
	</li>
</xsl:template>

<xsl:template match="document-single/entry/publication">
	<li>
		<span class="fas fa-newspaper fa-fw"></span>&#160;
		<xsl:apply-templates select="item" mode="entry-list" />
	</li>
</xsl:template>

<xsl:template name="all-people">
	<xsl:if test="/data/document-single/entry/authors/item|/data/document-single/entry/contributors/item">
		<li>
			<span class="fas fa-fw fa-user"></span>
			<xsl:apply-templates select="/data/document-single/entry/authors/item|/data/document-single/entry/contributors/item" mode="entry-list" />
		</li>
	</xsl:if>
</xsl:template>

<xsl:template match="document-single/entry/subjects">
	 <p>
		<span class="fas fa-fw fa-bookmark"></span>&#160;
		<xsl:apply-templates select="item" mode="entry-list">
			<xsl:with-param name="separator" select="';'" />
		</xsl:apply-templates>
	</p>
</xsl:template>

<!--Over-rides the template which by default puts the search box on the right of the navigation, replacing it with the doc. details button-->
<xsl:template name="navigation-right-element">
	<button class="btn btn-primary navbar-btn btn-doc-details pull-right hidden-sm" data-toggle="popover">Document Details <span class="caret"></span></button>
</xsl:template>

<xsl:template name="page-title">
	View Document: <xsl:value-of select="/data/document-single/entry/name" /> | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-image">
	<xsl:apply-templates select="/data/document-single/entry/cover-image" mode="metadata-image-raw">
		<xsl:with-param name="alt">
			<xsl:text>Front page of </xsl:text>
			<xsl:value-of select="/data/document-single/entry/name" />
		</xsl:with-param>
	</xsl:apply-templates>
</xsl:template>

<xsl:variable name="metadata-twitter-card">summary_large_image</xsl:variable>

<xsl:template name="metadata-general">
	<xsl:variable name="description">PDF view of <xsl:value-of select="/data/document-single/entry/name" /><xsl:if test="/data/document-single/entry/authors/item"> by <xsl:for-each select="/data/document-single/entry/authors/item"><xsl:choose><xsl:when test="position() = 1"></xsl:when><xsl:when test="position() = last()"> and </xsl:when><xsl:otherwise>, </xsl:otherwise></xsl:choose><xsl:value-of select="." /></xsl:for-each></xsl:if><xsl:if test="/data/document-single/entry/organisation/item">, published by <xsl:value-of select="/data/document-single/entry/organisation/item/name" /></xsl:if> in the Irish Left Archive.</xsl:variable>

	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title">
		<xsl:attribute name="content">
		View Document: <xsl:value-of select="/data/document-single/entry/name" /><xsl:if test="/data/document-single/entry/organisation/item"> - <xsl:for-each select="/data/document-single/entry/organisation/item"><xsl:choose><xsl:when test="position() = 1"></xsl:when><xsl:when test="position() = last()"> and </xsl:when><xsl:otherwise>, </xsl:otherwise></xsl:choose><xsl:value-of select="name" /></xsl:for-each></xsl:if>
		</xsl:attribute>
	</meta>
	<meta property="og:url">
		<xsl:attribute name="content">
			<xsl:value-of select="/data/params/root" />
			<xsl:text>/document/view/</xsl:text>
			<xsl:value-of select="/data/document-single/entry/@id" />
			<xsl:text>/</xsl:text>
			<xsl:if test="/data/params/current-query-string != ''">?<xsl:value-of select="/data/params/current-query-string" /></xsl:if>
		</xsl:attribute>
	</meta>
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="head-insert">
	<script type="text/javascript">
		<![CDATA[
		$(document).ready(function(){
			$("#doc-details").hide();
			$(".btn-doc-details").click(function() {
				$("#doc-details").slideToggle();
				return false;
			});
		});
		]]>
	</script>
</xsl:template>

</xsl:stylesheet>
