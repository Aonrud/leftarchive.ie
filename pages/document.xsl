<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/layout-sidecolumn.xsl"/>
<xsl:import href="../utilities/section-comments.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/section-documents.xsl"/>
<xsl:import href="../utilities/meta-notices.xsl"/>
<xsl:import href="../utilities/metadata-coins.xsl"/>
<xsl:import href="../utilities/layout-share.xsl"/>
<xsl:import href="../utilities/general-ordinals.xsl"/>
<xsl:import href="../utilities/section-subjects.xsl"/>
<xsl:import href="../utilities/section-demonstrations.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
<article>
<header class="page-header">
	<h1 about="#doc" property="schema:name"><xsl:value-of select="document-single/entry/name"/></h1>
	<h2><xsl:value-of select="document-single/entry/subtitle" /></h2>
</header>

<div class="page-fields">
<div class="row">

	<div class="col-sm-4">
		<img src="/image/1/400/0{document-single/entry/cover-image/@path}/{document-single/entry/cover-image/filename}" class="doc-cover img-responsive" alt="{document-single/entry/name}" property="schema:image" about="#doc" />
	</div>

	<div class="col-sm-8">
		<table class="table" resource="#doc">
			<xsl:attribute name="typeof">
				<xsl:apply-templates select="document-single/entry" mode="entry-schema-type" />
			</xsl:attribute>
			<tr>
				<th scope="row"><span class="fas fa-calendar fa-fw"></span> Date:</th>
				<td property="schema:datePublished">
					<xsl:choose>
						<xsl:when test="not(document-single/entry/issue-period) and (document-single/entry/day or document-single/entry/month)">
						
							<xsl:variable name="day">
								<xsl:choose>
									<xsl:when test="document-single/entry/day"><xsl:value-of select="document-single/entry/day" /></xsl:when>
									<xsl:otherwise>01</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							
							<xsl:variable name="format">
								<xsl:choose>
									<xsl:when test="document-single/entry/day">D M Y</xsl:when>
									<xsl:otherwise>M Y</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
						
						
							<xsl:call-template name="format-date"><xsl:with-param name="date"><xsl:value-of select="document-single/entry/year" />-<xsl:if test="string-length(document-single/entry/month) = 1">0</xsl:if><xsl:value-of select="document-single/entry/month" />-<xsl:if test="string-length($day) = 1">0</xsl:if><xsl:value-of select="$day" /></xsl:with-param><xsl:with-param name="format" select="$format" /></xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="document-single/entry/year" /><xsl:if test="document-single/entry/uncertain = 'Yes'"> c.</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			
			<xsl:apply-templates select="document-single/entry/organisation" />
			<xsl:apply-templates select="document-single/entry/publication" />
			
			<xsl:if test="document-single/entry/type/item/@handle = 'publication-issue' or document-single/entry/type/item/@handle = 'article'">
				<tr>
					<th scope="row"><span class="fas fa-clock fa-fw"></span> Issue:</th>
					<td>
						<xsl:if test="document-single/entry/volume">
							<xsl:text>Volume </xsl:text><span property="schema:isPartOf" typeof="schema:PublicationVolume"><span property="schema:volumeNumber"><xsl:value-of select="document-single/entry/volume" /></span></span><xsl:text>, </xsl:text>
						</xsl:if>
						<xsl:if test="document-single/entry/issue">
							<xsl:text>Number </xsl:text><span property="schema:issueNumber"><xsl:value-of select="document-single/entry/issue" /></span>
						</xsl:if>
						<xsl:if test="document-single/entry/issue and document-single/entry/issue-period"><br /></xsl:if>
						<xsl:value-of select="document-single/entry/issue-period" />
					</td>
				</tr>
			</xsl:if>
			
			<xsl:apply-templates select="document-single/entry/edition" />
			<xsl:apply-templates select="document-single/entry/series" />
			<xsl:apply-templates select="document-single/entry/authors" />
			
			<xsl:if test="document-single/entry/contributors or document-single/entry/uncredited">
				<xsl:apply-templates select="document-single/entry" mode="contributors" />
			</xsl:if>

			<xsl:apply-templates select="/data/collections-list-document[entry]" /> 
			
			<tr><th scope="row"><span class="fas fa-eye fa-fw"></span>  View:</th><td><span class="fas fa-file-pdf"></span><xsl:text> </xsl:text><a href="/document/view/{document-single/entry/@id}" title="View PDF of {document-single/entry/name}"> View Document</a></td></tr>
			
			<xsl:apply-templates select="document-single/entry/errata" />
            <xsl:apply-templates select="document-single/entry/front-text" />
			
			<tr><th scope="row"><span class="fas fa-comment fa-fw"></span> Discuss:</th><td><a href="#comments" property="schema:discussionUrl">Comments on this document</a></td></tr>
            
            <xsl:call-template name="subjects-table" />
		</table>

		<xsl:call-template name="metadata-coins" />

		<xsl:call-template name="share-links">
			<xsl:with-param name="title"><xsl:value-of select="document-single/entry/name" /><xsl:if test="document-single/entry/subtitle">: <xsl:value-of select="document-single/entry/subtitle" /></xsl:if></xsl:with-param>
			<xsl:with-param name="alignment">right</xsl:with-param>
		</xsl:call-template>
		
		<p>
            <em><strong>Please note:</strong>&#160;
                <xsl:choose>
                    <xsl:when test="document-single/entry/copyright">
						<xsl:value-of select="document-single/entry/copyright" />
					</xsl:when>
					<xsl:when test="/data/demonstrations-document/entry">
						<xsl:call-template name="copyright">
							<xsl:with-param name="project" select="'Snapshots of Political Action'" />
						</xsl:call-template>
					</xsl:when>
                    <xsl:otherwise>
						<xsl:call-template name="copyright" />
                    </xsl:otherwise>
                </xsl:choose>
            </em>
        </p>
	</div>
