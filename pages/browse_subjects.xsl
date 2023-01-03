<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/layout-sidecolumn.xsl"/>
<xsl:import href="../utilities/master.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
    <div class="page-header">
        <h1>Subjects</h1>
    </div>

    <p class="lead">
        All subject headings in the archive are listed below, grouped by subject type.
    </p>   
    <p>Use the tabs below to show <xsl:if test="/data/params/type != ''">the full index or </xsl:if> the index for each entry type.</p>

    <ul class="nav nav-tabs">
    <li><a href="/browse/" title="Full Index"><span class="fas fa-bars fa-fw"></span><span class="hidden-xs"> Full Index</span></a></li>
    <li><a href="/browse/organisations/" title="Organisations"><span class="fas fa-users fa-fw"> </span><span class="hidden-xs"> Organisations</span></a></li>
    <li><a href="/browse/international-organisations/" title="International Organisations"><span class="fas fa-globe-europe fa-fw"> </span><span class="hidden-xs"> International</span></a></li>
    <li><a href="/browse/publications/" title="Publications"><span class="fas fa-newspaper fa-fw"></span><span class="hidden-xs"> Publications</span></a></li>
    <li><a href="/browse/people/" title="People"><span class="fas fa-user fa-fw"></span><span class="hidden-xs"> People</span></a></li>
    <li class="active"><a href="/subjects/" title="Subjects"><span class="fas fa-bookmark fa-fw"></span><span class="hidden-xs"> Subjects</span></a></li>
    </ul>
    <p></p>

    <section class="index">
        <xsl:apply-templates select="subjects-list-grouped/group">
            <xsl:sort select="@link-handle" />
        </xsl:apply-templates>
    </section>

</xsl:template>

<xsl:template match="subjects-list-grouped/group">
    <h2><xsl:value-of select="@value" /></h2>
    <ul class="list-unstyled">
        <xsl:apply-templates select="entry">
            <xsl:sort select="date" />
        </xsl:apply-templates>
    </ul>
</xsl:template>

<xsl:template match="subjects-list-grouped/group/entry">
    <li><a href="/subject/{@id}/" title="{name}"><xsl:value-of select="name" /></a></li>
</xsl:template>

<xsl:template name="page-title">
Browse All Subject Headings | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">Index of subject headings in the Irish Left Archive - policy areas, elections, referendums, historical events.</xsl:variable>

    <meta name="description" content="{$description}" />

    <meta property="og:type" content="article" />
    <meta property="og:title" content="Index of Subjects in the Irish Left Archive" />
    <meta property="og:url" content="{/data/params/root}/browse/subjects/" />
    <meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Browse: Subjects'" />
		<xsl:with-param name="link">/browse/subjects/</xsl:with-param>
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
