<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/layout-sidecolumn.xsl"/>
<xsl:import href="../utilities/layout-share.xsl"/>
<xsl:import href="../utilities/section-comments.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/general-year-range.xsl"/>
<xsl:import href="../utilities/section-articles.xsl"/>
<xsl:import href="../utilities/section-external-listings.xsl"/>
<xsl:import href="../utilities/entry-identifiers.xsl"/>
<xsl:import href="../utilities/entry-minor.xsl"/>
<xsl:import href="../utilities/meta-redirect.xsl"/>
<xsl:import href="../utilities/section-imagery.xsl"/>
<xsl:import href="../utilities/entry-wikipedia.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<xsl:apply-templates select="international-single/entry" />
</xsl:template>

<xsl:template name="head-insert">
	<xsl:if test="/data/international-single/entry/minor = 'Yes'">
		<xsl:call-template name="redirect">
			<xsl:with-param name="url">
				<xsl:call-template name="get-url">
					<xsl:with-param name="id" select="/data/international-single/entry/parent/item/@id" />
					<xsl:with-param name="section-id" select="/data/international-single/section/@id" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template match="international-single/entry[minor = 'No']">
	<article>
		<header class="page-header">
			<h1><span about="#org" property="schema:name"><xsl:value-of select="name"/></span> <xsl:if test="acronym/text()"><small> (<xsl:value-of select="acronym" />)</small></xsl:if></h1>
		</header>
		
		<div class="page-fields">
		<div class="row">
		
			<xsl:if test="logo">
				<div class="col-sm-3">
					<img src="/image/1/400/0/{logo/@path}/{logo/filename}" about="#org" property="schema:logo" alt="{name}" class="img-responsive pull-right" />
				</div>
			</xsl:if>
			
			<div>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="logo">col-sm-9</xsl:when>
					<xsl:otherwise>col-xs-12</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

				<table class="table" typeof="schema:Organization" resource="#org">
					<tr>
						<th scope="row"><span class="fas fa-calendar fa-fw"></span> Years Active:</th>
						<td>
							<xsl:call-template name="year-range">
								<xsl:with-param name="first" select="year-founded" />
								<xsl:with-param name="last" select="year-dissolved" />
								<xsl:with-param name="schema" select="'organisation'" />
							</xsl:call-template>
						</td>
					</tr>
					
					<xsl:apply-templates select="/data/internationals-minor" />
					
					<tr><th scope="row"><span class="fas fa-info fa-fw"></span> Organisation Type:</th><td><xsl:value-of select="type/item" /></td></tr>
					
					<xsl:apply-templates select="/data/organisation-links-international" />
					
					<xsl:apply-templates select="/data/articles-intro[entry]" mode="entry-table" />
					
					<tr><th scope="row"><span class="fas fa-comment fa-fw"></span> Discuss:</th><td><a href="#comments">Comments on this international</a></td></tr>					
				</table>
				<xsl:call-template name="share-links">
					<xsl:with-param name="title"><xsl:value-of select="name" /> in the Irish Left Archive</xsl:with-param>
					<xsl:with-param name="alignment">right</xsl:with-param>
				</xsl:call-template>
			</div>
		</div><!--row-->
		</div><!--page-fields-->
		
		<div class="row">
			<div class="col-md-9 col-sm-9">
				
				<section>
				<h2>About</h2>
					<xsl:choose><!--Checks if there is a description-->
						<xsl:when test="normalize-space(about) != ''">
							<div about="#org" property="schema:description"><xsl:apply-templates select="about/*" mode="html"/></div>
						</xsl:when>
						<xsl:when test="normalize-space(about) = '' and links/key[@handle='wikipedia']">
							<xsl:apply-templates select="links/key[@handle='wikipedia']" mode="wiki-insert" />
						</xsl:when>
						<xsl:otherwise>
							<p><em>There is currently no description for this international.</em></p>
						</xsl:otherwise>
					</xsl:choose>
					
					
					<xsl:if test="/data/internationals-minor/entry/about">
                        <h3>Other names, groups or sections</h3>
                        <dl>
                            <xsl:apply-templates select="internationals-minor/entry" mode="about" />
                        </dl>
                    </xsl:if>

                    <xsl:if test="identifiers or links or /data/internationals-minor/entry/identifiers or /data/internationals-minor/entry/links">
                        <h3>Identifiers</h3>
                        <table class="identifiers">
                            <xsl:if test="(identifiers or links) and (/data/internationals-minor/entry/identifiers or /data/internationals-minor/entry/links)">
                                <tr><th colspan="2"><xsl:value-of select="name" /></th></tr>
                            </xsl:if>
                            <xsl:apply-templates select="identifiers/key">
                                <xsl:with-param name="schema-match" select="'#org'" />
                            </xsl:apply-templates>
                            <xsl:apply-templates select="links/key">
                                <xsl:with-param name="schema-match" select="'#org'" />
                            </xsl:apply-templates>

                            <xsl:apply-templates select="/data/internationals-minor/entry" mode="identifiers" />
                        </table>
                    </xsl:if>
				</section>
				
				<xsl:apply-templates select="/data/imagery[entry]" />
				
				<xsl:apply-templates select="/data/articles-intro[entry]" />
				<xsl:apply-templates select="/data/external-listings[entry]" />
				
				<xsl:apply-templates select="/data/comments" />
			</div>
			<aside class="col-md-3 col-sm-3">
                <xsl:call-template name="sidecolumn" />
			</aside>
		</div><!--close main row div-->
	</article>
