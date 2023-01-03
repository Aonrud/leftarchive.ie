<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/layout-sidecolumn.xsl"/>
<xsl:import href="../utilities/section-comments.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/section-collections.xsl"/>
<xsl:import href="../utilities/section-documents.xsl"/>
<xsl:import href="../utilities/general-strings.xsl"/>
<xsl:import href="../utilities/entry-identifiers.xsl"/>
<xsl:import href="../utilities/entry-wikipedia.xsl"/>
<xsl:import href="../utilities/meta-redirect.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<xsl:apply-templates select="subject-single/entry" />
</xsl:template>

<xsl:template name="head-insert">
	<xsl:if test="/data/subject-single/entry/linked">
		<xsl:call-template name="redirect">
			<xsl:with-param name="url">
				<xsl:call-template name="get-url">
					<xsl:with-param name="id" select="/data/subject-single/entry/linked/item/@id" />
					<xsl:with-param name="section" select="/data/subject-single/entry/linked/item/@section-handle" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<!--Redirect page-->
<xsl:template match="subject-single/entry[linked]">
	<article>
		<header class="page-header">
			<h1><xsl:value-of select="name" /></h1>
		</header>
		<h2><span class="fas fa-level-up-alt fa-rotate-90 fa-sm"></span>&#160;
			<a title="For information on {name}, see the {linked/item} page.">
				<xsl:attribute name="href">
					<xsl:call-template name="get-url">
						<xsl:with-param name="id" select="linked/item/@id" />
						<xsl:with-param name="section" select="linked/item/@section-handle" />
					</xsl:call-template>
				</xsl:attribute>
				<xsl:value-of select="linked/item" />
			</a>
		</h2>
		<p class="lead text-muted">This is a redirect page. If you are not redirected automatically, please follow the link above.</p>
		<table class="table">
			<tr><th scope="row">Name</th><td><xsl:value-of select="name" /></td></tr>
			<tr><th scope="row">Linked entry</th><td><xsl:value-of select="linked/item" /></td></tr>
		</table>
	</article>
</xsl:template>

<xsl:template match="subject-single/entry[not(linked)]">
	<div class="page-header">
        <h1><xsl:value-of select="name"/></h1>
    </div>
    
    <div class="row">
        <div class="col-sm-8">
            <xsl:apply-templates select="date" />
            <xsl:apply-templates select="summary/*" mode="html" />
            
            <xsl:if test="not(summary)">
                <xsl:apply-templates select="links/key[@handle='wikipedia']" mode="wiki-insert" />
            </xsl:if>
            
            <xsl:apply-templates select="include-in" />
			<xsl:apply-templates select="/data/subjects-included[entry]" />
            <xsl:apply-templates select="/data/documents-list[entry]" />
            <xsl:apply-templates select="/data/demonstrations-list[entry]" />
            <xsl:apply-templates select="/data/podcast-related[entry]" />
            <xsl:apply-templates select="links" />
        </div>
        <aside class="col-sm-4">           
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h4 class="panel-title">Your suggestions</h4>
                </div>
                <div class="panel-body">
                    <p>We welcome suggestions for subject headings - if you spot a document relevant to <xsl:value-of select="name" />, please use the <strong>Suggest a Subject</strong> button on the document page to let us know.</p>                    
                </div>
            </div>
            
            <xsl:apply-templates select="/data/collections-list-subject" />
            <xsl:apply-templates select="/data/subjects-list" />
        </aside>
    </div>
</xsl:template>

<xsl:template match="subject-single/entry/date">
    <p><span class="fas fa-calendar"></span><strong> Date: </strong>
    <xsl:call-template name="format-date">
        <xsl:with-param name="date" select="." />
        <xsl:with-param name="format" select="'D M Y'" />
    </xsl:call-template>
    </p>
</xsl:template>

<xsl:template match="subjects-minor/entry">
    <li><xsl:value-of select="group/item" /> - <xsl:value-of select="name" /></li>
</xsl:template>

<xsl:template match="documents-list">
	<h2>Documents</h2>
	<ul class="media-list">
		<xsl:apply-templates select="entry">
			<xsl:sort select="name" />
		</xsl:apply-templates>
	</ul>
</xsl:template>

<xsl:template match="documents-list/entry">
    <li class="media">
		<xsl:apply-templates select="." mode="document-linked-cover">
			<xsl:with-param name="class" select="'pull-left'" />
		</xsl:apply-templates>
		<div class="media-body">
		<h4>
			<xsl:apply-templates select="." mode="entry-link" />
		</h4>
			<xsl:apply-templates select="subtitle" />
			
			<ul class="list-unstyled text-muted">
				<li><span class="fas fa-fw fa-calendar"></span>&#8194;<xsl:value-of select="year" /><xsl:if test="uncertain = 'Yes'"> c.</xsl:if></li>
				<xsl:apply-templates select="organisation" />
				<xsl:apply-templates select="publication" />
				<xsl:apply-templates select="authors" />
				<xsl:apply-templates select="subjects" />
			</ul>
		</div>
    </li>
</xsl:template>

<xsl:template match="subtitle">
     <h5><xsl:value-of select="." /></h5>
</xsl:template>

<xsl:template match="organisation">
    <li><xsl:call-template name="section-icon"><xsl:with-param name="section" select="'organisations'" /></xsl:call-template>&#8194;<xsl:apply-templates select="item" mode="entry-list" /></li>
</xsl:template>

<xsl:template match="publication">
    <li><xsl:call-template name="section-icon"><xsl:with-param name="section" select="'publications'" /></xsl:call-template>&#8194;<xsl:apply-templates select="item" mode="entry-list" /></li>