</div><!--row-->
</div><!--page-fields-->


<div class="row">
	<div class="col-sm-9">

		<section>
			<header>
			<h2>Commentary <small>From The Cedar Lounge Revolution</small></h2>
			<p class="text-right text-muted"><small><xsl:call-template name="format-date"><xsl:with-param name="date" select="document-single/entry/added/@iso"/><xsl:with-param name="format" select="'D M Y'"/></xsl:call-template></small></p>
			</header>
			<xsl:apply-templates select="document-single/entry/about/*" mode="html"/>
			<xsl:if test="/data/demonstrations-document/entry">
				<xsl:call-template name="snapshots-commentary-footer" />
			</xsl:if>
		</section>
		
		<xsl:choose>
			<xsl:when test="/data/demonstrations-document/entry">
				<hr />
				<xsl:apply-templates select="/data/demonstrations-document" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="related-documents" />
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:apply-templates select="comments" />

	</div>
	
	<aside class="col-sm-3">
		<xsl:call-template name="sidecolumn" />
	</aside>

</div>
</article>
</xsl:template>

<xsl:template match="document-single/entry/organisation">
	<tr>
		<th scope="row">
			<span class="fas fa-users fa-fw"></span> Organisation<xsl:if test="count(item) > 1">s</xsl:if>:
		</th>
		<td>
			<xsl:apply-templates select="item" mode="entry-list-linked">
				<xsl:with-param name="rdfa" select="'Yes'" />
				<xsl:with-param name="property" select="'schema:publisher'" />
			</xsl:apply-templates>
		</td>
	</tr>
</xsl:template>

<xsl:template match="document-single/entry/publication">
	<tr>
		<th scope="row">
			<span class="fas fa-newspaper fa-fw"></span> Publication:
		</th>
		<td>
			<xsl:apply-templates select="item" mode="entry-list-linked">
				<xsl:with-param name="rdfa" select="'Yes'" />
				<xsl:with-param name="property" select="'schema:isPartOf'" />
			</xsl:apply-templates>
		</td>
	</tr>
</xsl:template>

<xsl:template match="edition">
	<tr>
		<th scope="row"><span class="fas fa-book fa-fw"></span> Edition:</th>
		<td>
			<xsl:choose>
				<xsl:when test="number(current()) = current()">
					<xsl:call-template name="ordinals">
						<xsl:with-param name="no" select="." />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="." />
				</xsl:otherwise>
			</xsl:choose>						
		</td>
	</tr>
</xsl:template>