</xsl:template>



<xsl:template match="internationals-minor">
	<xsl:if test="entry[minor-type/item = 'Other Name' or minor-type/item = 'Alternative Form' or minor-type/item = 'Precursor' or minor-type/item = 'Successor']">
		<tr><th scope="row"><span class="fas fa-tags fa-fw"></span> Other Names:</th><td><xsl:apply-templates select="entry[minor-type/item = 'Other Name' or minor-type/item = 'Alternative Form' or minor-type/item = 'Precursor' or minor-type/item = 'Successor']" /></td></tr>
	</xsl:if>
	
	<xsl:if test="entry[minor-type/item != 'Other Name' and minor-type/item != 'Alternative Form' and minor-type/item != 'Precursor' and minor-type/item != 'Successor']">
		<tr>
			<th scope="row"><span class="fas fa-tags fa-fw"></span> Groups &amp; Sections:
				<a href="#" class="tooltip-icon" data-toggle="tooltip" title="This includes tendencies, sections, youth organisations and closely associated groups which do not have a separate entry in the archive.">
					<sup>
						<span class="sr-only">Info</span>
						<i class="fa-solid fa-fw fa-info"></i>
					</sup>
				</a>
			</th>
			<td><xsl:apply-templates select="entry[minor-type/item != 'Other Name' and minor-type/item != 'Alternative Form' and minor-type/item != 'Precursor' and minor-type/item != 'Successor']" /></td>
		</tr>
	</xsl:if>
</xsl:template>

<xsl:template match="internationals-minor/entry">
    <span typeof="schema:Organization" resource="#alt{@id}">
        <span property="schema:name"><xsl:value-of select="name" /></span>&#160;
        <xsl:call-template name="year-range">
            <xsl:with-param name="first" select="year-founded" />
            <xsl:with-param name="last" select="year-dissolved" />
            <xsl:with-param name="unknown" value="'No'" />
            <xsl:with-param name="brackets" select="'Yes'" />
            <xsl:with-param name="schema" select="'organisation'" />
        </xsl:call-template>
    </span>
    <xsl:if test="position() != last()"><br /></xsl:if>
</xsl:template>

<!--Minor Internationals Descriptions-->
<xsl:template match="internationals-minor/entry" mode="about">
    <xsl:if test="about">
        <dt><xsl:value-of select="name" /></dt>
        <dd about="#alt{id}" property="schema:description"><xsl:apply-templates select="about/*" mode="html" /></dd>
    </xsl:if>
</xsl:template>

<!--Minor internationals identifiers and links-->
<xsl:template match="internationals-minor/entry" mode="identifiers">
    <xsl:if test="identifiers or links">
        <tr><th colspan="2"><xsl:value-of select="name" /></th></tr>
    </xsl:if>
    <xsl:apply-templates select="identifiers/key">
        <xsl:with-param name="schema-match">#alt<xsl:value-of select="@id" /></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="links/key">
        <xsl:with-param name="schema-match">#alt<xsl:value-of select="@id" /></xsl:with-param>
    </xsl:apply-templates>
