<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/general-datetime.xsl"/>
<xsl:import href="../utilities/section-demonstrations.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<main class="snapshots">
		<xsl:call-template name="snapshots-banner" />
		<section class="snapshots segmented delineated">
			<p class="lead"><xsl:value-of select="$snapshots-intro" /></p>
			<p class="lead">They have been compiled as a joint project by <a href="https://www.irishelectionliterature.com" title="Visit the Irish Election Literature website." class="external-link" rel="external">Irish Election Literature <span class="fas fa-external-link-alt"></span></a> and the <a href="https://www.leftarchive.ie" title="Irish Left Archive">Irish Left Archive</a>.
			</p>
		</section>
		<section class="snapshots snapshots-grid">
			<xsl:apply-templates select="demonstrations-list/entry" />
		</section>
		<hr />
		<div class="row">
			<div class="col-sm-6">
				<xsl:call-template name="snapshots-contribute" />
				<xsl:call-template name="snapshots-about" />
			</div>
			<div class="col-sm-6">
				<xsl:call-template name="snapshots-logos" />
			</div>
		</div>
	</main>
</xsl:template>

<xsl:template match="demonstrations-list/entry">
	<article>
		<a href="/demonstration/{@id}/" class="card dark">
			<img src="/image/2/600/315/2{image/@path}/{image/filename}" class="img-responsive" />
			<div class="caption">
				<ul class="list-inline">
					<li>
						<span class="fas fa-calendar"></span><span class="sr-only">Date:</span>&#160;
						<date>
							<xsl:call-template name="format-date">
								<xsl:with-param name="date" select="date" />
								<xsl:with-param name="format" select="'D M Y'" />
							</xsl:call-template>
						</date>
					</li>
					<xsl:apply-templates select="place/item" />
				</ul>
				<h3>
					<span class="fas fa-bullhorn"></span>&#160;
					<xsl:value-of select="name" />
				</h3>
			</div>
		</a>
	</article>
</xsl:template>

<xsl:template name="page-title">
Snapshots of Political Action — Demonstrations, Marches, Rallies and Protests in Ireland
</xsl:template>

<xsl:variable name="metadata-twitter-card">summary_large_image</xsl:variable>

<xsl:template name="metadata-image">
	<meta property="og:image" content="{/data/params/workspace}/assets/images/snapshots_meta.png" />
	<meta property="og:image:width" content="654" />
	<meta property="og:image:height" content="342" />
	<meta property="og:image:alt" content="Snaphots of Political Action — {$snapshots-tagline}" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">These snapshots of political action bring together material distributed at individual demonstrations, marches, rallies and protests in Ireland, providing a view of the different political strands and groups that come together in individual campaigns. A joint project of Irish Election Literature and the Irish Left Archive.</xsl:variable>
	
	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Snapshots of Political Action — Demonstrations, Marches, Rallies and Protests in Ireland" />
	<meta property="og:url" content="{/data/params/root}/demonstrations/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Demonstrations'" />
		<xsl:with-param name="link">/demonstrations/</xsl:with-param>
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
