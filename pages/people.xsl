<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/layout-sidecolumn.xsl"/>
<xsl:import href="../utilities/layout-share.xsl"/>
<xsl:import href="../utilities/section-comments.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/section-documents.xsl"/>
<xsl:import href="../utilities/section-external-listings.xsl"/>
<xsl:import href="../utilities/section-articles.xsl"/>
<xsl:import href="../utilities/entry-identifiers.xsl"/>
<xsl:import href="../utilities/entry-wikipedia.xsl"/>
<xsl:import href="../utilities/section.xsl"/>
<xsl:import href="../utilities/entry-minor.xsl"/>
<xsl:import href="../utilities/section-collections.xsl"/>
<xsl:import href="../utilities/meta-redirect.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<xsl:apply-templates select="person-single/entry" />
</xsl:template>

<xsl:template name="head-insert">
	<xsl:if test="/data/person-single/entry/minor = 'Yes'">
		<xsl:call-template name="redirect">
			<xsl:with-param name="url">
				<xsl:call-template name="get-url">
					<xsl:with-param name="id" select="/data/person-single/entry/parent/item/@id" />
					<xsl:with-param name="section-id" select="/data/person-single/section/@id" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<!--The selector needs to include not(minor) to account for cases where the value is unset.  It shouldn't be, but legacy from before it was added...-->
<xsl:template match="person-single/entry[minor = 'No' or not(minor)]">
	<article>
		<header class="page-header">
			<h1 property="schema:name" about="#person"><xsl:value-of select="name"/></h1>
		</header>

		<div class="page-fields">
			<div class="row">

				<xsl:if test="picture">
					<div class="col-sm-3">
						<img src="/image/1/300/0{picture/@path}/{picture/filename}" alt="{name}" class="img-responsive pull-right" about="#person" property="schema:image" />
					</div><!--col-->
				</xsl:if>

				<div>
					<xsl:attribute name="class">
						<xsl:choose>
							<xsl:when test="picture">col-sm-9</xsl:when>
							<xsl:otherwise>col-sm-12</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					
					<table class="table" resource="#person" typeof="schema:Person">
					
						<xsl:apply-templates select="/data/people-minor[entry]" mode="entry-table" />
						
						<xsl:if test="/data/documents-list/entry or /data/documents-list-contributor/entry">
							<tr><th scope="row"><xsl:call-template name="section-icon"><xsl:with-param name="section" select="'documents'" /></xsl:call-template> Documents in the Archive:</th><td><a href="#documents"><xsl:value-of select="count(/data/documents-list/entry) + count(/data/documents-list-contributor/entry)" /></a></td></tr>
						</xsl:if>
						
						<xsl:apply-templates select="organisations" mode="entry-table" />
						<xsl:apply-templates select="publications" mode="entry-table" />
						<xsl:apply-templates select="/data/collections-related[entry]" mode="entry-table" />
						<xsl:apply-templates select="/data/articles-intro[entry]" mode="entry-table" />
						
						<tr><th scope="row"><span class="fas fa-comment fa-fw"></span> Discuss:</th><td><a href="#comments">Comments on <xsl:value-of select="name" /></a></td></tr>
					</table>
					<xsl:call-template name="share-links">
						<xsl:with-param name="title"><xsl:value-of select="name" /> in the Irish Left Archive</xsl:with-param>
						<xsl:with-param name="alignment">right</xsl:with-param>
					</xsl:call-template>

				</div><!--col-->

			</div><!--row-->
		</div>

		<div class="row">
			<div class="col-md-9 col-sm-9">

				<section>
					<h2>About</h2>
					<xsl:choose>
						<xsl:when test="normalize-space(about) != ''">
							<xsl:apply-templates select="about/*|about/text()" mode="html"/>
						</xsl:when>
						<xsl:when test="normalize-space(about) = '' and links/key[@handle='wikipedia']">
							<xsl:apply-templates select="links/key[@handle='wikipedia']" mode="wiki-insert" />
						</xsl:when>
						<xsl:otherwise>
							<p><em>There is currently no description for this person.</em></p>
						</xsl:otherwise>
					</xsl:choose>
					
					<xsl:if test="*[substring(name(), 1, 8) = 'picture-']"><xsl:apply-templates select="." mode="image-credit" /></xsl:if>
					
					<div class="alert alert-info">
						<span class="fas fa-info-circle fa-lg"></span> If this is you or you have corrections or clarifications, please let us know <a href="#comments" class="alert-link">in the comments</a> or by <a href="/submit/" class="alert-link">email</a>.
					</div>
					
					<xsl:apply-templates select="/data/people-minor[entry/about]" mode="about" />
					
					<xsl:if test="identifiers or links or /data/people-minor/entry/identifiers or /data/people-minor/entry/links">
						<h3>Identifiers</h3>
						<table class="identifiers">
							<xsl:if test="(identifiers or links) and (/data/people-minor/entry/identifiers or /data/people-minor/entry/links)">
								<tr><th colspan="2"><xsl:value-of select="name" /></th></tr>
							</xsl:if>
							<xsl:apply-templates select="identifiers">
								<xsl:with-param name="schema-match" select="'#person'" />
							</xsl:apply-templates>
							<xsl:apply-templates select="links">
								<xsl:with-param name="schema-match" select="'#person'" />
							</xsl:apply-templates>

							<xsl:apply-templates select="/data/people-minor/entry[identifiers|links]" mode="identifiers" />
						</table>
					</xsl:if>

				</section>

				<xsl:if test="/data/documents-list/entry or /data/documents-list-contributor/entry">
					<section class="doc-list">
						<h2 id="documents"><xsl:if test="/data/personal-archive-list/entry">Left Archive </xsl:if>Documents</h2>

						<p class="text-right">Show: <a href="#by-type" class="active" data-toggle="tab">By type</a> | <a href="#by-year" data-toggle="tab">Chronological list</a></p>
						<div class="tab-content">
							<div class="tab-pane fade in active" id="by-type">
							
								<xsl:apply-templates select="/data/documents-list[entry]" mode="full">
									<xsl:with-param name="group" select="'Author'" />
								</xsl:apply-templates>
								
								<xsl:apply-templates select="/data/documents-list-contributor[entry]" mode="full">
									<xsl:with-param name="group" select="'Contributor'" />
								</xsl:apply-templates>
							</div>
							<div class="tab-pane fade" id="by-year">
								<ul class="list-unstyled year-list">
								<xsl:apply-templates select="/data/documents-list/entry|/data/documents-list-contributor/entry" mode="simple">
									<xsl:sort select="year" />
									<xsl:sort select="name" />
								</xsl:apply-templates>
								</ul>
							</div>
						</div>
					</section>
				</xsl:if>

				<xsl:apply-templates select="/data/personal-archive-list[entry]" />
				<xsl:apply-templates select="/data/articles-intro[entry]" />

				<!--Related material - subject-->
				<xsl:if test="/data/documents-list-subject-linked/entry">
					<section>
						<h2 id="subject">Related Material</h2>
						<p>Items about <xsl:value-of select="name" />.</p>
                        <ul class="media-list">
                            <xsl:apply-templates select="/data/documents-list-subject-linked/entry" mode="full" />
                        </ul>
					</section>
				</xsl:if>
				
				<xsl:apply-templates select="/data/external-listings[entry]" />

				<xsl:apply-templates select="/data/comments" />

			</div>
			<aside class="col-md-3 col-sm-3">
				<xsl:call-template name="sidecolumn" />
			</aside>
		</div>
	</article>