</xsl:template>

<xsl:template match="organisation-links-international">
	<tr>
		<th scope="row"><span class="fas fa-users fa-fw"></span> Irish Affiliates:</th>
		<td>
			<xsl:choose>
				<xsl:when test="count(entry[organisation/item/place/item = 'Ireland']) != 0">
					<xsl:apply-templates select="entry[organisation/item/place/item = 'Ireland']">
						<xsl:sort select="year-in" />
					</xsl:apply-templates>
				</xsl:when>
				<xsl:otherwise>
					<span class="text-muted">No Irish affiliates listed.</span>
				</xsl:otherwise>
			</xsl:choose>                                
		</td>
	</tr>
	
	<xsl:if test="entry[organisation/item/place/item != 'Ireland']">
		<tr>
			<th scope="row">
				<span class="fas fa-users fa-fw"></span> Other Affiliates:
					<a href="#" class="tooltip-icon" data-toggle="tooltip" title="Only affiliates with existing entries in the archive are listed here">
					<sup>
						<span class="sr-only">Info</span>
						<i class="fa-solid fa-fw fa-info"></i>
					</sup>
				</a>
			</th>
			<td>
			<xsl:apply-templates select="entry[organisation/item/place/item != 'Ireland']">
				<xsl:sort select="year-in" />
			</xsl:apply-templates>
			</td>
		</tr>
	</xsl:if>
</xsl:template>

<xsl:template match="organisation-links-international/entry">
	<xsl:apply-templates select="organisation/item" mode="entry-link-rdfa">
		<xsl:with-param name="property" select="'schema:member'" />
	</xsl:apply-templates>
	<xsl:text>&#160;</xsl:text>
    <xsl:if test="organisation/item/place/item !='Ireland'">(<xsl:value-of select="organisation/item/place/item" />)&#160;</xsl:if>
    
    <xsl:call-template name="year-range">
        <xsl:with-param name="first" select="year-in" />
        <xsl:with-param name="last" select="year-out" />
        <xsl:with-param name="unknown" select="'No'" />
    </xsl:call-template>
    
    <xsl:if test="type/item != 'Member'"><em class="no-break"> …<xsl:value-of select="type/item" /></em></xsl:if>
    <xsl:if test="position() != last()"><br /></xsl:if>
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="/data/international-single/entry/name" />
	<xsl:if test="/data/international-single/entry/acronym/text()"> (<xsl:value-of select="/data/international-single/entry/acronym" />)</xsl:if>
	<xsl:text> — International Organisations | </xsl:text><xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-image">
	<xsl:choose>
		<xsl:when test="/data/international-single/entry/logo">
			<xsl:apply-templates select="/data/international-single/entry/logo" mode="metadata-image-ratio">
				<xsl:with-param name="bg-colour" select="'fff'" />
				<xsl:with-param name="alt">
					<xsl:text>Logo of </xsl:text>
					<xsl:value-of select="/data/international-single/entry/name" />
				</xsl:with-param>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="metadata-image-default" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:variable name="metadata-twitter-card">
	<xsl:choose>
		<xsl:when test="/data/international-single/entry/logo">summary_large_image</xsl:when>
		<xsl:otherwise>summary</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:template name="metadata-general">
	<xsl:variable name="longDesc">
		<xsl:value-of select="/data/international-single/entry/about" />
	</xsl:variable>
	<xsl:variable name="description"><xsl:value-of select="/data/international-single/entry/name" /> in the Irish Left Archive. <xsl:if test="string-length($longDesc) > 10"><xsl:value-of select="substring($longDesc, 1, 300 + string-length(substring-before(substring($longDesc, 301),' ')))" />&#8230;</xsl:if></xsl:variable>

	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="{/data/international-single/entry/name}" />
	<meta property="og:url" content="{$root}/international/{/data/international-single/entry/@id}/" />
	<meta property="og:description" content="{$description}" />

	
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'International Organisations'" />
		<xsl:with-param name="link" select="'/browse/international-organisations/'" />
		<xsl:with-param name="position" select="'2'" />
	</xsl:call-template>

	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="/data/international-single/entry/name" />
		<xsl:with-param name="link">/international/<xsl:value-of select="/data/params/id" />/</xsl:with-param>
		<xsl:with-param name="position" select="'3'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
