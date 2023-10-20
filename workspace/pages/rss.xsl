<!-- <?xml version="1.0" encoding="UTF-8"?> -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:atom="http://www.w3.org/2005/Atom" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:media="http://search.yahoo.com/mrss/">
<xsl:import href="../utilities/general-html.xsl"/>
<xsl:import href="../utilities/general-datetime.xsl"/>
<xsl:import href="../utilities/entry.xsl"/>

<xsl:output method="xml" encoding="UTF-8" indent="yes" />
<xsl:template match="/">
<rss version="2.0">
    <channel>
        <title>Irish Left Archive</title>
        <link><xsl:value-of select="$root" /></link>
        <description>Newest additions to the Irish Left Archive.</description>
<copyright>&#169; Irish Left Archive <xsl:value-of select="$this-year" /></copyright>
<atom:link href="{$root}/rss/" rel="self" type="application/rss+xml" />
<language>en</language>
<image>
<title>Irish Left Archive</title>
<link><xsl:value-of select="$root" /></link>
<url><xsl:value-of select="$workspace" />/assets/images/icons/apple-touch-icon-144x144.png</url>
</image>

<xsl:apply-templates select="/data/documents-list-rss/entry|/data/collections-list-rss/entry|/data/articles-list-rss/entry|/data/demonstrations-list-rss/entry" mode="rss">
    <xsl:sort select="added/@iso" order="descending" />
</xsl:apply-templates>
    </channel>
</rss>
</xsl:template>

<xsl:template match="entry" mode="rss">
    <xsl:if test="position() &lt; 21">
        <xsl:variable name="url">
        <xsl:apply-templates select="." mode="entry-url">
            <xsl:with-param name="absolute" select="'Yes'" />
        </xsl:apply-templates>
        </xsl:variable>
        
        <xsl:variable name="image">
            <xsl:apply-templates select="." mode="entry-image-url" />
        </xsl:variable>
        
        <item>
            <title><xsl:apply-templates select="." mode="item-title" /></title>
            <link><xsl:value-of select="$url" /></link>
            <comments><xsl:value-of select="$url" />#comments</comments>
            <pubDate>
                <xsl:call-template name="format-date">
                    <xsl:with-param name="date" select="added"/>
                    <xsl:with-param name="format" select="'w, d m Y T'"/>
                </xsl:call-template>
                <xsl:text>:00 </xsl:text>
                <xsl:value-of select="translate($timezone,':','')"/>
            </pubDate>
            <guid><xsl:value-of select="$url" /></guid>
            <description>
                <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                <xsl:apply-templates select="." mode="item-description" />
                <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
            </description>
            <content:encoded>
                <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                <xsl:apply-templates select="." mode="item-content" />
                <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
            </content:encoded>
            
            <xsl:if test="$image != ''">
                <media:thumbnail url="{$root}/image/1/300/0{$image}" />
                <media:content url="{$root}/image/0{$image}" medium="image">
                    <media:title><xsl:value-of select="name" /></media:title>
                </media:content>
            </xsl:if>
        </item>
    </xsl:if>
</xsl:template>

<!--Documents-->
<xsl:template match="documents-list-rss/entry" mode="item-title">
    <xsl:text>New Document: </xsl:text>
    <xsl:value-of select="name" /> (<xsl:value-of select="year" /> <xsl:if test="uncertain = 'Yes'"> c.</xsl:if>)
    <xsl:if test="organisation/item"> — </xsl:if>
    <xsl:apply-templates select="organisation/item" mode="entry-list" />
</xsl:template>

<xsl:template match="documents-list-rss/entry" mode="item-description">
    <xsl:value-of select="name" />, published in <xsl:value-of select="year" /><xsl:if test="uncertain = 'Yes'"> c.</xsl:if><xsl:if test="organisation/item"> by <xsl:apply-templates select="organisation/item" /></xsl:if>. <xsl:if test="publication/item"> An edition of <xsl:value-of select="publication/item" />.</xsl:if>
</xsl:template>

<xsl:template match="documents-list-rss/entry" mode="item-content">
    <ul>
        <li><strong>Year: </strong> <xsl:value-of select="year" /> <xsl:if test="uncertain = 'Yes'">c.</xsl:if></li>
        <xsl:if test="organisation/item">
            <li><strong>Organisation: </strong> <xsl:apply-templates select="organisation/item" mode="entry-list" /></li>
        </xsl:if>
        <xsl:if test="publication/item">
            <li><strong>Publication: </strong> <xsl:value-of select="publication/item" mode="entry-list" /></li>
        </xsl:if>
        <xsl:if test="authors/item">
            <li><strong>Author: </strong> <xsl:apply-templates select="authors/item" mode="entry-list" /></li>
        </xsl:if>
        <li><strong>Download: </strong> <a href="{/data/params/workspace}{document/path}/{document/filename}" title="Download {name} ({document/@size})"><xsl:value-of select="document/filename" /></a></li>
    </ul>
    <img src="{$root}/image/1/900/0{cover-image/@path}/{cover-image/filename}" alt="{name}" />

    <h3>Commentary <small>From the Cedar Lounge Revolution</small></h3>
    <xsl:apply-templates select="about/*" mode="html"/>
</xsl:template>

<!--Collections-->
<xsl:template match="collections-list-rss/entry" mode="item-title">
    <xsl:text>New Collection: </xsl:text>
    <xsl:value-of select="name" />
</xsl:template>

<xsl:template match="collections-list-rss/entry" mode="item-description">
    <xsl:value-of select="summary" />
</xsl:template>

<xsl:template match="collections-list-rss/entry" mode="item-content">
    <xsl:if test="image/filename">
        <img src="{$root}/image/1/300/0{image/@path}/{image/filename}" alt="{name}" />
    </xsl:if>
    <xsl:apply-templates select="about/*" mode="html"/>
</xsl:template>

<!--Articles-->
<xsl:template match="articles-list-rss/entry" mode="item-title">
    <xsl:text>New Article: </xsl:text>
    <xsl:value-of select="name" />
</xsl:template>

<xsl:template match="articles-list-rss/entry" mode="item-description">
    <xsl:value-of select="content/p[position() = 1]" />
</xsl:template>

<xsl:template match="articles-list-rss/entry" mode="item-content">
    <xsl:if test="image/filename">
        <img src="{$root}/image/1/800/0{image/@path}/{image/filename}" alt="{name}" />
    </xsl:if>
    <xsl:apply-templates select="content/*" mode="html"/>
</xsl:template>

<!--Demonstrations-->
<xsl:template match="demonstrations-list-rss/entry" mode="item-title">
    <xsl:text>Snapshots of Political Action: </xsl:text>
    <xsl:call-template name="format-date">
        <xsl:with-param name="date" select="date/@iso" />
        <xsl:with-param name="format" select="'D M Y'" />
    </xsl:call-template>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="name" />
</xsl:template>

<xsl:template match="demonstrations-list-rss/entry" mode="item-description">
    <xsl:value-of select="summary" />
</xsl:template>

<xsl:template match="demonstrations-list-rss/entry" mode="item-content">
    <img src="{$root}/image/1/800/0{image/@path}/{image/filename}" alt="Documents from {name}" />
    <xsl:apply-templates select="summary" />
</xsl:template>

</xsl:stylesheet>
