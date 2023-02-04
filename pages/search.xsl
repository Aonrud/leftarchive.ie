<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-sidecolumn.xsl"/>
<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/general-strings.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/layout-pagination.xsl"/>
<xsl:import href="../utilities/general-year-range.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<!--Edit this to change image thumbnail size for all sections-->
<xsl:variable name="image-width">150</xsl:variable>


<!-- Query for all sections:   collections-list-search/entry|documents-list-search/entry|organisations-list-search/entry|people-list-search/entry|publications-list-search/entry|internationals-list-search/entry|subjects-list-search/entry  -->
<xsl:template match="data">

    <!--For the pagination utility-->
    <xsl:variable name="cut-string">&amp;page=<xsl:value-of select="/data/params/url-page" /></xsl:variable>
    <xsl:variable name="query-string">
    <xsl:choose>
        <xsl:when test="/data/params/url-page">
            <xsl:value-of select="concat(substring-before(/data/params/current-query-string,$cut-string),substring-after(/data/params/current-query-string,$cut-string))" />
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="/data/params/current-query-string" />
        </xsl:otherwise>
    </xsl:choose>
    </xsl:variable>
    <xsl:variable name="page-string">/search/?<xsl:value-of select="$query-string" />&amp;page=$</xsl:variable>

    <div class="page-header">
        <h1>Search <xsl:if test="/data/params/url-keywords != ''">Results <xsl:if test="/data/params/url-page != '' and /data/search/pagination/@total-pages > 1"><small>Page <xsl:choose><xsl:when test="/data/params/url-page &gt; 0"><xsl:value-of select="/data/params/url-page" /></xsl:when><xsl:otherwise>1</xsl:otherwise></xsl:choose> of <xsl:value-of select="/data/search/pagination/@total-pages" /></small></xsl:if></xsl:if></h1>

        <!--Header information-->
        <xsl:if test="/data/params/url-keywords != '' and count(search/entry) != 0">
            <p><strong><xsl:value-of select="/data/search/pagination/@total-entries" /></strong> <xsl:choose><xsl:when test="count(search/entry) = 1"> result was</xsl:when><xsl:otherwise> results were</xsl:otherwise></xsl:choose> returned for <strong><xsl:value-of select="search/@keywords" /></strong>
            
            <xsl:if test="count(/data/search/sections/section) &lt; 7">
            in <span class="label label-info"><xsl:apply-templates select="search/sections" />&#160;<a href="{$current-path}/?keywords={/data/params/url-keywords}&amp;year1={/data/params/url-year1}&amp;year2={/data/params/url-year2}" title="Show results for all sections."><span class="fas fa-times"></span> </a></span>
            </xsl:if>
            <xsl:if test="/data/params/url-year1 != '' or /data/params/url-year2 != ''"> between <span class="label label-info"><strong><xsl:value-of select="/data/params/url-year1" /></strong> and <strong><xsl:value-of select="/data/params/url-year2" /></strong>&#160;<a href="{$current-path}/?keywords={/data/params/url-keywords}&amp;sections={/data/params/url-sections}" title="Show results for all years."><span class="fa fa-times"></span> </a></span></xsl:if> </p>
            <xsl:if test="/data/params/url-year1 != '' or /data/params/url-year2 != ''">
                <p><em><strong>Please note:</strong> Your search is restricted by year. Where the dates of a matching result are unknown it will be included anyway.</em></p>
            </xsl:if>
        </xsl:if>
        <!--End header information-->

    </div>


	<xsl:choose>
		<!--No search (landing page)-->
		<xsl:when test="/data/params/url-keywords = '' or not(/data/params/url-keywords)">
			<xsl:call-template name="search-form" />
		</xsl:when>
		
		<!--No results-->
		<xsl:when test="/data/params/url-keywords != '' and count(search/entry) = 0">
			<p class="alert alert-danger"><span class="fas fa-exclamation-triangle fa-lg"></span> Sorry, your search for <strong><xsl:value-of select="search/@keywords" /></strong> <xsl:if test="count(/data/search/sections/section) &lt; 7">
			in <xsl:apply-templates select="search/sections" />
			</xsl:if> <xsl:if test="/data/params/url-year1 != '' or /data/params/url-year2 != ''"> between <strong><xsl:value-of select="/data/params/url-year1" /></strong> and <strong><xsl:value-of select="/data/params/url-year2" /></strong></xsl:if>  returned no results.</p>
			<xsl:apply-templates select="search/alternative-keywords" />
			<xsl:call-template name="search-form" />
		</xsl:when>


		<!--Results returned-->
		<xsl:otherwise>
			<p><a href="#advanced-search" class="btn btn-info collapsed" data-toggle="collapse">Search Again <span class="caret"></span></a></p>
			<xsl:call-template name="search-form">
				<xsl:with-param name="collapse" select="'yes'" />
			</xsl:call-template>
			<ul class="media-list results-list">
				<xsl:apply-templates select="search/entry" />
			</ul>

			<div class="text-center">
				<xsl:call-template name="pagination">
					<xsl:with-param name="pagination" select="search/pagination"/>
					<xsl:with-param name="pagination-url" select="$page-string"/>
					<xsl:with-param name="class-selected" select="'active'"/>
				</xsl:call-template>
			</div>

		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--Search result entries-->

