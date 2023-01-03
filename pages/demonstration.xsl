<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/layout-sidecolumn.xsl"/>
<xsl:import href="../utilities/layout-share.xsl"/>
<xsl:import href="../utilities/section-comments.xsl"/>
<xsl:import href="../utilities/section-documents.xsl"/>
<xsl:import href="../utilities/section-demonstrations.xsl"/>
<xsl:import href="../utilities/section-subjects.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/general-datetime.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<xsl:apply-templates select="demonstration-single/entry" />
	
	<div class="row">
		<div class="col-sm-9">
			<xsl:apply-templates select="comments" />
		</div>
		<aside class="col-sm-3">
			<xsl:call-template name="sidecolumn" />
		</aside>
	</div>
	
	<section class="snapshots-section">
		<div class="flex-row">
			<xsl:call-template name="snapshots-column" />
			<div class="col-md-4">
				<xsl:call-template name="snapshots-contribute" />
				<xsl:call-template name="snapshots-about" />
			</div>
			<div class="col-md-4 spaced">
				<div>
					<h3><span class="fas fa-bullhorn"></span> Latest Additions</h3>
					<xsl:apply-templates select="/data/demonstrations-recent" />
				</div>
				<xsl:call-template name="snapshots-logos" />
			</div>
		</div>
	</section>
</xsl:template>

<xsl:variable name="formatted-date">
	<xsl:call-template name="format-date">
		<xsl:with-param name="date" select="/data/demonstration-single/entry/date/@iso" />
		<xsl:with-param name="format" select="'D M Y'" />
	</xsl:call-template>
</xsl:variable>

<xsl:template match="demonstration-single/entry">
	<article class="segmented delineated" typeof="schema:Event" resource="#demo">
		<div class="page-header">
			<h1 class="heading-snapshots">
				<span class="fas fa-bullhorn"></span>&#160;
				<span property="schema:name"><xsl:value-of select="name"/></span>
			</h1>
		</div>
		<div class="row">
			<div class="col-sm-6">
				<div class="lead"><xsl:apply-templates select="summary/*" mode="html" /></div>
			</div>
			<div class="col-sm-6">
				<ul class="snapshots-info-list">
					<li>
						<span class="fas fa-calendar fa-fw"></span><span class="sr-only">Date:</span>
						<date property="schema:startDate" content="{date/@iso}"><xsl:value-of select="$formatted-date" /></date>
					</li>
					<li>
						<xsl:call-template name="section-icon">
							<xsl:with-param name="section" select="'organisations'" />
							<xsl:with-param name="pad" select="'No'" />
						</xsl:call-template>
						<span class="sr-only">Organisations:</span>
						<xsl:apply-templates select="documents/item/organisation/item[not(.=preceding::*)]" mode="entry-list">
							<xsl:sort select="." />
						</xsl:apply-templates>
					</li>
					<xsl:apply-templates select="place/item" mode="rdfa" />
					<li>
						<xsl:call-template name="section-icon">
							<xsl:with-param name="section" select="'documents'" />
							<xsl:with-param name="pad" select="'No'" />
						</xsl:call-template>
						<span class="sr-only">Documents:</span><xsl:value-of select="count(documents/item)" />
					</li>
				</ul>
				<footer>
					<xsl:call-template name="share-links">
						<xsl:with-param name="title"><xsl:value-of select="$formatted-date" />: <xsl:value-of select="/data/demonstration-single/entry/name" /> — Snapshots of Political Action</xsl:with-param>
						<xsl:with-param name="alignment">right</xsl:with-param>
						<xsl:with-param name="hashtag" select="'#SnapshotsOfPoliticalAction'" />
					</xsl:call-template>
					<p><i>Snapshots of Political Action, from <a href="#">Irish Election Literature <span class="fas fa-external-link-alt"></span></a> and the <b>Irish Left Archive</b>.</i></p>
				</footer>
			</div>
		</div>
		<xsl:apply-templates select="photo" />
		<h3>Documents from this demonstration</h3>
		<div class="snapshots snapshots-grid">
			<xsl:apply-templates select="documents/item" mode="card" />
		</div>
		<xsl:if test="subjects/item or related/item">
			<footer class="row">
				<h3 class="col-xs-12">More Information</h3>
				<xsl:apply-templates select="subjects" />
				<xsl:apply-templates select="related" />
			</footer>
		</xsl:if>
	</article>
</xsl:template>

<xsl:template match="demonstration-single/entry/photo">
	<figure class="card dark">
		<img src="/image/1/1140/0/{@path}/{filename}" alt="Photo of {/data/demonstration-single/entry/name}" class="img-responsive" />
		<figcaption><xsl:value-of select="../photo-caption" /></figcaption>
	</figure>
</xsl:template>