</xsl:template>


<!--Table templates-->
<xsl:template match="people-minor" mode="entry-table">
	<tr>
		<th scope="row"><span class="fas fa-tags fa-fw"></span> Other Names:</th>
		<td><xsl:apply-templates select="entry" mode="entry-table" /></td></tr>
</xsl:template>

<xsl:template match="people-minor/entry" mode="entry-table">
	<span property="schema:alternateName"><xsl:value-of select="name" /></span> <em class="no-break"> …<xsl:value-of select="minor-type" /></em>
	<xsl:if test="position() != last()"><br /></xsl:if>
</xsl:template>

<xsl:template match="organisations" mode="entry-table">
	<tr>
		<th scope="row"><span class="fas fa-users fa-fw"></span> Associated Organisation<xsl:if test="count(item) > 1">s</xsl:if>:</th>
		<td>
			<xsl:apply-templates select="item" mode="entry-list-linked">
				<xsl:with-param name="rdfa" select="'Yes'" />
				<xsl:with-param name="property" select="'schema:affiliation'" />
			</xsl:apply-templates>
		</td>
	</tr>
</xsl:template>

<xsl:template match="publications" mode="entry-table">
	<tr>
		<th scope="row"><span class="fas fa-users fa-fw"></span> Associated Publication<xsl:if test="count(item) > 1">s</xsl:if>:</th>
		<td>
			<xsl:apply-templates select="item" mode="entry-list-linked" />
		</td>
	</tr>
</xsl:template>

<xsl:template match="documents-list|documents-list-contributor" mode="full">
    <xsl:param name="group" />
    
    <xsl:variable name="doc-total">
		<xsl:value-of select="count(/data/documents-list/entry) + count(/data/documents-list-contributor/entry)" />
	</xsl:variable>
	
	<h3><a href="#{name()}" data-toggle="collapse"><xsl:value-of select="$group" /> <span class="caret"></span></a></h3>

	<ul id="{name()}" class="media-list collapse in">
		<xsl:apply-templates select="entry" mode="full" />
	</ul>
</xsl:template>

<xsl:template match="entry" mode="simple">

	<xsl:variable name="type">
		<xsl:if test="name(..) = 'documents-list'">Author</xsl:if>
		<xsl:if test="name(..) = 'documents-list-contributor'">Contributor</xsl:if>
	</xsl:variable>
	
	<li><xsl:value-of select="year" /><xsl:if test="uncertain = 'Yes'"> c.</xsl:if>
		<xsl:text> - </xsl:text>
		<xsl:apply-templates select="." mode="entry-link" />
		<em class="no-break"> …<xsl:value-of select="$type" /></em>
	</li>