<!--Ensures matched in search order-->
<xsl:template match="search/entry">	
	<xsl:apply-templates select="//entry[@id = current()/@id and name(parent::*)!='search']" mode="search-listing" />
</xsl:template>

<xsl:template match="entry" mode="search-listing">
	<li class="media">
		<a class="pull-right">
			<xsl:attribute name="href">
				<xsl:apply-templates select="." mode="entry-url" />
			</xsl:attribute>
			<xsl:apply-templates select="." mode="entry-image">
				<xsl:with-param name="width" select="$image-width" />
				<xsl:with-param name="classes" select="'media-object'" />
			</xsl:apply-templates>
		</a>
		<div class="media-body">
			<h4 class="media-heading">
				<xsl:call-template name="section-icon"><xsl:with-param name="section-id" select="../section/@id" /></xsl:call-template>
				<xsl:apply-templates select="." mode="entry-link" />
			</h4>
			<!--only applies to documents, but does no harm-->
			<xsl:if test="subtitle"><h5><xsl:value-of select="subtitle" /></h5></xsl:if>
			
			<ul class="list-inline text-muted">
				<xsl:apply-templates select="." mode="search-listing-meta" />		
			</ul>
			<xsl:apply-templates select="." mode="search-listing-body" />
		</div>
	</li>
</xsl:template>

<!--# Default listing body is to show the search excerpt, but this can be over-ridden for some sections-->
<xsl:template match="entry" mode="search-listing-body">
	<xsl:value-of select="/data/search/entry[@id = current()/@id]/excerpt" disable-output-escaping="yes" />
</xsl:template>

<!--Documents-->
<xsl:template match="entry[../section/@handle = 'documents']" mode="search-listing-meta">
	<li>Year: <xsl:value-of select="year" /><xsl:if test="uncertain = 'Yes'"> c.</xsl:if></li>

	<xsl:if test="organisation/item">
		<li>Organisation: <xsl:value-of select="organisation/item" /></li>
	</xsl:if>
	
	<xsl:if test="publication/item">
		<li>Publication: <xsl:value-of select="publication/item" /></li>
	</xsl:if>

	<xsl:if test="authors/item">
		<li>Author<xsl:if test="count(authors/item) > 1">s</xsl:if>: <xsl:apply-templates select="authors/item" mode="entry-list" /></li>
	</xsl:if>
</xsl:template>

<!--Collections-->
<xsl:template match="entry[../section/@handle = 'collections']" mode="search-listing-meta">
	<li>Included Documents: <xsl:value-of select="count(documents/item)" /></li>
</xsl:template>

<!--Organisations-->
<xsl:template match="entry[../section/@handle = 'organisations']" mode="search-listing-meta">
	<xsl:if test="minor = 'Yes'">
		<li>
			<xsl:value-of select="minor-type/item" /> of <xsl:value-of select="parent/item" />
		</li>
	</xsl:if>
	<li>
		<xsl:text>Years Active: </xsl:text>
		<xsl:call-template name="year-range">
			<xsl:with-param name="first" select="year-founded" />
			<xsl:with-param name="last" select="year-dissolved" />
		</xsl:call-template>
	</li>
	<li>Documents: <xsl:value-of select="@documents-organisation" /></li>		
</xsl:template>

<!--Internationals-->
<xsl:template match="entry[../section/@handle = 'international']" mode="search-listing-meta">
	<xsl:if test="minor = 'Yes'">
		<li>
			Other name of <xsl:value-of select="parent/item" />
		</li>
	</xsl:if>
	<li><xsl:text>Type: </xsl:text><xsl:value-of select="type/item" /></li>
	<li>
		<xsl:text>Years Active: </xsl:text>
		<xsl:call-template name="year-range">
			<xsl:with-param name="first" select="year-founded" />
			<xsl:with-param name="last" select="year-dissolved" />
		</xsl:call-template>
	</li>	
</xsl:template>

<!--Publications-->
<xsl:template match="entry[../section/@handle = 'publications']" mode="search-listing-meta">
	<xsl:if test="tagline">
		<li>Subtitle: <xsl:value-of select="tagline" /></li>
	</xsl:if>
	<xsl:if test="minor = 'Yes'">
		<li>
			Other name of <xsl:value-of select="parent/item" />
		</li>
	</xsl:if>
	<li>
		<xsl:text>Years Active: </xsl:text>
		<xsl:call-template name="year-range">
			<xsl:with-param name="first" select="year-started" />
			<xsl:with-param name="last" select="year-ended" />
		</xsl:call-template>
	</li>
	<xsl:if test="organisations/item">
		<li>Published By: <xsl:apply-templates select="organisations/item" mode="entry-list" /></li>
	</xsl:if>
