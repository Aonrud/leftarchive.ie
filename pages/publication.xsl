<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/layout-sidecolumn.xsl"/>
<xsl:import href="../utilities/layout-share.xsl"/>
<xsl:import href="../utilities/section-comments.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/section-documents.xsl"/>
<xsl:import href="../utilities/general-year-range.xsl"/>
<xsl:import href="../utilities/section-external-listings.xsl"/>
<xsl:import href="../utilities/section-articles.xsl"/>
<xsl:import href="../utilities/entry-identifiers.xsl"/>
<xsl:import href="../utilities/section.xsl"/>
<xsl:import href="../utilities/entry-minor.xsl"/>
<xsl:import href="../utilities/section-collections.xsl"/>
<xsl:import href="../utilities/section-podcast.xsl"/>
<xsl:import href="../utilities/section-publications.xsl"/>
<xsl:import href="../utilities/meta-redirect.xsl"/>
<xsl:import href="../utilities/entry-wikipedia.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<xsl:apply-templates select="publication-single/entry" />
</xsl:template>

<xsl:template name="head-insert">
	<xsl:if test="/data/publication-single/entry/minor = 'Yes'">
		<xsl:call-template name="redirect">
			<xsl:with-param name="url">
				<xsl:call-template name="get-url">
					<xsl:with-param name="id" select="/data/publication-single/entry/parent/item/@id" />
					<xsl:with-param name="section-id" select="/data/publication-single/section/@id" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template match="publication-single/entry[minor = 'No']">
	<article>
		<header class="page-header">
			<h1><span about="#pub" property="schema:name"><xsl:value-of select="name"/></span></h1>
		</header>
		<div class="page-fields">
			<div class="row">
				<xsl:if test="masthead or (sample-issue/item/cover-image and masthead-jit)">
					<xsl:variable name="image-path">
						<xsl:text>/image/</xsl:text>
						<xsl:choose>
							<!--Custom masthead image exists-->
							<xsl:when test="masthead">
								<xsl:text>1/</xsl:text>
								<xsl:choose>
									<xsl:when test="masthead-type/item = 'Square'">400</xsl:when>
									<xsl:otherwise>1200</xsl:otherwise>
								</xsl:choose>
								<xsl:text>/0</xsl:text>
								<xsl:value-of select="masthead/@path" />/<xsl:value-of select="masthead/filename" />
							</xsl:when>
							<!--Masthead can be auto-cropped from example issue-->
							<xsl:when test="sample-issue/item/cover-image and masthead-jit">
								<xsl:value-of select="masthead-jit" />
								<xsl:value-of select="sample-issue/item/cover-image/@path" />/<xsl:value-of select="sample-issue/item/cover-image/filename" />
							</xsl:when>
						</xsl:choose>
					</xsl:variable>

					<div>
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="masthead-type/item = 'Square'">col-sm-3</xsl:when>
								<xsl:otherwise>col-xs-12</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<img src="{$image-path}" class="img-responsive" alt="{name}" />
					</div>
				</xsl:if>
			
				<div>
					<xsl:attribute name="class">
						<xsl:choose>
							<xsl:when test="masthead-type/item = 'Square'">col-sm-9</xsl:when>
							<xsl:otherwise>col-xs-12</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					
					<table class="table" resource="#pub" typeof="schema:Periodical">
						<xsl:apply-templates select="irish" />
						<xsl:apply-templates select="tagline" />
						
						<tr>
							<th scope="row"><span class="fas fa-calendar fa-fw"></span> Years Published:</th>
							<td>
								<xsl:apply-templates select="." mode="dates-list" />
							</td>
						</tr>
						
						<xsl:apply-templates select="organisations" />
						<xsl:apply-templates select="/data/publications-minor[entry]" />
						
						<tr><th scope="row"><xsl:call-template name="section-icon"><xsl:with-param name="section" select="'documents'" /></xsl:call-template> Issues in the Archive:</th>
							<td>
								<xsl:choose>
									<xsl:when test="/data/documents-list/entry[type/item/@handle = 'article'] or /data/documents-list/entry[type/item/@handle = 'standalone']">
										<xsl:choose>
											<xsl:when test="count(/data/documents-list/entry[type/item/@handle = 'publication-issue']) = 0">
												0 Full
											</xsl:when>
											<xsl:otherwise>
												<a href="#full-issues"><xsl:value-of select="count(/data/documents-list/entry[type/item/@handle = 'publication-issue'])" /> Full</a>
											</xsl:otherwise>
										</xsl:choose>
											(
										<xsl:if test="/data/documents-list/entry[type/item/@handle = 'article']">
											<a href="#extracts"><xsl:value-of select="count(/data/documents-list/entry[type/item/@handle = 'article'])" /> extract<xsl:if test="count(/data/documents-list/entry[type/item/@handle = 'article']) &gt; 1">s</xsl:if></a>
											</xsl:if>
											<xsl:if test="/data/documents-list/entry[type/item/@handle = 'article'] and /data/documents-list/entry[type/item/@handle = 'standalone']"> / </xsl:if>
										<xsl:if test="/data/documents-list/entry[type/item/@handle = 'standalone']">
												<a href="#standalone"><xsl:value-of select="count(/data/documents-list/entry[type/item/@handle = 'standalone'])" /> special publication<xsl:if test="count(/data/documents-list/entry[type/item/@handle = 'standalone']) &gt; 1">s</xsl:if></a>
											</xsl:if>
											)
									</xsl:when>
									<xsl:otherwise>
										<a href="#documents"><xsl:value-of select="count(/data/documents-list/entry)" /></a>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						
						<xsl:apply-templates select="/data/collections-related[entry]" mode="entry-table" />
						<xsl:apply-templates select="/data/articles-intro[entry]" mode="entry-table" />

						<tr>
							<th scope="row"><span class="fas fa-comment fa-fw"></span> Discuss:</th>
							<td><a href="#comments" property="schema:discussionUrl">Comments on this publication</a></td>
						</tr>
					</table>
					<xsl:call-template name="share-links">
						<xsl:with-param name="title"><xsl:value-of select="name" /> in the Irish Left Archive</xsl:with-param>
						<xsl:with-param name="alignment">right</xsl:with-param>
					</xsl:call-template>
				</div><!--col-->
			</div><!--row-->
		</div><!--page-fields-->

		<div class="row">
			<div class="col-md-9 col-sm-9">
				<section>
					<h2>About</h2>
					<xsl:choose>
						<xsl:when test="normalize-space(about) != ''">
							<div about="#pub" property="schema:description"><xsl:apply-templates select="about/*|about/text()" mode="html"/></div>
						</xsl:when>
						<xsl:when test="normalize-space(about) = '' and links/key[@handle='wikipedia']">
							<xsl:apply-templates select="links/key[@handle='wikipedia']" mode="wiki-insert" />
						</xsl:when>
						<xsl:otherwise>
							<p><em>There is currently no description for this publication.</em></p>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:if test="identifiers or links or /data/publications-minor/entry/identifiers or /data/publications-minor/entry/links">
						<h3>Identifiers</h3>
						<table class="identifiers">
							<xsl:if test="(identifiers or links) and (/data/publications-minor/entry/identifiers or /data/publications-minor/entry/links)">
								<tr><th colspan="2"><xsl:value-of select="name" /></th></tr>
							</xsl:if>
							<xsl:apply-templates select="identifiers">
								<xsl:with-param name="schema-match" select="'#pub'" />
							</xsl:apply-templates>
							<xsl:apply-templates select="links">
								<xsl:with-param name="schema-match" select="'#pub'" />
							</xsl:apply-templates>

							<xsl:apply-templates select="/data/publications-minor/entry" mode="identifiers" />
						</table>
					</xsl:if>
				</section>
				
				<section class="doc-list">
					<h2 id="documents">Documents</h2>
					<xsl:choose>
						<xsl:when test="/data/documents-list/entry">
							<p class="text-right">Show: <a href="#by-type" class="active" data-toggle="tab">Covers</a> | <a href="#by-year" data-toggle="tab">Chronological list</a></p>
							<div class="tab-content">
								<div class="tab-pane fade in active" id="by-type">
									<xsl:choose>
										<xsl:when test="/data/documents-list/entry[type/item/@handle = 'article'] or /data/documents-list/entry[type/item/@handle = 'standalone']">
											<xsl:choose>
												<xsl:when test="count(/data/documents-list/entry[type/item/@handle = 'publication-issue']) = 0">
													<h3>Full issues</h3>
												</xsl:when>
												<xsl:otherwise>
													<h3 id="full-issues"><a href="#full-issues-list" data-toggle="collapse">Full issues <span class="caret"></span></a></h3>
													<ul id="full-issues-list" class="media-list collapse in">
														<xsl:apply-templates select="/data/documents-list/entry[type/item/@handle = 'publication-issue']" mode="full">
															<xsl:sort select="year" data-type="number" />
															<xsl:sort select="volume" data-type="number" />
															<xsl:sort select="issue" data-type="number" />
															<xsl:sort select="name" />
														</xsl:apply-templates>
													</ul>
												</xsl:otherwise>
											</xsl:choose>

											<xsl:if test="/data/documents-list/entry[type/item/@handle = 'article']">
												<h3 id="extracts"><a href="#extracts-list" data-toggle="collapse">Extracts <span class="caret"></span></a></h3>
												<ul id="extracts-list" class="media-list collapse in">
													<xsl:apply-templates select="/data/documents-list/entry[type/item/@handle = 'article']" mode="full">
														<xsl:sort select="year" data-type="number" />
														<xsl:sort select="volume" data-type="number" />
														<xsl:sort select="issue" data-type="number" />
														<xsl:sort select="name" />
													</xsl:apply-templates>
												</ul>
											</xsl:if>
													
											<xsl:if test="/data/documents-list/entry[type/item/@handle = 'standalone']">
												<h3 id="standalone"><a href="#standalone" data-toggle="collapse">Special publications <span class="caret"></span></a></h3>
												<ul id="standalone-list" class="media-list collapse in">
													<xsl:apply-templates select="/data/documents-list/entry[type/item/@handle = 'standalone']" mode="full">
														<xsl:sort select="year" data-type="number" />
														<xsl:sort select="name" />
													</xsl:apply-templates>
												</ul>
											</xsl:if>
													
										</xsl:when>
										<xsl:otherwise>
											<ul class="media-list">
												<xsl:apply-templates select="/data/documents-list/entry" mode="full">
													<xsl:sort select="year" data-type="number" />
													<xsl:sort select="volume" data-type="number" />
													<xsl:sort select="issue" data-type="number" />
													<xsl:sort select="name" />
												</xsl:apply-templates>
											</ul>
										</xsl:otherwise>
									</xsl:choose>
								</div>
								
								<div class="tab-pane fade" id="by-year">
									<ul class="list-unstyled year-list">
										<xsl:apply-templates select="/data/documents-list/entry" mode="simple">
											<xsl:sort select="year" data-type="number" />
											<xsl:sort select="volume" data-type="number" />
											<xsl:sort select="issue" data-type="number" />
											<xsl:sort select="name" />
										</xsl:apply-templates>
									</ul>
								</div>
							</div>
						</xsl:when>
						<xsl:otherwise>
							<p><em>The archive currently has no issues of this publication.<br />
							<strong>If you have documents from <xsl:value-of select="name"/> that you would like to contribute, please <a href="/submit/">contact the archive</a>.</strong></em></p>
						</xsl:otherwise>
					</xsl:choose>
				</section>
				
				<xsl:apply-templates select="/data/podcast-related[entry]" />
				<xsl:apply-templates select="/data/articles-intro[entry]" />
				<xsl:apply-templates select="/data/people-list-publication-contributors[entry]" />
				<xsl:apply-templates select="/data/external-listings[entry]" />
				
				<xsl:apply-templates select="/data/comments" />
			</div>
			<aside class="col-md-3 col-sm-3">
				<xsl:call-template name="sidecolumn" />
			</aside>
		</div>
	</article>