</xsl:template>

<xsl:template match="authors|people">
    <li><xsl:call-template name="section-icon"><xsl:with-param name="section" select="'people'" /></xsl:call-template>&#8194;<xsl:apply-templates select="item" mode="entry-list" /></li>
</xsl:template>

<xsl:template match="subjects">
    <li>
        <span class="fas fa-fw fa-bookmark"></span>&#8194;
        <xsl:apply-templates select="item" mode="entry-list">
            <xsl:with-param name="separator" select="';'" />
        </xsl:apply-templates>
    </li>
</xsl:template>

<xsl:template match="demonstrations-list">
    <h2>Demonstrations</h2>
	<ul class="media-list">
		<xsl:apply-templates select="entry">
			<xsl:sort select="date" />
		</xsl:apply-templates>
	</ul>
</xsl:template>

<xsl:template match="demonstrations-list/entry">
    <li class="media">
        <a href="/demonstration/{@id}/" class="pull-left">
            <img src="/image/1/300/0{image/@path}/{image/filename}" class="img-responsive" alt="{name}" />
        </a>
		<div class="media-body">
		<h4>
			<xsl:apply-templates select="." mode="entry-link" />
		</h4>
			<xsl:apply-templates select="subtitle" />
			
			<ul class="list-unstyled text-muted">
				<li>
                    <span class="fas fa-fw fa-calendar"></span>&#160;
                    <xsl:call-template name="format-date">
                        <xsl:with-param name="date" select="date" />
                        <xsl:with-param name="format" select="'D M Y'" />
                    </xsl:call-template>
				</li>
				<li>
                    <span class="fas fa-fw fa-map"></span>&#160;
                    <xsl:value-of select="place/item/town" />, <xsl:value-of select="place/item/county" />
                </li>
			</ul>
		</div>
    </li>
</xsl:template>

<xsl:template match="collections-list-subject">
    <xsl:if test="entry">
        <h4>Related Collection</h4>
    </xsl:if>
    <xsl:apply-templates select="entry">
        <xsl:with-param name="section-icon" select="'Yes'" />
    </xsl:apply-templates>
</xsl:template>

<xsl:template match="subjects-list">
    <div class="panel panel-default">
        <div class="panel-body">
            <h4><xsl:value-of select="entry/group/item" /> Subject Headings</h4>
            <ul class="list-unstyled">
                <xsl:apply-templates select="entry" />
            </ul>
        </div>
    </div>
</xsl:template>

<xsl:template match="subjects-list/entry">
    <li><a href="/subject/{@id}/" title="{name}"><xsl:value-of select="name" /></a></li>
</xsl:template>

<xsl:template match="subjects-included">
	<p>Includes <xsl:choose><xsl:when test="count(entry) > 1">these </xsl:when><xsl:otherwise>this </xsl:otherwise></xsl:choose> related subject<xsl:if test="count(entry) > 1">s</xsl:if>:</p>
	<ul>
	<xsl:apply-templates select="entry">
		<xsl:sort select="date" />
		<xsl:sort select="name" />
	</xsl:apply-templates>
	</ul>
</xsl:template>

<xsl:template match="subjects-included/entry">
    <xsl:variable name="id">
        <xsl:choose>
            <xsl:when test="linked"><xsl:value-of select="linked/item/@id" /></xsl:when>
            <xsl:otherwise><xsl:value-of select="@id" /></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="path">
        <xsl:choose>
            <xsl:when test="group/item/@handle = 'people'">/people</xsl:when>
            <xsl:when test="group/item/@handle = 'organisations'">/organisation</xsl:when>
            <xsl:otherwise>/subject</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <li><a href="{$path}/{$id}/" title="{heading}"><xsl:value-of select="heading" /></a></li>
</xsl:template>

<xsl:template match="include-in">
	<p>See also:</p>
	<ul>
		<xsl:apply-templates select="item" />
	</ul>
</xsl:template>

<xsl:template match="include-in/item">
    <li><a href="/subject/{@id}/" title="{.}"><xsl:value-of select="." /></a></li>
</xsl:template>

<xsl:template match="subject-single/entry/links">
    <h2>Further information / External links</h2>
    <table class="identifiers">
        <xsl:apply-templates select="key" />
    </table>
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="/data/subject-single/entry/group/item" />: <xsl:value-of select="/data/subject-single/entry/name" />
	<xsl:text> — Subjects | </xsl:text><xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">Political material on <xsl:value-of select="/data/subject-single/entry/name" /> in the Irish Left Archive.      <xsl:if test="/data/documents-list/entry/organisation"> Documents from <xsl:apply-templates select="/data/documents-list/entry/organisation/item[not(name = preceding::organisation/item/name)]" mode="entry-list"><xsl:with-param name="last-and" select="'Yes'" /></xsl:apply-templates>.</xsl:if>    </xsl:variable>

    <meta name="description" content="{$description}" />

    <meta property="og:type" content="article" />
    <meta property="og:title" content="{/data/subject-single/entry/heading}" />
    <meta property="og:url" content="{/data/params/root}/browse/subject/{/data/subject-single/entry/@id}/" />
    <meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Browse: Subjects'" />
		<xsl:with-param name="link">/browse/subjects/</xsl:with-param>
		<xsl:with-param name="position" select="'2'" />
	</xsl:call-template>
	
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name">
			<xsl:value-of select="/data/subject-single/entry/group/item" />: <xsl:value-of select="/data/subject-single/entry/name" />
		</xsl:with-param>
		<xsl:with-param name="link">/subject/<xsl:value-of select="/data/params/id" />/</xsl:with-param>
		<xsl:with-param name="position" select="'3'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
