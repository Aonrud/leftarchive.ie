<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/general-strings.xsl"/>
<xsl:import href="../utilities/general-text-highlight.xsl"/>
<xsl:import href="../utilities/general-datetime.xsl" />
<xsl:import href="../utilities/layout-sidecolumn.xsl" />
<xsl:import href="../utilities/section-personal-account-topics.xsl"/>
	
<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:variable name="filtered">
    <xsl:choose>
        <xsl:when test="/data/params/url-topic != '' or /data/params/url-associations != '' or /data/params/url-keywords != ''">Yes</xsl:when>
        <xsl:otherwise>No</xsl:otherwise>
    </xsl:choose>
</xsl:variable>

<xsl:template match="data[params/id = '']">
	<header class="page-header">
		<h1>Personal Accounts</h1>
	</header>
	
	<xsl:call-template name="pa-intro" />
		
	<div class="row">
        <div class="col-sm-9">
            <hr />
            <p>Accounts can be filtered using the topic headings or by keyword using the form below.</p>
            <form action="" method="get" class="form-inline">
                <div class="form-group">
                    <label for="topic">Topic</label>
                    <select name="topic">
                        <option value="">Any Topic</option>
                        <xsl:apply-templates select="/data/personal-account-topics-list/entry[@personal-accounts &gt; 0]" mode="select" />
                    </select>
                </div>
                <div class="form-group">
                    <label for="keywords">Keywords</label>
                    <div class="input-group">
                        <xsl:if test="/data/params/url-keywords != ''"><xsl:attribute name="class">input-group has-feedback</xsl:attribute></xsl:if>
                        <input name="keywords" type="search" value="{/data/params/url-keywords}" class="form-control" />
                        <xsl:if test="/data/params/url-keywords != ''"><span class="fas fa-times-circle form-control-feedback"></span></xsl:if>
                    </div>
                </div>
                <button type="submit" title="Apply filters" class="btn btn-default"><span class="fas fa-filter"></span></button>
                <a href="/personal-accounts/" title="Clear all filters">
                    <xsl:attribute name="class">
                        <xsl:text>btn btn-default</xsl:text>
                        <xsl:if test="$filtered = 'No'">
                            <xsl:text> disabled</xsl:text>
                        </xsl:if>
                    </xsl:attribute>
                    <span class="fas fa-ban"></span>
                </a>                    
            </form>
            <hr />
            <xsl:if test="$filtered = 'Yes'">
                <p><em>
                    <xsl:choose>
                        <xsl:when test="count(personal-accounts-list/entry) = 0">No matches found. <a title="Reset filters" href="/personal-accounts/">Reset filters.</a></xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="count(personal-accounts-list/entry)" />
                            <xsl:choose>
                                <xsl:when test="count(personal-accounts-list/entry) = 1">
                                    <xsl:text> entry</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text> entries</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                           <xsl:text> matching your filters.</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </em></p>
            </xsl:if>
            <xsl:apply-templates select="personal-accounts-list/entry" />
            <xsl:apply-templates select="personal-account-single/entry" />
        </div>
        <aside class="col-sm-3">
            <xsl:call-template name="sidecolumn" />
        </aside>
	</div>
</xsl:template>

<xsl:template match="data[params/id != '']">
    <header>
        <h1>Personal Account #<xsl:value-of select="/data/params/id" /></h1>
    </header>
    <xsl:call-template name="pa-intro" />
    <div class="row">
        <div class="col-sm-9">
            <hr />
            <p>You are viewing a single entry. <a href="/personal-accounts/" class="btn btn-default"><span class="fas fa-arrow-left"></span> Browse all personal accounts</a></p>
            <hr />
            <xsl:apply-templates select="personal-account-single/entry" />
        </div>
        <aside class="col-sm-3">
            <xsl:call-template name="sidecolumn" />
        </aside>
	</div>

</xsl:template>

<xsl:template match="entry[../section/@handle = 'personal-accounts']">
    <article class="bordered">
        <header>
            <h3><xsl:value-of select="name" />&#160;<small>#<xsl:value-of select="@id" /></small></h3>
            <ul class="list-unstyled text-muted">
                <li><span class="fas fa-user fa-fw"></span>&#160;<xsl:value-of select="name" /></li>
                <li><span class="fas fa-calendar fa-fw"></span>&#160;<xsl:call-template name="format-date"><xsl:with-param name="date" select="date/@iso"/><xsl:with-param name="format" select="'D M Y'"/></xsl:call-template></li>
                <xsl:apply-templates select="topic/item" />
                <xsl:apply-templates select="associations[item]" />
            </ul>
        </header>
        <blockquote>
            <xsl:apply-templates select="edited/*" />
        </blockquote>
        <footer>
            <a href="/personal-accounts/{@id}/"><span class="fas fa-link"></span> Direct link to personal account #<xsl:value-of select="@id" /></a>
        </footer>
    </article>
