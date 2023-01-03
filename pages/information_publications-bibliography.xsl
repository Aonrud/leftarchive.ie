<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:content="http://purl.org/rss/1.0/modules/content/"
	exclude-result-prefixes="content">

<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/entry.xsl"/>
<xsl:import href="../utilities/layout-information-menu.xsl"/>
<xsl:import href="../utilities/section-publications.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template name="head-insert">
	<script src="{$workspace}/assets/js/datatables.min.js"></script>
</xsl:template>

<xsl:template match="data">
	<div class="page-header"><h1>Bibliography of Irish Left Publications</h1></div>
	<div class="row">
		<section class="col-sm-9">
			<p class="lead">The table below is a list of Irish left publications—those included in our digital collection and others of which we are aware.</p>
			<p>Entries highlighted in grey aren't currently listed in the archive. Of those, in some cases issues or even whole archives are available elsewhere online; particularly more recent publications, which are often available in PDF form on publication. Where we can, we will link to those on the relevant organisation's page. In other cases there is limited information available and we'd be glad to hear from anyone with knowledge of them.</p>
			<p>If you were involved in or have examples of any of the publications that aren't available in our collection or elsewhere, please <a href="/submit/">get in touch with us</a>.</p>
			<xsl:apply-templates select="publications-list-all" />
		</section>
		<div class="col-sm-3">
			<xsl:call-template name="information-menu" />
		</div>
	</div>
</xsl:template>

<xsl:template match="publications-list-all">
	<table id="pubTable" class="table table-hover">
		<thead>
			<tr>
				<th scope="col">Name</th>
				<th scope="col">Years</th>
				<th scope="col">Organisation(s)</th>
			</tr>
		</thead>
		<tbody>
			<xsl:apply-templates select="entry[not(organisations) or organisations/item/place/item = 'Ireland']" mode="publication-table-row" />
		</tbody>
	</table>
</xsl:template>

<xsl:template name="end-insert">
	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function () {
		let pt = new DataTable("#pubTable", {
					"paging": false,
					stateSave: true,
					"dom": 'firt',
					"order": [1, 'asc'],
					 "columnDefs": [
						{ targets: '_all', searchable: true }
					],
					"language": {
						"search": "Filter Publications: "
					}
				});
		});
    </script>
</xsl:template>

<xsl:template name="page-title">
Bibliography of Irish Left Publications | <xsl:value-of select="/data/params/website-name" />
</xsl:template>


<xsl:template name="metadata-general">
	<xsl:variable name="description">A list of known publications from the Irish left that are not currently represented in our document collection.</xsl:variable>

	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Bibliography of Irish Left Publications - Irish Left Archive" />
	<meta property="og:url" content="http://www.leftarchive.ie/information/publications-bibliography/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Information: Bibliography'" />
		<xsl:with-param name="link" select="'/information/publications-bibliography/'" />
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
