<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
##Template imports
#
#TODO: Tidy up import levels - e.g. which utilities do or should import other utilities, removing need for page-level imports.
-->

<!--Main page templates-->
<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/layout-sidecolumn.xsl"/>
<xsl:import href="../utilities/layout-share.xsl"/>
<xsl:import href="../utilities/master.xsl"/>

<!--Entry part temlates-->
<xsl:import href="../utilities/entry-identifiers.xsl"/>
<xsl:import href="../utilities/entry-minor.xsl"/>
<xsl:import href="../utilities/entry-wikipedia.xsl"/>

<!--Section templates-->
<xsl:import href="../utilities/section-articles.xsl"/>
<xsl:import href="../utilities/section-collections.xsl"/>
<xsl:import href="../utilities/section-comments.xsl"/>
<xsl:import href="../utilities/section-documents.xsl"/>
<xsl:import href="../utilities/section-external-listings.xsl"/>
<xsl:import href="../utilities/section-imagery.xsl"/>
<xsl:import href="../utilities/section-podcast.xsl"/>
<xsl:import href="../utilities/section-publications.xsl"/>

<!--General utilities-->
<xsl:import href="../utilities/general-strings.xsl"/>
<xsl:import href="../utilities/general-year-range.xsl"/>
<xsl:import href="../utilities/meta-redirect.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<xsl:apply-templates select="organisation-single/entry" />
</xsl:template>