</xsl:template>


<!--Table Templates
	Templates for non-required properties of the publication entry table.
-->
<xsl:template match="irish">
	<tr>
		<th scope="row"><span class="fas fa-tags fa-fw"></span> Irish Name: </th>
		<td lang="ga" property="schema:alternateName">
			<xsl:value-of select="." />
		</td>
	</tr>
</xsl:template>

<xsl:template match="tagline">
	<tr>
		<th scope="row"><span class="fas fa-quote-right fa-fw"></span> Subtitle:</th>
		<td property="schema:alternativeHeadline">
			<xsl:value-of select="."/>
		</td>
	</tr>
</xsl:template>

<xsl:template match="organisations">
	<tr>
		<th scope="row"><span class="fas fa-users fa-fw"></span> Published By: </th>
		<td>
			<xsl:apply-templates select="item" mode="entry-list-linked">
				<xsl:with-param name="rdfa" select="'Yes'" />
				<xsl:with-param name="property" select="'schema:publisher'" />
			</xsl:apply-templates>
		</td>
	</tr>
</xsl:template>

<xsl:template match="publications-minor">
	<tr>
		<th scope="row"><span class="fas fa-tags fa-fw"></span> Other Names: </th>
		<td>
			<xsl:apply-templates select="/data/publications-minor/entry" />
		</td>
	</tr>