<xsl:template match="series">
	<tr>
		<th scope="row"><span class="fas fa-book fa-fw"></span> Series:</th>
		<td>
			<span property="schema:isPartOf" typeof="schema:BookSeries">
				<span property="schema:name"><xsl:value-of select="." /></span>
			</span>
			<xsl:if test="../issue">
				<xsl:text>, Number </xsl:text>
				<xsl:value-of select="../issue" />
			</xsl:if>
			<xsl:if test="../issue-period">
				<xsl:text>, </xsl:text>
				<xsl:value-of select="../issue-period" />
			</xsl:if>
		</td>
	</tr>
</xsl:template>

<xsl:template match="authors">
	<tr>
		<th scope="row"><span class="fas fa-user fa-fw"></span> Author<xsl:if test="count(item) > 1">s</xsl:if>:</th>
		<td>
			<xsl:apply-templates select="item" mode="entry-list-linked">
				<xsl:sort select="sort-name" />
				<xsl:with-param name="rdfa" select="'Yes'" />
				<xsl:with-param name="property" select="'schema:author'" />
			</xsl:apply-templates>
		</td>
	</tr>
</xsl:template>

<xsl:template match="document-single/entry" mode="contributors">
	<tr>
		<th>
			<div class="nowrap">
				<span class="fas fa-user fa-fw"></span>
				Contributor<xsl:if test="count(contributors/item|uncredited/item) > 1">s</xsl:if>:
				<a href="#" class="tooltip-icon" data-toggle="tooltip" title="Contributors lists may be incomplete and only include those with existing entries in the archive">
					<sup>
						<span class="sr-only">Info</span>
						<i class="fa-solid fa-fw fa-info"></i>
					</sup>
				</a>
			</div>
		</th>
		<td>
			<xsl:apply-templates select="contributors/item|uncredited/item" mode="entry-list-linked">
				<xsl:sort select="sort-name" />
				<xsl:with-param name="rdfa" select="'Yes'" />
				<xsl:with-param name="property" select="'schema:contributor'" />
				<xsl:sort select="name" />
			</xsl:apply-templates>
		</td>
	</tr>
</xsl:template>

<!--Override entry-name for uncredited contributors so that a suffix can be added after the name.
	This is the template called ultimately by entry-list-linked -->
<xsl:template match="uncredited/item" mode="entry-name">
	<xsl:value-of select="name" />
	<xsl:text> [uncredited]</xsl:text>
</xsl:template>

<xsl:template match="errata">
	<tr>
		<th scope="row"><span class="fas fa-exclamation fa-fw"></span> Errata:</th>
		<td>
			<ul class="list-unstyled">
				<xsl:apply-templates select="key" />
			</ul>
		</td>
	</tr>
</xsl:template>

<xsl:template match="errata/key">
	<li><xsl:value-of select="value" /></li>
</xsl:template>

<xsl:template match="front-text">
    <tr>
        <th scope="row"><span class="fas fa-align-left fa-fw"></span> Front text:</th>
        <td><blockquote><xsl:apply-templates select="./*" mode="html"/></blockquote></td>
    </tr>
</xsl:template>

<xsl:template match="collections-list-document">
	<tr>
		<th scope="row"><span class="fas fa-archive fa-fw"></span> Collection<xsl:if test="count(entry) > 1">s</xsl:if>:</th>
		<td>
			<xsl:apply-templates select="entry" mode="entry-list-linked">
				<xsl:param name="linked" select="'Yes'" />
				<xsl:param name="rdfa" select="'Yes'" />
				<xsl:param name="property" select="'schema:isPartOf'" />
			</xsl:apply-templates>
		</td>
	</tr>
</xsl:template>

<xsl:template match="demonstrations-document[entry]">
	<xsl:apply-templates select="." mode="footer" />
</xsl:template>

