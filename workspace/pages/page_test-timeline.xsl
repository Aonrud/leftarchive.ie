<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="dc">

<xsl:import href="../utilities/master.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:variable name="title">Timeline of Left Periodicals</xsl:variable>
<xsl:variable name="description">A timeline of periodicals, papers and journals published by Irish Left parties and organisations.</xsl:variable>

<xsl:template name="viewport">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
</xsl:template>

<xsl:template match="data">
	<div class="page-container">
		<div id="diagram">
			
			<div class="info timeline-exclude">
				<h3>Timeline of Left Periodicals</h3>
				<p>A timeline of periodicals, papers and journals published by Irish Left parties and organisations.</p>
				<p>Note: this is automatically generated from our database of publications.</p>
			</div><!--info-->
			
			<xsl:apply-templates select="publications-timeline/entry">
				<xsl:sort select="organisations/item" />
			</xsl:apply-templates>
			
		</div><!--diagram-->
			
		<div class="controls">
			<form id="timeline-find">
				<label for="finder" class="sr-only">Find a publication</label>
				<input type="text" name="finder" class="form-control" placeholder="Type to search for publications" aria-label="Type to search for publications" />
			</form>
			<div class="btn-group" role="group" aria-label="Diagram Zoom Controls">
				<button id="timeline-zoom-out" type="button" class="btn btn-default btn-sm" title="Zoom out" aria-label="Zoom out"><span class="fas fa-search-minus"></span></button>
				<button id="timeline-zoom-reset" type="button" class="btn btn-default btn-sm" title="Reset zoom" aria-label="Reset zoom"><span class="fas fa-times-circle"></span></button>
				<button id="timeline-zoom-in" type="button" class="btn btn-default btn-sm" title="Zoom in" aria-label="Zoom in"><span class="fas fa-search-plus"></span></button>
			</div>
		</div><!--controls-->
	</div><!--page-container-->
</xsl:template>

<xsl:template match="publications-timeline/entry">	
	<div id="{timeline-id}" data-ila-id="{@id}" data-start="{year-started}">
		<xsl:if test="year-ended != ''"><xsl:attribute name="data-end"><xsl:value-of select="year-ended" /></xsl:attribute></xsl:if>
		<xsl:if test="end-est = 'Yes'"><xsl:attribute name="data-end-estimate">true</xsl:attribute></xsl:if>
		<xsl:apply-templates select="timeline-links" mode="attribute" />
		<xsl:apply-templates select="timeline-row" mode="attribute" />
		<xsl:apply-templates select="timeline-become" mode="attribute" />
		<xsl:apply-templates select="timeline-merge" mode="attribute" />
		<xsl:apply-templates select="timeline-split" mode="attribute" />
		<xsl:apply-templates select="organisations" />
		<xsl:if test="irregular = 'Yes'">
			<xsl:attribute name="data-irregular">true</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="name" />
	</div>
</xsl:template>