</xsl:template>

<xsl:template match="publications-minor/entry">
	<span typeof="schema:Periodical" resource="#alt{@id}">
		<span property="schema:name">
			<xsl:value-of select="name" />
		</span>&#160;
		<xsl:call-template name="year-range">
			<xsl:with-param name="first" select="year-started" />
			<xsl:with-param name="last" select="year-ended" />
			<xsl:with-param name="schema" select="'periodical'" />
			<xsl:with-param name="brackets" select="'Yes'" />
			<xsl:with-param name="unknown" select="'No'" />
		</xsl:call-template>
	</span>
</xsl:template>

<!-- Body description templates -->

<xsl:template match="people-list-publication-contributors">
	<h2>Contributors</h2>
	<p>
		<xsl:apply-templates select="entry" mode="entry-list-linked">
			<xsl:sort select="sort-name" />
			<xsl:with-param name="expand" select="'Yes'" />
		</xsl:apply-templates>
	</p>
	<p><small><em><strong>Note:</strong> This list is not exhaustive.  Only named authors with entries in the archive are listed here.</em></small></p>
</xsl:template>

<!--Minor publications identifiers and links-->
<xsl:template match="publications-minor/entry" mode="identifiers">
	<xsl:if test="identifiers or links">
		<tr><th colspan="2"><xsl:value-of select="name" /></th></tr>
	</xsl:if>
	<xsl:apply-templates select="identifiers">
		<xsl:with-param name="schema-match">#alt<xsl:value-of select="@id" /></xsl:with-param>
	</xsl:apply-templates>
	<xsl:apply-templates select="links">
		<xsl:with-param name="schema-match">#alt<xsl:value-of select="@id" /></xsl:with-param>
	</xsl:apply-templates>
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="/data/publication-single/entry/name" />
	<xsl:if test="/data/publication-single/entry/tagline">: <xsl:value-of select="/data/publication-single/entry/tagline"/></xsl:if>
	<xsl:text> — Publications | </xsl:text><xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-image">
	<xsl:choose>
		<xsl:when test="/data/publication-single/entry/masthead">
			<xsl:apply-templates select="/data/publication-single/entry/masthead" mode="metadata-image-raw">
				<xsl:with-param name="alt">The masthead of <xsl:value-of select="/data/publication-single/entry/name" /></xsl:with-param>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="/data/documents-list/entry and not(/data/publication-single/entry/masthead)">
			<xsl:apply-templates select="/data/documents-list/entry/cover-image" mode="metadata-image-raw">
				<xsl:with-param name="alt">An issue of <xsl:value-of select="/data/publication-single/entry/name" /></xsl:with-param>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="metadata-image-default" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="longDesc">
		<xsl:value-of select="/data/publication-single/entry/about" />
	</xsl:variable>
	<xsl:variable name="description"><xsl:value-of select="/data/publication-single/entry/name" /><xsl:if test="/data/publication-single/entry/tagline">, <xsl:value-of select="/data/publication-single/entry/tagline" />,</xsl:if> in the Irish Left Archive. <xsl:if test="string-length($longDesc) > 10"><xsl:value-of select="substring($longDesc, 1, 300 + string-length(substring-before(substring($longDesc, 301),' ')))" />&#8230;</xsl:if></xsl:variable>

	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="{/data/publication-single/entry/name}" />
	<meta property="og:url" content="{$root}/publication/{/data/publication-single/entry/@id}/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Publications'" />
		<xsl:with-param name="link" select="'/browse/publications/'" />
		<xsl:with-param name="position" select="'2'" />
	</xsl:call-template>

	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="/data/publication-single/entry/name" />
		<xsl:with-param name="link">/publication/<xsl:value-of select="/data/params/id" />/</xsl:with-param>
		<xsl:with-param name="position" select="'3'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