<xsl:template match="documents/item" mode="card">
	<div class="snapshots-doc">
		<div class="card horizontal-md" property="schema:workFeatured">
		<xsl:attribute name="resource">
			<xsl:apply-templates select="." mode="entry-resource-uri" />
		</xsl:attribute>
		<xsl:attribute name="typeof">
			<xsl:choose>
				<xsl:when test="type/item/@handle = 'publication-issue'">schema:PublicationIssue</xsl:when>
				<xsl:otherwise>schema:CreativeWork</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>

			<figure><img src="/image/1/400/0{cover-image/@path}/{cover-image/filename}" alt="{name}" class="img-responsive" /></figure>
			<div class="caption">
				<div>
					<h3 property="schema:name"><xsl:value-of select="name" /></h3>
					<xsl:if test="subtitle"><h4 class="snapshots-subtitle"><xsl:value-of select="subtitle" /></h4></xsl:if>
					<ul class="list-unstyled">
						<xsl:if test="organisation/item">
							<li>
								<span class="fas fa-users fa-fw"></span>&#160;<span class="sr-only">Organisation: </span><xsl:apply-templates select="organisation/item" mode="entry-list" />
							</li>
						</xsl:if>
						<li>
							<span class="fas fa-calendar fa-fw"></span>&#160;<span class="sr-only">Date: </span><span property="schema:datePublished"><xsl:value-of select="year" /><xsl:if test="uncertain = 'Yes'"> c.</xsl:if></span>
						</li>
					</ul>
				</div>
				<div class="btn-group">
					<a href="/document/view/{@id}/" class="btn btn-default"><span class="fas fa-eye fa-fw"></span> View </a>
					<a href="/document/{@id}/" class="btn btn-default"><span class="fas fa-list fa-fw"></span> Details</a>
				</div>
			</div>
		</div>
	</div>
</xsl:template>

<xsl:template match="entry/subjects">
	<div class="col-sm-6">
		<h4>Subjects</h4>
		<ul class="list-unstyled">
			<xsl:apply-templates select="item" />
		</ul>
	</div>
</xsl:template>

<xsl:template match="subjects/item">
	<xsl:variable name="icon">
		<xsl:call-template name="subjects-group-icon">
			<xsl:with-param name="group" select="group/item" />
		</xsl:call-template>
	</xsl:variable>
	<li>
		<span class="fas fa-{$icon}"></span>&#160;
		<xsl:apply-templates select="." mode="entry-link" />
	</li>
</xsl:template>

<xsl:template match="entry/related">
	<div class="col-sm-6">
		<h4>Related Entries</h4>
		<ul class="list-unstyled">
			<xsl:apply-templates select="item" />
		</ul>
	</div>
</xsl:template>

<xsl:template match="related/item">
	<li>
		<xsl:call-template name="section-icon">
			<xsl:with-param name="section" select="@section-handle" />
		</xsl:call-template>
		<xsl:apply-templates select="." mode="entry-link" />
	</li>
</xsl:template>

<xsl:template name="sidecolumn">
	<hr class="visible-xs" />
	<div class="visible-sm">
		<xsl:call-template name="search-small" />
	</div>
	<xsl:call-template name="sidecolumn-personal-accounts" />
	<xsl:call-template name="sidecolumn-podcast" />
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="$formatted-date" />: <xsl:value-of select="/data/demonstration-single/entry/name" /> — Snapshots of Political Action
</xsl:template>

<xsl:variable name="metadata-twitter-card">summary_large_image</xsl:variable>

<xsl:template name="metadata-image">
	<meta property="og:image" content="{/data/params/workspace}{/data/demonstration-single/entry/image/@path}/{/data/demonstration-single/entry/image/filename}" />
	<meta property="og:image:width" content="{/data/demonstration-single/entry/image/meta/@width}" />
	<meta property="og:image:height" content="{/data/demonstration-single/entry/image/meta/@height}" />
	<meta property="og:image:alt" content="Snaphots of Political Action: {/data/demonstration-single/entry/name}" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">
		<xsl:value-of select="/data/demonstration-single/entry/summary" />
	</xsl:variable>

	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Political Material from: {/data/demonstration-single/entry/name}, {$formatted-date}" />
	<meta property="og:url" content="{$root}/demonstration/{/data/demonstration-single/entry/@id}/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Demonstrations'" />
		<xsl:with-param name="link">/demonstrations/</xsl:with-param>
		<xsl:with-param name="position" select="'2'" />
	</xsl:call-template>
	
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" >
			<xsl:call-template name="word-truncate">
				<xsl:with-param name="string" select="/data/demonstration-single/entry/name" />
				<xsl:with-param name="lenth" select="'50'" />
				<xsl:with-param name="ellipses" select="'Yes'" />
			</xsl:call-template>
		</xsl:with-param>
		<xsl:with-param name="link">/demonstration/<xsl:value-of select="/data/demonstration-single/entry/@id" />/</xsl:with-param>
		<xsl:with-param name="position" select="'3'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
