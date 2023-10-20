<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="dc">

<xsl:import href="layout-search.xsl"/>
<xsl:import href="general-datetime.xsl"/>
<xsl:import href="general-year-range.xsl"/>
<xsl:import href="section.xsl"/>

<xsl:template name="sidecolumn-article">
	<hr class="visible-xs" />
	<div class="visible-sm">
		<xsl:call-template name="search-small" />
	</div>
	
	<xsl:choose>
		<xsl:when test="/data/article-single/entry/associated/item/@section-handle = 'organisations'">
			<xsl:apply-templates select="/data/organisation-article-single/entry" />
		</xsl:when>
		<xsl:when test="/data/article-single/entry/associated/item/@section-handle = 'publications'">
			<xsl:apply-templates select="/data/publication-article-single/entry" />
		</xsl:when>
		<xsl:when test="/data/article-single/entry/associated/item/@section-handle = 'international'">
			<xsl:apply-templates select="/data/international-article-single/entry" />
		</xsl:when>
		<xsl:when test="/data/article-single/entry/associated/item/@section-handle = 'people'">
			<xsl:apply-templates select="/data/people-article-single/entry" />
		</xsl:when>
	</xsl:choose>
		
	<xsl:apply-templates select="/data/articles-recent" />
</xsl:template>


<xsl:template match="organisation-article-single/entry">
	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title"><a href="/organisation/{@id}/"><xsl:value-of select="name" />&#160;<span class="fas fa-angle-double-right"></span></a></h3>
		</div>
		<div class="panel-body">
			<xsl:if test="logo">
				<img src="/image/1/260/0{logo/@path}/{logo/filename}" alt="{name}" class="img-responsive" />
			</xsl:if>
			<p><strong><span class="fas fa-calendar fa-fw"></span> Years: </strong>
				<xsl:call-template name="year-range">
					<xsl:with-param name="first" select="year-founded" />
					<xsl:with-param name="last" select="year-dissolved" />
				</xsl:call-template>
			</p>
			<xsl:if test="/data/organisations-minor/entry">
				<p><strong><span class="fas fa-tags fa-fw"></span> Other names:</strong></p>
				<ul class="list-unstyled">
					<xsl:apply-templates select="/data/organisations-minor/entry[minor-type/item = 'Other Name' or minor-type/item = 'Predecessor']" />
				</ul>
			</xsl:if>
			<div class="hidden-sm">
				<xsl:apply-templates select="about/*" mode="html"/>
			</div>
		
		</div>
	</div>
</xsl:template>

<xsl:template match="/data/organisations-minor/entry">
	<li>
		<xsl:value-of select="name" />&#160;
		<xsl:call-template name="year-range">
			<xsl:with-param name="first" select="year-founded" />
			<xsl:with-param name="last" select="year-dissolved" />
			<xsl:with-param name="brackets" select="'Yes'" />
			<xsl:with-param name="unknown" select="'No'" />
		</xsl:call-template>
	</li>
</xsl:template>


<xsl:template match="organisation-article-single/entry[minor = 'Yes']">
	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title"><a href="/organisation/{parent/item/@id}/"><xsl:value-of select="name" />&#160;<span class="fas fa-angle-double-right"></span></a></h3>
		</div>
		<div class="panel-body">
			<xsl:if test="logo">
				<img src="/image/1/260/0{logo/@path}/{logo/filename}" alt="{name}" class="img-responsive" />
			</xsl:if>
			<p><strong><span class="fas fa-calendar fa-fw"></span> Years: </strong>
				<xsl:call-template name="year-range">
					<xsl:with-param name="first" select="year-founded" />
					<xsl:with-param name="last" select="year-dissolved" />
				</xsl:call-template>
			</p>
			<div class="hidden-sm">
				<xsl:apply-templates select="parent/item/about/*" mode="html"/>
			</div>
		
		</div>
	</div>
</xsl:template>


<xsl:template match="publication-article-single/entry">
	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title"><a href="/publication/{@id}/"><xsl:value-of select="name" />&#160;<span class="fa fa-angle-double-right"></span></a></h3>
		</div>
		<div class="panel-body">
			<xsl:choose>
				<xsl:when test="masthead-type/item = 'Horizontal'">
					<img src="/image/1/300/0{masthead/@path}/{masthead/filename}" class="img-responsive" alt="{name}" />
				</xsl:when>
				<xsl:when test="masthead-type/item = 'Vertical'">
					<img src="/image/1/120/0{masthead/@path}/{masthead/filename}" class="img-responsive pull-right" alt="{name}" />
				</xsl:when>
			</xsl:choose>
			<p><strong><span class="fas fa-calendar fa-fw"></span> Published: </strong>
				<xsl:call-template name="year-range">
					<xsl:with-param name="first" select="year-started" />
					<xsl:with-param name="last" select="year-ended" />
				</xsl:call-template>
			</p>
			<div class="hidden-sm">
				<xsl:apply-templates select="about/*" mode="html"/>
			</div>
		</div>
	</div>

</xsl:template>

<!--TODO-->
<xsl:template match="international-article-single/entry">
	<p></p>
</xsl:template>

<xsl:template match="people-article-single/entry">
	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title"><a href="/people/{@id}/"><xsl:value-of select="name" />&#160;<span class="fa fa-angle-double-right"></span></a></h3>
		</div>
		
		<div class="panel-body">
			<xsl:apply-templates select="about/*" mode="html" />
		</div>
	</div>
</xsl:template>

<xsl:template match="/data/articles-recent">
	<h4>More Articles</h4>
	<ul class="list-unstyled">
		<xsl:apply-templates select="entry[@id != /data/article-single/entry/@id]" />
	</ul>
</xsl:template>

<xsl:template match="/data/articles-recent/entry">
	
	<li>
		<a href="/article/{@id}/"><xsl:value-of select="name" /></a><br />
		<small class="text-muted">
			<xsl:call-template name="section-icon"><xsl:with-param name="section" select="associated/item/@section-handle" /></xsl:call-template><xsl:value-of select="associated/item" />
		</small>
	</li>
</xsl:template>


</xsl:stylesheet>
