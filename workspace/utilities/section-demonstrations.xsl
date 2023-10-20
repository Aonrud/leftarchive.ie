<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<xsl:import href="general-strings.xsl" />

<xsl:variable name="snapshots-tagline">A project from Irish Election Literature and the Irish Left Archive</xsl:variable>
	
<xsl:variable name="snapshots-intro">These document collections bring together material distributed at individual demonstrations, marches, rallies and protests in Ireland, providing a view of the different political strands and groups that come together in campaigns.</xsl:variable>

<xsl:template name="snapshots-banner">
	<xsl:param name="button" select="'No'" />
	<div class="snapshots-banner">
		<div>
			<h1>Snapshots of Political Action</h1>
			<p class="snapshots-tagline">A project from Irish Election Literature and the Irish Left Archive</p>
			<xsl:if test="$button = 'Yes'">
				<a href="/demonstrations/" class="btn btn-default"><span class="fas fa-bullhorn"></span> Documents from demonstrations <span class="fas fa-arrow-right"></span></a>
			</xsl:if>
		</div>
		<img src="{/data/params/workspace}/assets/images/political-action.png" alt="A protest march" />
	</div>
</xsl:template>

<xsl:template name="snapshots-column">
	<div class="col-md-4">
		<a href="/demonstrations/" class="snapshots-column">
			<h1>Snapshots of Political Action</h1>
			<p class="snapshots-tagline"><xsl:value-of select="$snapshots-tagline" /></p>
			<img src="{/data/params/workspace}/assets/images/political-action.png" class="snapshots-id-image" alt="A protest march" />
		</a>
	</div>
</xsl:template>

<xsl:template match="demonstrations-recent">
	<ul class="snapshots-list">
		<xsl:apply-templates select="entry" />
	</ul>
</xsl:template>

<xsl:template match="demonstrations-recent/entry">
	<li>
		<a href="/demonstration/{@id}/">
			<h4><xsl:value-of select="name" /></h4>
			<date>
				<span class="fas fa-calendar fa-fw"></span>
				<xsl:call-template name="format-date">
					<xsl:with-param name="date" select="date/@iso" />
					<xsl:with-param name="format" select="'D M Y'" />
				</xsl:call-template>
			</date>
		</a>
	</li>
</xsl:template>

<xsl:template match="place/item">
	<xsl:param name="element" select="'li'" />
	<xsl:element name="{$element}">
		<span class="fas fa-map fa-fw"></span><span class="sr-only">Location:</span>&#160;
		<xsl:value-of select="town" />, <xsl:value-of select="county" />
	</xsl:element>
</xsl:template>

<xsl:template match="place/item" mode="rdfa">
	<xsl:param name="element" select="'li'" />
	<xsl:element name="{$element}">
	<xsl:attribute name="property">schema:location</xsl:attribute>
	<xsl:attribute name="typeof">schema:Place</xsl:attribute>
		<xsl:call-template name="section-icon">
			<xsl:with-param name="section" select="'places'" />
			<xsl:with-param name="pad" select="'No'" />
		</xsl:call-template>
		<span class="sr-only">Location:</span>
		<span property="schema:name"><xsl:value-of select="town" /></span>, <span property="schema:containedInPlace"><xsl:value-of select="county" /></span>
	</xsl:element>
</xsl:template>

<xsl:template match="*[section/@handle = 'demonstrations']" mode="footer">
	<section class="snapshots-section">
		<div class="flex-row">
			<xsl:call-template name="snapshots-column" />
			<div class="col-md-8">
				<xsl:apply-templates select="." mode="footer-entries" />
			</div>
		</div>
	</section>
</xsl:template>

<xsl:template match="*[section/@handle = 'demonstrations']" mode="footer-entries">
	<h4>This document was collected at these demonstrations:</h4>
	<ul class="snapshots-list">
		<xsl:apply-templates select="entry" mode="footer-list" />
	</ul>
</xsl:template>