<xsl:template name="related-documents">
	<xsl:choose>
		<xsl:when test="/data/documents-related-by-publication/entry">
			<xsl:apply-templates select="documents-related-by-publication" />
		</xsl:when>
		<xsl:when test="/data/documents-related-by-organisation/entry">
			<xsl:apply-templates select="documents-related-by-organisation" />
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template match="documents-related-by-publication|documents-related-by-organisation">
	<xsl:variable name="name">
		<xsl:choose>
			<xsl:when test="local-name() = 'documents-related-by-publication'">
				<xsl:value-of select="/data/document-single/entry/publication/item/name" />
			</xsl:when>
			<xsl:when test="local-name() = 'documents-related-by-organisation'">
				<xsl:value-of select="/data/document-single/entry/organisation/item/name" />
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="href">
		<xsl:choose>
			<xsl:when test="local-name() = 'documents-related-by-publication'">
				<xsl:apply-templates select="/data/document-single/entry/publication/item" mode="entry-url" />
			</xsl:when>
			<xsl:when test="local-name() = 'documents-related-by-organisation'">
				<xsl:apply-templates select="/data/document-single/entry/organisation/item" mode="entry-url" />
			</xsl:when>
		</xsl:choose>
	</xsl:variable>

	<h3>More from <xsl:value-of select="$name" /></h3>
	<div class="row">
		<xsl:apply-templates select="entry" mode="documents-thumbnails" />
	</div>
	<p>
		<a href="{$href}">
			<strong>
				<em><xsl:value-of select="$name" /></em> in the archive <span class="fas fa-angle-double-right"></span>
			</strong>
		</a>
	</p>
</xsl:template>

<xsl:variable name="meta-title">
	<xsl:value-of select="/data/document-single/entry/name" /> 
	(<xsl:value-of select="/data/document-single/entry/year" /><xsl:if test="/data/document-single/entry/uncertain = 'Yes'"> c.</xsl:if>)
	<xsl:if test="/data/document-single/entry/organisation/item">
		<xsl:text> — </xsl:text>
		<xsl:apply-templates select="/data/document-single/entry/organisation/item" mode="entry-list" />
	</xsl:if>
	<xsl:if test="not(/data/document-single/entry/organisation/item) and /data/document-single/entry/authors/item"> — <xsl:apply-templates select="/data/document-single/entry/authors/item" mode="entry-list" /></xsl:if>
</xsl:variable>

<xsl:template name="page-title">
	<xsl:value-of select="$meta-title" /> | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-image">
	<xsl:apply-templates select="/data/document-single/entry/cover-image" mode="metadata-image-scale">
		<xsl:with-param name="alt">
			<xsl:text>Front page of </xsl:text>
			<xsl:value-of select="/data/document-single/entry/name" />
		</xsl:with-param>
	</xsl:apply-templates>
</xsl:template>

<xsl:variable name="metadata-twitter-card">summary_large_image</xsl:variable>

<xsl:template name="metadata-general">
	<xsl:variable name="description">Commentary and PDF of <xsl:value-of select="/data/document-single/entry/name" /><xsl:if test="/data/document-single/entry/authors/item"> by <xsl:apply-templates select="/data/document-single/entry/authors/item" mode="entry-list" /></xsl:if><xsl:if test="/data/document-single/entry/organisation/item">, published by <xsl:apply-templates select="/data/document-single/entry/organisation/item" mode="entry-list" /></xsl:if>.</xsl:variable>

	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="{$meta-title}" />
	<meta property="og:url" content="{$root}/document/{/data/document-single/entry/@id}/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Documents'" />
		<xsl:with-param name="link" select="'/documents/'" />
		<xsl:with-param name="position" select="'2'" />
	</xsl:call-template>

	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" >
			<xsl:call-template name="word-truncate">
				<xsl:with-param name="string" select="/data/document-single/entry/name" />
				<xsl:with-param name="lenth" select="'50'" />
				<xsl:with-param name="ellipses" select="'Yes'" />
			</xsl:call-template>
		</xsl:with-param>
		<xsl:with-param name="link">/document/<xsl:value-of select="/data/params/id" />/</xsl:with-param>
		<xsl:with-param name="position" select="'3'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="end-insert">
	<xsl:if test="/data/demonstrations-document/entry">
	<script type="text/javascript">
		new ila.Scroller(
			document.querySelector(".scroller"),
			{
				classes: {
					left: "scroller-left btn btn-default btn-scroller",
					right: "scroller-right btn btn-default btn-scroller",
				},
				texts: {	
					left: '',
					right:'',
				},
				icons: {
					left: "far fa-arrow-alt-circle-left",
					right: "far fa-arrow-alt-circle-right",
				},
				breakpoints: [ [0, 2], [768, 3] ]
			}
		);
	</script>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