<xsl:template name="head-insert">
	<xsl:if test="/data/organisation-single/entry/minor = 'Yes'">
		<xsl:call-template name="redirect">
			<xsl:with-param name="url">
				<xsl:call-template name="get-url">
					<xsl:with-param name="id" select="/data/organisation-single/entry/parent/item/@id" />
					<xsl:with-param name="section-id" select="/data/organisation-single/section/@id" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template match="organisation-single/entry[minor = 'No']">
  <article>
		<header class="page-header">
			<h1><span about="#org" property="schema:name"><xsl:value-of select="name"/></span> <xsl:if test="acronym/text()"><small> (<xsl:value-of select="acronym" />)</small></xsl:if></h1>
		</header>

		<div class="page-fields">
			<div class="row">
				<xsl:if test="logo">
					<div class="col-sm-3">
						<img src="/image/1/400/0{logo/@path}/{logo/filename}" alt="{name}" about="#org" property="schema:logo" class="img-responsive" />
					</div>
				</xsl:if>
				<div>
					<xsl:attribute name="class">
						<xsl:choose>
							<xsl:when test="logo">col-sm-9</xsl:when>
							<xsl:otherwise>col-xs-12</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>

					<table class="table" resource="#org">
						<xsl:attribute name="typeof">
							<xsl:apply-templates select="." mode="entry-schema-type" />
						</xsl:attribute>
						<xsl:if test="irish">
							<tr>
								<th scope="row"><span class="fas fa-tags fa-fw"></span> Irish Name:</th>
								<td lang="ga" property="schema:alternateName"><xsl:value-of select="irish" /></td>
							</tr>
						</xsl:if>
						
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

						<!--Place is only shown when it's not an Irish organisation-->
						<xsl:apply-templates select="place[item != 'Ireland']" />
						<xsl:apply-templates select="type[item/type != 'Organisation']" />
						
						<xsl:apply-templates select="/data/organisations-minor[entry]" mode="entry-table" />
						<xsl:apply-templates select="/data/documents-list-grouped" mode="entry-table" />
						<xsl:apply-templates select="/data/publications-list-organisation[entry]" mode="entry-table" />
						<xsl:apply-templates select="/data/international-links-list-organisation[entry]" mode="entry-table" />
						
						<xsl:apply-templates select="precursor[item]|emerged[item]|successor[item]|merged[item]" mode="entry-table" />
						
						<xsl:apply-templates select="related-organisations" mode="entry-table" />
						<xsl:apply-templates select="/data/collections-related[entry]" mode="entry-table" />
						<xsl:apply-templates select="/data/articles-intro[entry]" mode="entry-table" />
						<xsl:apply-templates select="timeline" mode="entry-table" />

						<tr>
							<th scope="row"><span class="fas fa-comment fa-fw"></span> Discuss:</th>
							<td><a href="#comments">Comments on this organisation</a></td>
						</tr>
					</table>
					<xsl:call-template name="share-links">
						<xsl:with-param name="title"><xsl:value-of select="name" /> in the Irish Left Archive</xsl:with-param>
						<xsl:with-param name="alignment">right</xsl:with-param>
					</xsl:call-template>
				</div>
			</div><!--row-->
		</div><!--Page fields-->

		<div class="row">
			<div class="col-md-9 col-sm-9">
				<section>
					<h2>About</h2>
					
					<!--Check if there is a description-->
					<xsl:choose>
						<xsl:when test="normalize-space(about) != ''">
							<div about="#org" property="schema:description"><xsl:apply-templates select="about/*" mode="html"/></div>
						</xsl:when>
						<xsl:when test="normalize-space(about) = '' and links/key[@handle='wikipedia']">
							<xsl:apply-templates select="links/key[@handle='wikipedia']" mode="wiki-insert" />
						</xsl:when>
						<xsl:otherwise>
							<p><em>There is currently no description for this organisation.</em></p>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:apply-templates select="/data/organisations-minor[entry/about]" mode="about" />

					<xsl:if test="identifiers or links or /data/organisations-minor/entry/identifiers or /data/organisations-minor/entry/links">
						<h3>Identifiers</h3>
						
						<table class="identifiers">
							<xsl:if test="(identifiers or links) and (/data/organisations-minor/entry/identifiers or /data/organisations-minor/entry/links)">
								<tr><th scope="column" colspan="2"><h4><xsl:value-of select="name" /></h4></th></tr>
							</xsl:if>
						
							<xsl:apply-templates select="identifiers/key">
								<xsl:with-param name="schema-match" select="'#org'" />
							</xsl:apply-templates>
							<xsl:apply-templates select="links/key">
								<xsl:with-param name="schema-match" select="'#org'" />
							</xsl:apply-templates>

							<xsl:apply-templates select="/data/organisations-minor/entry" mode="identifiers" />
						</table>
					</xsl:if>
				</section>

				<xsl:apply-templates select="/data/imagery[entry]" />
				<xsl:apply-templates select="/data/documents-list-grouped" />

				<!--Related - Subject-->
				<xsl:if test="/data/documents-list-subject-linked/entry">
					<section>
						<h2 id="subject">Related Material</h2>
						<p>Items about <xsl:value-of select="name" />.</p>
                        <ul class="media-list">
                            <xsl:apply-templates select="/data/documents-list-subject-linked/entry" mode="full" />
                        </ul>
					</section>
				</xsl:if>
				
				<xsl:apply-templates select="/data/publications-list-all[entry/hidden = 'Yes']" />

				<xsl:apply-templates select="/data/podcast-related[entry]" />
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

<!-- 
##Table row templates
#
#TODO: These shouldn't require this duplication for related orgs. - maybe use a generic template using the parent node name?
-->

<xsl:template match="type">
	<tr>
		<th scope="row"><span class="fas fa-info fa-fw"></span> Organisation type:</th>
		<td><xsl:value-of select="item/type" /></td>
	</tr>
</xsl:template>

<xsl:template match="precursor" mode="entry-table">
	<tr>
		<th scope="row"><xsl:call-template name="section-icon"><xsl:with-param name="section" select="'organisations'" /></xsl:call-template> Precursor:</th>
		<td><xsl:apply-templates select="item" mode="entry-list-linked" /></td>
	</tr>
</xsl:template>

<xsl:template match="emerged" mode="entry-table">
	<tr>
		<th scope="row"><xsl:call-template name="section-icon"><xsl:with-param name="section" select="'organisations'" /></xsl:call-template> Emerged/Split from:</th>
		<td><xsl:apply-templates select="item" mode="entry-list-linked" /></td>
	</tr>