<xsl:template match="*[section/@handle = 'demonstrations'][count(entry) = 1]" mode="footer-entries">
	<xsl:apply-templates select="entry" mode="footer-brief" />
	
	<xsl:variable name="short-name">
		<xsl:call-template name="word-truncate">
			<xsl:with-param name="string" select="entry/name" />
			<xsl:with-param name="length" select="'40'" />
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:variable name="remaining">
		<xsl:value-of select="substring-after(entry/name, $short-name)" />
	</xsl:variable>
	
	<a href="/demonstration/{entry/@id}/" title="View all documents from {entry/name}" class="btn btn-default">
		<span class="fas fa-bullhorn"></span>&#160;
		<span>
			<xsl:if test="$short-name != entry/name">
				<xsl:attribute name="class">truncated</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="$short-name" />
		</span>
		<span><xsl:value-of select="$remaining" /></span>&#160;
		<span class="fas fa-arrow-right"></span>
	</a>
	<h4>Documents</h4>
	<ul class="scroller">
		<xsl:apply-templates select="entry/documents/item" mode="scroller">
			<xsl:with-param name="show-year" select="'No'" />
		</xsl:apply-templates>
	</ul>
</xsl:template>

<xsl:template match="entry[../section/@handle = 'demonstrations']" mode="footer-list">
		<li><a href="/demonstration/{@id}/">
			<xsl:apply-templates select="." mode="footer-brief" />
		</a></li>
</xsl:template>

<xsl:template match="entry[../section/@handle = 'demonstrations']" mode="footer-brief">
	<h3><xsl:value-of select="name" /></h3>
	<p><date>
		<span class="fas fa-calendar"></span>&#160;
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="date/@iso" />
			<xsl:with-param name="format" select="'D M Y'" />
		</xsl:call-template>
	</date></p>
	<xsl:apply-templates select="summary/*" mode="html" />
</xsl:template>

<xsl:template name="snapshots-contribute">
	<h3>Contribute</h3>
	<p>If you have collected leaflets from a march or protest anywhere in Ireland that you'd like to contribute, we'd be delighted to include them.</p>
	<p>Get in touch with the <a href="/submit/" title="Contact the Irish Left Archive">Irish Left Archive</a> or <a href="https://irishelectionliterature.com/about/" title="Contact Irish Election Literature">Irish Election Literature</a>.</p>
</xsl:template>

<xsl:template name="snapshots-about">
	<h3>About</h3>
	<p><xsl:value-of select="$snapshots-intro" /></p>
	<a href="/information/about-snapshots-of-political-action/" class="btn btn-default">About Snapshots <span class="fas fa-arrow-right"></span></a>
</xsl:template>

<xsl:template name="snapshots-logos">
	<div class="snapshots-logos">
		<a href="https://www.irishelectionliterature.com" title="Visit Irish Election Literature">
			<img src="{/data/params/workspace}/assets/images/IEL_350.png" alt="Irish Election Literature" class="img-responsive" />
		</a>
		<a href="/" title="Visit the Irish Left Archive">
			<img src="{/data/params/workspace}/assets/images/icons/ILA_350.png" alt="Irish Left Archive" class="img-responsive" />
		</a>
	</div>
</xsl:template>

<xsl:template name="snapshots-commentary-footer">
	<p><i>This document was added as part of Snapshots of Political Action, a joint project from <b>Irish Election Literature</b> and the <b>Irish Left Archive</b>. You'll find more related material in the <a href="https://www.irishelectionliterature.com" title="Irish Election Literature" rel="external">Irish Election Literature <span class="fas fa-external-link-alt"></span></a> collection.</i></p>
</xsl:template>

<xsl:template name="sidecolumn-snapshots">
	<div class="snapshots-aside">
		<h3>Snapshots of Political Action</h3>
		<p class="snapshots-tagline"><xsl:value-of select="$snapshots-tagline" /></p>
		<a href="/demonstrations/" class="btn btn-default"><span class="fas fa-bullhorn"></span> Demonstrations Collections <span class="fas fa-arrow-right"></span></a>
		<img src="{/data/params/workspace}/assets/images/political-action.png" class="snapshots-id-image" alt="A protest march" />
	</div>
</xsl:template>

</xsl:stylesheet>
