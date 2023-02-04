<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/layout-sidecolumn.xsl"/>
<xsl:import href="../utilities/section-comments.xsl"/>
<xsl:import href="../utilities/section-documents.xsl"/>
<xsl:import href="../utilities/master.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<article typeof="schema:Collection">
		<div class="page-header">
			<h1 property="schema:name"><xsl:value-of select="collection-single/entry/name"/></h1>
		</div>
		<div class="page-fields">
			<p class="lead" property="schema:description"><xsl:value-of select="collection-single/entry/summary"/></p>
			<ul class="scroller">
			<xsl:apply-templates select="collection-single/entry/documents/item" mode="scroller" />
			</ul>
		</div>

		<div class="row">
			<div class="col-sm-9">
				<section>
				<h2>About this Collection</h2>
				<xsl:apply-templates select="collection-single/entry/about/*" mode="html"/>
				</section>
				<section>
				<h2>Documents</h2>
				<ul class="list-unstyled year-list">
				<xsl:apply-templates select="collection-single/entry/documents/item" />
				</ul>
				</section>
				<xsl:apply-templates select="comments" />
			</div>
			<aside class="col-sm-3">
				<p>&#160;</p>
				<section class="panel panel-default">
					<header class="panel-heading">
						<h3 class="panel-title">This Collection</h3>
					</header>
					
					<div class="panel-body">
						<ul class="list-unstyled">
							<li><strong>Documents: </strong> <span property="schema:collectionSize"><xsl:value-of select="count(collection-single/entry/documents/item)" /></span></li>
							<li><strong>Created: </strong> <span property="schema:dateCreated" content="{collection-single/entry/added/@iso}"><xsl:call-template name="format-date"><xsl:with-param name="date" select="collection-single/entry/added/@iso"/><xsl:with-param name="format" select="'D M Y'"/></xsl:call-template></span></li>
							<li>
								<xsl:if test="collection-single/entry/updated = collection-single/entry/added">
									<xsl:attribute name="class">hidden</xsl:attribute>
								</xsl:if>
								<strong>Updated: </strong> <span property="schema:dateModified" content="{collection-single/entry/updated/@iso}"><xsl:call-template name="format-date"><xsl:with-param name="date" select="collection-single/entry/updated/@iso"/><xsl:with-param name="format" select="'D M Y'"/></xsl:call-template></span>
							</li>
						</ul>
						<p><em>We aim to update collections when new relevant documents are added to the archive.  If you find a document that should be included in this collection, please <a href="#comments">let us know in the comments</a> or <a href="/submit/">contact us</a>.</em></p>
					</div>
				
				</section>
				
				<xsl:apply-templates select="collection-single/entry/related[item]" />
				<xsl:call-template name="sidecolumn-fediverse" />
			</aside>
		</div>
	</article>
</xsl:template>

<xsl:template match="documents/item">
	<li property="schema:hasPart">
		<xsl:attribute name="resource">
			<xsl:apply-templates select="." mode="entry-resource-uri" />
		</xsl:attribute>
	<xsl:attribute name="typeof">
		<xsl:choose>
			<xsl:when test="type/item/@handle = 'publication-issue'">schema:PublicationIssue</xsl:when>
			<!--<xsl:when test="type/item/@handle = 'article'">schema:Article</xsl:when>-->
			<xsl:otherwise>schema:CreativeWork</xsl:otherwise>
		</xsl:choose>
	</xsl:attribute>

		<span property="schema:datePublished"><xsl:value-of select="year" /><xsl:if test="uncertain = 'Yes'"> c.</xsl:if></span>
		<xsl:text> — </xsl:text>
		<!--TODO: Is another un-wrapped RDFa entry template needed to account for this case?-->
		<a href="/document/{@id}/" property="schema:url"><span property="schema:name"><xsl:value-of select="name" /></span></a>
		<xsl:if test="organisation/item">
			<span class="text-muted">&#160;<xsl:value-of select="organisation/item" /></span>
		</xsl:if>
	</li>