</xsl:template>

<xsl:template match="successor" mode="entry-table">
	<tr>
		<th scope="row"><xsl:call-template name="section-icon"><xsl:with-param name="section" select="'organisations'" /></xsl:call-template> Successor:</th>
		<td><xsl:apply-templates select="item" mode="entry-list-linked" /></td>
	</tr>
</xsl:template>

<xsl:template match="merged" mode="entry-table">
	<tr>
		<th scope="row"><xsl:call-template name="section-icon"><xsl:with-param name="section" select="'organisations'" /></xsl:call-template> Merged with:</th>
		<td><xsl:apply-templates select="item" mode="entry-list-linked" /></td>
	</tr>
</xsl:template>

<xsl:template match="organisation-single/entry/place">
	<tr><th scope="row"><span class="fas fa-map-marker fa-fw"></span> Place:</th><td><xsl:value-of select="item" /></td></tr>
</xsl:template>

<xsl:template match="related-organisations" mode="entry-table">
	<tr>
		<th scope="row">
			<xsl:call-template name="section-icon"><xsl:with-param name="section" select="'organisations'" /></xsl:call-template>
			<xsl:if test="../precursor/item or ../successor/item or ../emerged/item or ../merged/item"> Other</xsl:if> Related Organisation<xsl:if test="count(item) > 1">s</xsl:if>:
		</th>
		<td>
			<xsl:apply-templates select="item" mode="entry-list-linked" />
		</td>
	</tr>
</xsl:template>

<xsl:template match="organisations-minor" mode="entry-table">
	<xsl:apply-templates select="current()[entry/minor-type/item = 'Other Name' or entry/minor-type/item = 'Alternative Form' or entry/minor-type/item = 'Precursor' or entry/minor-type/item = 'Successor']" mode="other-names" />
	
	<xsl:apply-templates select="current()[entry/minor-type/item != 'Other Name' and entry/minor-type/item != 'Alternative Form' and entry/minor-type/item != 'Precursor' and entry/minor-type/item != 'Successor']" mode="groups" />
</xsl:template>

<xsl:template match="organisations-minor" mode="other-names">
	<tr>
		<th scope="row"><span class="fas fa-tags fa-fw"></span> Other Names:</th>
		<td>
			<xsl:apply-templates select="entry[minor-type/item = 'Other Name' or minor-type/item = 'Alternative Form' or minor-type/item = 'Precursor' or minor-type/item = 'Successor']" mode="entry-table">
				<xsl:sort select="year-founded" />
			</xsl:apply-templates>
		</td>
	</tr>
</xsl:template>

<xsl:template match="organisations-minor" mode="groups">
	<tr>
		<th scope="row">
			<span class="fas fa-tags fa-fw"></span> Groups &amp; Sections:
			<a href="#" class="tooltip-icon" data-toggle="tooltip" title="This includes tendencies, sections, youth organisations and closely associated groups which do not have a separate entry in the archive.">
				<sup>
					<span class="sr-only">Info</span>
					<i class="fa-solid fa-fw fa-info"></i>
				</sup>
			</a>
		</th>
		<td>
			<xsl:apply-templates select="entry[minor-type/item != 'Other Name' and minor-type/item != 'Alternative Form' and minor-type/item != 'Precursor' and minor-type/item != 'Successor']" mode="entry-table" />
		</td>
	</tr>
</xsl:template>

<xsl:template match="organisations-minor/entry" mode="entry-table">
	<span resource="#alt{@id}">
		<xsl:attribute name="typeof">
			<xsl:apply-templates select="." mode="entry-schema-type" />
		</xsl:attribute>
		<span property="schema:name"><xsl:value-of select="name" /></span>&#160;
		<xsl:call-template name="year-range">
			<xsl:with-param name="first" select="year-founded" />
			<xsl:with-param name="last" select="year-dissolved" />
			<xsl:with-param name="brackets" select="'Yes'" />
			<xsl:with-param name="unknown" select="'No'" />
			<xsl:with-param name="schema" select="'organisation'" />
		</xsl:call-template>
	</span>
	<xsl:if test="minor-type/item != 'Other Name'"><em class="no-break"> …<xsl:value-of select="minor-type" /></em></xsl:if>
	<xsl:if test="position() != last()"><br /></xsl:if>