</xsl:template>

<!--People-->
<xsl:template match="entry[../section/@handle = 'people']" mode="search-listing-meta">
	<xsl:if test="minor = 'Yes'">
		<li>
			<xsl:value-of select="minor-type/item" /> of <xsl:value-of select="parent/item" />
		</li>
	</xsl:if>
	<xsl:if test="(@documents-authors + @documents-contributors + @documents-related-people) > 0">
		<li>Documents: <xsl:value-of select="@documents-authors + @documents-contributors + @documents-related-people" /></li>
	</xsl:if>

	<xsl:if test="organisations/item">
		<li>Associated Organisation<xsl:if test="count(organisations/item) > 1">s</xsl:if>: <xsl:apply-templates select="organisations/item" mode="entry-list" /></li>
	</xsl:if>
	
	<xsl:if test="publications/item">
		<li>Associated Publication<xsl:if test="count(publications/item) > 1">s</xsl:if>: <xsl:apply-templates select="publications/item" mode="entry-list" /></li>
	</xsl:if>
</xsl:template>

<xsl:template match="entry[../section/@handle = 'people']" mode="search-listing-body">
	<p><xsl:value-of select="substring(about/text(),1,300)" />&#8230;</p>
</xsl:template>

<!--Subjects-->
<xsl:template match="entry[../section/@handle = 'subjects']" mode="search-listing-meta">
	<li>Type: <xsl:value-of select="group/item" /></li>
	<xsl:if test="date">
		<li>Date: <xsl:call-template name="format-date"><xsl:with-param name="date" select="date" /><xsl:with-param name="format" select="'D M Y'" /></xsl:call-template></li>
	</xsl:if>
</xsl:template>

<xsl:template match="entry[../section/@handle = 'subjects']" mode="search-listing-body">
	<xsl:apply-templates select="summary/*[1]" mode="html" />
</xsl:template>

<!--Demonstrations-->
<xsl:template match="entry[../section/@handle = 'demonstrations']" mode="search-listing-meta">
	<li>
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="date/@iso"/><xsl:with-param name="format" select="'D M Y'"/>
		</xsl:call-template>
	</li>
	<li>
		Documents: <xsl:value-of select="count(documents/item)" />
	</li>
	<li>Snapshots of Political Action</li>
</xsl:template>

<xsl:template match="entry[../section/@handle = 'demonstrations']" mode="search-listing-body">
	<xsl:apply-templates select="summary" mode="html" />
</xsl:template>

<!--List sections, when not all selected-->
<xsl:template match="search/sections">
    <xsl:apply-templates select="section" />
</xsl:template>

<xsl:template match="search/sections/section">
    <xsl:if test="position() > 1">, </xsl:if><em><xsl:call-template name="lowercase"><xsl:with-param name="string"><xsl:value-of select="." /></xsl:with-param></xsl:call-template></em>
</xsl:template>

<xsl:template match="search/sections/section[last()]">
    <xsl:if test="count(/data/search/sections/section) &gt; 1"> and </xsl:if><em><xsl:call-template name="lowercase"><xsl:with-param name="string"><xsl:value-of select="." /></xsl:with-param></xsl:call-template></em>
</xsl:template>


<!--Template for the typo hints-->
<xsl:template match="search/alternative-keywords">
    <xsl:if test="keyword/@alternative != '' and keyword[@distance &lt; 4] and count(/data/search/entry) &lt; '10'">
        <xsl:variable name="alts">
            <xsl:for-each select="keyword"><xsl:choose><xsl:when test="@alternative != '' and @distance &lt; 4"><xsl:value-of select="@alternative" /></xsl:when><xsl:otherwise><xsl:value-of select="@original" /></xsl:otherwise></xsl:choose><xsl:text> </xsl:text></xsl:for-each>
        </xsl:variable>
        <p><em>Did you mean "<a href="/search/?sections={/data/params/url-sections}&amp;keywords={$alts}"><xsl:value-of select="$alts" /></a>"?</em></p>
    </xsl:if>
</xsl:template>

<xsl:template name="page-title">
Search <xsl:if test="/data/params/url-keywords">Results For <xsl:value-of select="/data/params/url-keywords" />&#160;<xsl:if test="/data/params/url-page">(Page <xsl:value-of select="/data/params/url-page" />)</xsl:if></xsl:if>| <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">Search the Irish Left Archive for historical documents, political parties and organisations, publications and people on the Irish Left.</xsl:variable>
	
	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Search the Irish Left Archive" />
	<meta property="og:url" content="{/data/params/root}/search/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Search'" />
		<xsl:with-param name="link">/search/</xsl:with-param>
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