</xsl:template>

<xsl:template match="collection-single/entry/related">
	<section class="panel panel-default">
		<header class="panel-heading">
			<h3 class="panel-title">Further Information</h3>
		</header>
		<div class="panel-body">
			<xsl:apply-templates select="current()[item/@section-handle='organisations']" mode="related-section">
				<xsl:with-param name="section" select="'organisations'" />
			</xsl:apply-templates>
			<xsl:apply-templates select="current()[item/@section-handle='publications']" mode="related-section">
				<xsl:with-param name="section" select="'publications'" />
			</xsl:apply-templates>
			<xsl:apply-templates select="current()[item/@section-handle='people']" mode="related-section">
				<xsl:with-param name="section" select="'people'" />
			</xsl:apply-templates>
			<xsl:apply-templates select="current()[item/@section-handle='demonstrations']" mode="related-section">
				<xsl:with-param name="section" select="'demonstrations'" />
			</xsl:apply-templates>
			<xsl:apply-templates select="current()[item/@section-handle='subjects']" mode="related-section">
				<xsl:with-param name="section" select="'subjects'" />
			</xsl:apply-templates>
		</div>
	</section>
</xsl:template>

<!--
If related items could be grouped, this would be better matched to the group level.
However, since it's multi-section, it can't be a separate DS. And associations/linked list can't be output with grouping...
Could use an indexing method with key (as per browse page) here instead?
-->
<xsl:template match="collection-single/entry/related" mode="related-section">
	<xsl:param name="section" />
	
	<h4>
		<xsl:call-template name="section-icon">
			<xsl:with-param name="section" select="$section" />
		</xsl:call-template>
		<xsl:call-template name="initial">
			<xsl:with-param name="string" select="$section" />
		</xsl:call-template>
	</h4>
	<ul>
		<xsl:apply-templates select="item[@section-handle = $section]" />
	</ul>
</xsl:template>

<xsl:template match="collection-single/entry/related/item">
	<li><xsl:apply-templates select="." mode="entry-link" /></li>
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="/data/collection-single/entry/name" /> — Collections | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:variable name="metadata-twitter-card">summary_large_image</xsl:variable>

<xsl:template name="metadata-image">
	<xsl:choose>
		<xsl:when test="/data/collection-single/entry/image">
			<xsl:apply-templates select="/data/collection-single/entry/image" mode="metadata-image-ratio" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="/data/documents-list/entry/cover-image" mode="metadata-image-ratio" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description" select="/data/collection-single/entry/summary" />

	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Document Collection: {/data/collection-single/entry/name}" />
	<meta property="og:url" content="{$root}/collection/{/data/collection-single/entry/@id}/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Collections'" />
		<xsl:with-param name="link">/collections/</xsl:with-param>
		<xsl:with-param name="position" select="'2'" />
	</xsl:call-template>
	
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" >
			<xsl:call-template name="word-truncate">
				<xsl:with-param name="string" select="/data/collection-single/entry/name" />
				<xsl:with-param name="lenth" select="'50'" />
				<xsl:with-param name="ellipses" select="'Yes'" />
			</xsl:call-template>
		</xsl:with-param>
		<xsl:with-param name="link">/collection/<xsl:value-of select="/data/params/id" />/</xsl:with-param>
		<xsl:with-param name="position" select="'3'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="end-insert">
	<script type="text/javascript">
		new ila.Scroller(
			document.querySelector(".scroller"),
			{
				classes: {
					left: "scroller-left btn btn-default btn-scroller",
					right: "scroller-right btn btn-default btn-scroller",
				},
				texts: {	
					left: '',
					right:'',
				},
				icons: {
					left: "far fa-arrow-alt-circle-left",
					right: "far fa-arrow-alt-circle-right",
				},
				breakpoints: [ [0, 2], [768, 4], [992, 6], [1200, 6] ]
			}
		);
	</script>
</xsl:template>

</xsl:stylesheet>