</xsl:template>

<xsl:template match="documents-list-grouped" mode="entry-table">
	<tr>
		<th scope="row"><xsl:call-template name="section-icon"><xsl:with-param name="section" select="'documents'" /></xsl:call-template> Documents in Archive:</th>
		<td>
			<xsl:choose>
				<xsl:when test="*/entry">
					<a href="#documents"><xsl:value-of select="count(*/entry)" /></a>
				</xsl:when>
				<xsl:otherwise><em>0 (<a href="/submit/">Submit a document?</a>)</em></xsl:otherwise>
			</xsl:choose>
		</td>
	</tr>
</xsl:template>

<xsl:template match="publications-list-organisation" mode="entry-table">
	<tr>
		<th scope="row"><xsl:call-template name="section-icon"><xsl:with-param name="section" select="'publications'" /></xsl:call-template> Publications:</th>
		<td>
			<xsl:apply-templates select="entry" mode="entry-list-linked">
				<xsl:with-param name="rdfa" select="'Yes'" />
			</xsl:apply-templates>
		</td>
	</tr>
</xsl:template>

<xsl:template match="international-links-list-organisation" mode="entry-table">
	<xsl:apply-templates select="current()[entry/international/item/type/item = 'International']" mode="international" />
	<xsl:apply-templates select="current()[entry/international/item/type/item != 'International']" mode="european" />
</xsl:template>

<xsl:template match="international-links-list-organisation" mode="international">
	 <tr>
		<th scope="row"><xsl:call-template name="section-icon"><xsl:with-param name="section" select="'international'" /></xsl:call-template> International Affiliation<xsl:if test="count(entry[international/item/type/item = 'International'][not(international/item = preceding-sibling::entry/international/item and type/item = preceding-sibling::entry/type/item)]) > 1">s</xsl:if>:</th>
		<td>
			<xsl:apply-templates select="entry[international/item/type/item = 'International'][not(international/item = preceding-sibling::entry/international/item and type/item = preceding-sibling::entry/type/item)]" />
		</td>
	</tr>
</xsl:template>

<xsl:template match="international-links-list-organisation" mode="european">
	<tr>
		<th scope="row"><xsl:call-template name="section-icon"><xsl:with-param name="section" select="'international'" /></xsl:call-template> European Affiliation<xsl:if test="count(entry[international/item/type/item != 'International'][not(international/item = preceding-sibling::entry/international/item and type/item = preceding-sibling::entry/type/item)]) > 1">s</xsl:if>:</th>
		<td>
			<xsl:apply-templates select="entry[international/item/type/item != 'International'][not(international/item = preceding-sibling::entry/international/item and type/item = preceding-sibling::entry/type/item)]" />
		</td>
	</tr>
</xsl:template>

<xsl:template match="international-links-list-organisation/entry">
	<xsl:variable name="intID" select="international/item/@id" />
	<xsl:variable name="type" select="type/item" />
	
	<xsl:variable name="year-end">
		<xsl:choose>
			<xsl:when test="following-sibling::entry[international/item/@id = $intID and type/item = $type]">
				<xsl:value-of select="following-sibling::entry[international/item/@id = $intID and type/item = $type][last()]/year-out" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="year-out" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:apply-templates select="international/item" mode="entry-link-rdfa">
		<xsl:with-param name="property" select="'schema:memberOf'" />
	</xsl:apply-templates>
	<xsl:text>&#160;</xsl:text>
    <xsl:if test="international/item/type/item != 'International'">(<xsl:value-of select="international/item/type/item" />)&#160;</xsl:if>
    
    <xsl:call-template name="year-range">
        <xsl:with-param name="first" select="year-in" />
        <xsl:with-param name="last" select="$year-end" />
        <xsl:with-param name="unknown" select="'No'" />
        <xsl:with-param name="brackets" select="'Yes'" />
    </xsl:call-template>
    
    <xsl:if test="type/item != 'Member'"><em class="no-break"> …<xsl:value-of select="type" /></em></xsl:if>
	<xsl:if test="position() != last()"><br /></xsl:if>