<!--Catch cases of interupted existance - this will create two timeline entries before and after the break, with a link between them-->
<xsl:template match="publications-timeline/entry[timeline-break-start]">
	<!--Timeline start and end dates can be added instead of the standard year fields for uncertain data, so both should be checked.
		The timeline's "end estimated" feature is assumed when timeline-end is used.
	-->
	<xsl:variable name="start">
		<xsl:choose>
			<xsl:when test="year-started"><xsl:value-of select="year-started" /></xsl:when>
			<xsl:otherwise><xsl:value-of select="timeline-start" /></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="end">
		<xsl:choose>
			<xsl:when test="year-ended"><xsl:value-of select="year-ended" /></xsl:when>
			<xsl:otherwise><xsl:value-of select="timeline-end" /></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="end-estimate">
		<xsl:choose>
			<xsl:when test="year-ended">false</xsl:when>
			<xsl:otherwise>true</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<div id="{timeline-id}" data-ila-id="{@id}" data-start="{$start}" data-end="{timeline-break-start}">
		<!--Merge and become should only apply to the second entry-->
		<xsl:apply-templates select="timeline-links" mode="attribute" />
		<xsl:apply-templates select="timeline-row" mode="attribute" />
		<xsl:apply-templates select="timeline-split" mode="attribute" />
		<xsl:apply-templates select="organisations" />
		<xsl:if test="irregular = 'Yes'">
			<xsl:attribute name="data-irregular">true</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="name" />
	</div>
	
	<div id="{timeline-id}-2" data-ila-id="{@id}" data-start="{timeline-break-end}">
		<xsl:if test="$end != ''">
			<xsl:attribute name="data-end"><xsl:value-of select="$end" /></xsl:attribute>
			<xsl:attribute name="data-end-estimate"><xsl:value-of select="$end-estimate" /></xsl:attribute>
		</xsl:if>
		<xsl:apply-templates select="timeline-row" mode="attribute" />
		<xsl:apply-templates select="timeline-become" mode="attribute" />
		<xsl:apply-templates select="timeline-merge" mode="attribute" />
		<xsl:attribute name="data-links"><xsl:value-of select="timeline-id" /></xsl:attribute>
		<!--Publications can have more than one associated org., so this will only take the first available colour. -->
		<xsl:if test="organisations/item/colour">
			<xsl:attribute name="data-colour"><xsl:value-of select="organisations/item/colour" /></xsl:attribute>
		</xsl:if>
		<xsl:if test="irregular = 'Yes'">
			<xsl:attribute name="data-irregular">true</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="name" />
	</div>
	
	<div class="timeline-block" data-for="{timeline-id}" data-start="{timeline-break-start}" data-end="{timeline-break-end}" />
</xsl:template>

<!--Several fields named 'timeline-[]' can be simply translated to 'data-[]' attributes-->
<xsl:template match="entry/*" mode="attribute">
	<xsl:attribute name="data{substring-after(name(.), 'timeline')}"><xsl:value-of select="." /></xsl:attribute>
</xsl:template>


<!--Publications can have more than one associated org., so this only uses the first item available. -->
<xsl:template match="organisations">
	<xsl:variable name="group">
		<xsl:choose>
			<xsl:when test="item/parent/item"><xsl:value-of select="item/parent/item/@id" /></xsl:when>
			<xsl:otherwise><xsl:value-of select="item/@id" /></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:attribute name="data-group"><xsl:value-of select="$group" /></xsl:attribute>
	<xsl:apply-templates select="item/colour" />
</xsl:template>

<xsl:template match="organisations/item/colour">
	<xsl:attribute name="data-colour"><xsl:value-of select="." /></xsl:attribute>
</xsl:template>

<xsl:template name="head-insert">
	<link href="/workspace/assets/css/timeline.min.css?v=20210917" rel="stylesheet" type="text/css" />
</xsl:template>

<xsl:template name="end-insert">
	<script src="/workspace/assets/js/timeline.min.js"></script>
	<script>
		const tl = new Timeline("diagram", { 
			entrySelector: "div",
			panzoom: true,
			yearStart: 1900,
			strokeWidth: 8,
			boxWidth: 75,
			yearWidth: 75
			});
		tl.create();
		
		const diagram = document.getElementById("diagram");
		new PopoverWrapper(diagram.querySelectorAll("div[data-ila-id]"), "publication");

		diagram.addEventListener('timelineFind', (e) => {
			e.target.querySelector(`#${e.detail.id}`)._tippy.show();
		});
		
		document.querySelectorAll("[data-toggle-target]").forEach( (el) => new Toggler(el, el.dataset.toggledText) );
	</script>
</xsl:template>

<xsl:template name="metadata-image">
	<meta property="og:image" content="{/data/params/workspace}/images/timeline.png" />
	<meta property="og:image:width" content="1848" />
	<meta property="og:image:height" content="892" />
</xsl:template>

<xsl:variable name="metadata-twitter-card">summary_large_image</xsl:variable>

<xsl:template name="metadata-general">
	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="{$title}" />
	<meta property="og:url" content="{/data/params/root}/{/data/params/current-path}/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="$title" /> | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

</xsl:stylesheet>