</xsl:template>

<!--Minor Descriptions-->
<xsl:template match="people-minor" mode="about">
	<h3>Other names</h3>
	<dl>
		<xsl:apply-templates select="entry/about" mode="about" />
	</dl>
</xsl:template>

<xsl:template match="people-minor/entry/about" mode="about">
	<dt><xsl:value-of select="../name" /></dt>
	<dd><xsl:apply-templates select="*" mode="html" /></dd>
</xsl:template>

<!--Minor identifiers and links-->
<xsl:template match="people-minor/entry" mode="identifiers">
	<tr><th colspan="2"><xsl:value-of select="name" /></th></tr>
    <xsl:apply-templates select="identifiers">
        <xsl:with-param name="schema-match" select="'#person'" />
    </xsl:apply-templates>
    <xsl:apply-templates select="links">
        <xsl:with-param name="schema-match" select="'#person'" />
    </xsl:apply-templates>
</xsl:template>

<xsl:template match="personal-archive-list">
    <section>
        <h2>More from <xsl:value-of select="/data/person-single/entry/name" /></h2>
        <table class="table">
			<xsl:apply-templates select="entry" />
        </table>
    </section>
</xsl:template>

<xsl:template match="personal-archive-list/entry">
    <tr typeof="{type/item/meta/item}">
        <td property="schema:datePublished"><xsl:value-of select="year" /></td>
        <td><span class="hidden" property="schema:Author" typeof="schema:Person" resource="#person"><span property="schema:name"><xsl:value-of select="/data/person-single/entry/name" /></span></span><span property="schema:name"><xsl:value-of select="name" /></span></td>
        <td><xsl:value-of select="type/item/type" /></td>
        <td><a href="{/data/params/workspace}{document/@path}/{document/filename}" download="{/data/name} - {year} - {name}.pdf">Download</a></td>
    </tr>
</xsl:template>

<xsl:template match="person-single/entry" mode="image-credit">
	<p class="text-muted">
		<strong>Picture: </strong> <xsl:apply-templates select="picture-credit-name" />,
		<xsl:apply-templates select="picture-licence-name" />
	</p>
</xsl:template>

<xsl:template match="person-single/entry[picture-manual-image-credit]" mode="image-credit">
	<div class="text-muted"><xsl:apply-templates select="picture-manual-image-credit/*" mode="html" /></div>
</xsl:template>

<xsl:template match="entry[picture-credit-url]/picture-credit-name">
	<a href="{../picture-credit-url}" class="external" rel="nofollow"><xsl:value-of select="." />&#160;<span class="fa fas fa-external-link-alt"></span></a>
</xsl:template>

<xsl:template match="entry[not(picture-credit-url)]/picture-credit-name">
	<xsl:value-of select="." />
</xsl:template>

<xsl:template match="entry[picture-licence-url]/picture-licence-name">
	<a href="{../picture-licence-url}" class="external" rel="nofollow"><xsl:value-of select="." />&#160;<span class="fa fas fa-external-link-alt"></span></a>
</xsl:template>

<xsl:template match="entry[not(picture-licence-url)]/picture-licence-name">
	<xsl:value-of select="." />
</xsl:template>

<xsl:template match="picture-manual-image-credit/p[1]" mode="html">
	<p><strong>Picture: </strong> <xsl:apply-templates select="* | @* | text()" mode="html"/></p>
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="/data/person-single/entry/name" />
	<xsl:text> — People | </xsl:text><xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="longDesc">
		<xsl:value-of select="/data/person-single/entry/about" />
	</xsl:variable>
	<xsl:variable name="description"><xsl:choose><xsl:when test="/data/documents-list/entry">Documents</xsl:when><xsl:otherwise>Content</xsl:otherwise></xsl:choose> from <xsl:value-of select="/data/person-single/entry/name" /> in the Irish Left Archive. <xsl:if test="string-length($longDesc) > 10"><xsl:value-of select="substring($longDesc, 1, 300 + string-length(substring-before(substring($longDesc, 301),' ')))" />&#8230;</xsl:if></xsl:variable>

	<meta name="description" content="{$description}" />
	<meta property="og:type" content="profile" />
	<meta property="og:title" content="{/data/person-single/entry/name} in the Irish Left Archive" />
	<meta property="og:url" content="{$root}/people/{/data/person-single/entry/@id}/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="metadata-image">
	<xsl:choose>
		<xsl:when test="/data/person-single/entry/picture">
			<xsl:apply-templates select="/data/person-single/entry/picture" mode="metadata-image-raw">
				<xsl:with-param name="alt" select="/data/person-single/entry/name" />
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="metadata-image-default" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'People'" />
		<xsl:with-param name="link" select="'/browse/people/'" />
		<xsl:with-param name="position" select="'2'" />
	</xsl:call-template>

	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="/data/person-single/entry/name" />
		<xsl:with-param name="link">/people/<xsl:value-of select="/data/params/id" />/</xsl:with-param>
		<xsl:with-param name="position" select="'3'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