</xsl:template>

<xsl:template match="timeline" mode="entry-table">
	<tr>
		<th scope="row"><span class="fas fa-code-branch fa-fw"></span> Timeline:</th>
		<td><a href="/page/timeline-of-the-irish-left/#find-{.}">View in the timeline of the Irish left</a></td>
	</tr>
</xsl:template>

<!--
##Document list templates
#
#Note: Entry templates 'full' and 'simple' are provided by the shared utility, section-documents.xsl.
#
-->
<xsl:template match="documents-list-grouped[error]">
	<section class="doc-list">
		<h2 id="documents">Documents</h2>
		<p>
			<em>The archive currently has no documents from this organisation.<br />
			<strong>If you have documents from <xsl:value-of select="/data/organisation-single/entry/name"/> that you would like to contribute, please <a href="/submit/">contact the archive</a>.</strong></em>
		</p>
	</section>
</xsl:template>

<xsl:template match="documents-list-grouped[publication/entry]">
	<xsl:variable name="count-pubs">
		<xsl:value-of select="count(publication[@value != 'None'])" />
	</xsl:variable>
	
	<section class="doc-list">
		<h2 id="documents">Documents</h2>
		<p class="text-right">Show: <a href="#by-pub" class="active" data-toggle="tab">By publication</a> | <a href="#by-year" data-toggle="tab">Chronological list</a></p>
		<div class="tab-content">
			<div class="tab-pane fade in active" id="by-pub">
				<xsl:apply-templates select="publication[@value != 'None']" mode="full">
					<xsl:sort select="year" />
					<xsl:sort select="name" />
				</xsl:apply-templates>
				<xsl:apply-templates select="publication[@value = 'None']" mode="full">
					<xsl:sort select="year" />
					<xsl:sort select="name" />
				</xsl:apply-templates>				
			</div>
			<div class="tab-pane fade" id="by-year">
				<ul class="list-unstyled year-list">
				<xsl:apply-templates select="publication/entry" mode="simple">
					<xsl:sort select="year" />
					<xsl:sort select="name" />
				</xsl:apply-templates>
				</ul>
			</div>
		</div>
	</section>
</xsl:template>

<xsl:template match="documents-list-grouped/publication" mode="full">
	<xsl:choose>
		<xsl:when test="@value = 'None'">
			<xsl:if test="count(/data/documents-list-grouped/publication) &gt; 1">
				<h3><a href="#others" data-toggle="collapse">Others <span class="caret"></span></a></h3>
			</xsl:if>
		</xsl:when>
		<xsl:otherwise>
				<h3><a href="#{@link-handle}" data-toggle="collapse"><xsl:value-of select="@value" /> <span class="caret"></span></a></h3>
		</xsl:otherwise>
	</xsl:choose>

	<ul class="media-list collapse in">
		<xsl:choose>
			<xsl:when test="@value = 'None'">
				<xsl:attribute name="id">others</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="id"><xsl:value-of select="@link-handle" /></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="entry" mode="full">
			<xsl:sort select="year" />
			<xsl:sort select="name" />
		</xsl:apply-templates>
	</ul>
</xsl:template>

<!--
##Minor Organisations Descriptions
#
-->
<xsl:template match="organisations-minor" mode="about">
	<h3>Other names, groups or sections</h3>
	<ul class="media-list">
		<xsl:apply-templates select="entry[about]" mode="about" />
	</ul>
</xsl:template>