</xsl:template>

<xsl:template name="pa-intro">
    <p class="lead">As part of the Irish Left Archive project, we are gathering personal accounts and recollections from activists on the Left of their involvement in political activity, parties, organisation and campaigns.</p>
	<p>We hope that in addition to the document archive, these accounts will provide a social context to political participation. If you are or have been involved in Left political activity of any kind or at any level, we'd be grateful if you would also add your experience to the collection. <a href="/personal-accounts/submit/">You can submit your account here <span class="fas fa-arrow-right"></span></a></p>
</xsl:template>

<xsl:template match="topic/item">
    <li><span class="fas fa-question-circle fa-fw"></span>&#160;<a><xsl:attribute name="href"><xsl:call-template name="get-filtered-url"><xsl:with-param name="topic" select="@id" /></xsl:call-template></xsl:attribute><xsl:value-of select="." /></a></li>
</xsl:template>

<xsl:template match="associations">
    <li><span class="fas fa-tags fa-fw"></span>&#160;<xsl:apply-templates select="item" /></li>
</xsl:template>

<xsl:template match="associations/item">
    <xsl:if test="position() &gt; 1">, </xsl:if>
    <xsl:value-of select="." />
</xsl:template>

<xsl:template match="edited/*">
    <xsl:element name="{name()}">
        <xsl:apply-templates select="text()" />
    </xsl:element>
</xsl:template>

<xsl:template match="edited/*/text()">
    <xsl:choose>
        <xsl:when test="/data/params/url-keywords != ''">
            <xsl:call-template name="text-highlight">
                <xsl:with-param name="text" select="." />
                <xsl:with-param name="search" select="/data/params/url-keywords" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="." />
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- Link associations to filters. Leave this disabled until there's some data to work with.
<xsl:template match="/associations/item">
    <xsl:if test="position() &gt; 1"> ,</xsl:if>
    <a>
    <xsl:attribute name="href">
        <xsl:call-template name="get-filtered-url">
            <xsl:with-param name="associations">
                <xsl:value-of select="/data/params/url-associations" />
                <xsl:if test="/data/params/url-associations != ''">,</xsl:if>
                <xsl:value-of select="@id" />
            </xsl:with-param>
        </xsl:call-template>
    </xsl:attribute>
        <xsl:value-of select="." />
    </a>
</xsl:template>-->

<xsl:template name="get-filtered-url">
    <xsl:param name="topic" select="/data/params/url-topic" />
    <xsl:param name="associations" select="/data/params/url-associations" />
    <xsl:param name="keywords" select="/data/params/url-keywords" />
    <xsl:text>/personal-accounts/?</xsl:text>
    <xsl:if test="$topic != ''">topic=<xsl:value-of select="$topic" /></xsl:if>
    <xsl:if test="$topic != '' and $associations != ''">&amp;</xsl:if>
    <xsl:if test="$associations != ''">associations=<xsl:value-of select="$associations" /></xsl:if>
    <xsl:if test="($topic != '' or $associations != '') and $keywords != ''">&amp;</xsl:if>
    <xsl:if test="$keywords != ''">keywords=<xsl:value-of select="$keywords" /></xsl:if>
</xsl:template>

<xsl:template name="page-title">
    <xsl:choose>
        <xsl:when test="/data/params/id != ''">Personal Account #<xsl:value-of select="/data/params/id" /></xsl:when>
        <xsl:otherwise>Personal Accounts</xsl:otherwise>
    </xsl:choose>
	<xsl:text> | Irish Left Archive</xsl:text>
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">Browse personal accounts from people involved in Left politics in Ireland. The Irish Left Archive is gathering recollections from activists on the Left of their involvement in political activity, parties, organising and campaigns.</xsl:variable>
	
	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Personal Accounts in the Irish Left Archive" />
	<meta property="og:url" content="{/data/params/root}/personal-accounts/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Personal Accounts'" />
		<xsl:with-param name="link" select="'/personal-accounts/'" />
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active">
            <xsl:choose>
                <xsl:when test="/data/params/id = ''">Yes</xsl:when>
                <xsl:otherwise>No</xsl:otherwise>
            </xsl:choose>
        </xsl:with-param>
	</xsl:call-template>
	
	<xsl:if test="/data/params/id != ''">
        <xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name">
            <xsl:value-of select="/data/personal-account-single/entry/name" /> #<xsl:value-of select="/data/params/id" />
        </xsl:with-param>
		<xsl:with-param name="link" select="concat('/personal-accounts/',$id,'/')" />
		<xsl:with-param name="position" select="'3'" />
        <xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