<xsl:template match="organisations-minor/entry" mode="about">
    <xsl:if test="about">
        <li class="media">
            <xsl:if test="logo">
                <img about="#alt{@id}" property="schema:logo" class="pull-right img-responsive" src="/image/1/100/0{logo/@path}/{logo/filename}" alt="{name}" />
            </xsl:if>
            <h4 class="media-heading"><xsl:value-of select="name" /> <xsl:if test="irish"> (<span about="#alt{@id}" property="schema:alternateName" lang="ga"><xsl:value-of select="irish" /></span>)</xsl:if></h4>
            <div about="#alt{@id}" property="schema:description"><xsl:apply-templates select="about/*" mode="html" /></div>
        </li>
    </xsl:if>
</xsl:template>

<!--
##Minor organisations identifiers and links
#
-->
<xsl:template match="organisations-minor/entry" mode="identifiers">
    <xsl:if test="identifiers or links">
        <tr><th scope="column" colspan="2"><h4><xsl:value-of select="name" /></h4></th></tr>
    </xsl:if>
    <xsl:apply-templates select="identifiers/key">
        <xsl:with-param name="schema-match">#alt<xsl:value-of select="@id" /></xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="links/key">
        <xsl:with-param name="schema-match">#alt<xsl:value-of select="@id" /></xsl:with-param>
    </xsl:apply-templates>
</xsl:template>


<!--#List of publications, including ones not in the archive
	#
-->
<xsl:template match="publications-list-all">
	<section id="publications-table">
		<h2>Publications</h2>
		<p>A list of known publications from <xsl:value-of select="/data/organisation-single/entry/name" />, including those not represented in the Irish Left Archive collection.</p>
		<table class="table table-hover">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Years</th>
					<th scope="col">Organisation(s)</th>
				</tr>
			</thead>
			<tbody>
				<xsl:apply-templates select="entry" mode="publication-table-row" />
			</tbody>
		</table>
	</section>
</xsl:template>

<!--Over-ride the orgs. template in the publications table. No need to link when we're already on the org. page-->
<xsl:template match="entry[../section/@handle = 'publications'][organisations]" mode="orgs">
	<xsl:apply-templates select="organisations/item" mode="entry-list" />
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="/data/organisation-single/entry/name" />
	<xsl:if test="/data/organisation-single/entry/acronym/text()"> (<xsl:value-of select="/data/organisation-single/entry/acronym" />)</xsl:if>
	<xsl:text> — Organisations | </xsl:text><xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="longDesc">
		<xsl:value-of select="/data/organisation-single/entry/about" />
	</xsl:variable>
	<xsl:variable name="description">Political material from <xsl:value-of select="/data/organisation-single/entry/name" /> in the Irish Left Archive. <xsl:if test="string-length($longDesc) > 10"><xsl:value-of select="substring($longDesc, 1, 300 + string-length(substring-before(substring($longDesc, 301),' ')))" />&#8230;</xsl:if></xsl:variable>

	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="{/data/organisation-single/entry/name}" />
	<meta property="og:url" content="{$root}/organisation/{/data/organisation-single/entry/@id}/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="metadata-image">
	<xsl:choose>
		<xsl:when test="/data/organisation-single/entry/logo">
			<xsl:apply-templates select="/data/organisation-single/entry/logo" mode="metadata-image-ratio">
				<xsl:with-param name="bg-colour" select="'fff'" />
				<xsl:with-param name="alt">
					<xsl:text>Logo of </xsl:text>
					<xsl:value-of select="/data/organisation-single/entry/name" />
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
		<xsl:when test="/data/organisation-single/entry/logo">summary_large_image</xsl:when>
		<xsl:otherwise>summary</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Organisations'" />
		<xsl:with-param name="link" select="'/browse/organisations/'" />
		<xsl:with-param name="position" select="'2'" />
	</xsl:call-template>

	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="/data/organisation-single/entry/name" />
		<xsl:with-param name="link">/organisation/<xsl:value-of select="/data/params/id" />/</xsl:with-param>
		<xsl:with-param name="position" select="'3'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
