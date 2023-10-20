<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:atom="http://www.w3.org/2005/Atom" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:media="http://search.yahoo.com/mrss/" xmlns:dc="http://purl.org/dc/elements/1.1/">

<xsl:import href="../utilities/general-datetime.xsl"/>

<xsl:output method="xml" encoding="UTF-8" indent="yes" />
<xsl:template match="/">
<rss version="2.0">
    <channel>
        <title>Irish Left Archive Comments</title>
        <link><xsl:value-of select="$root" /></link>
        <description>Newest comments on the Irish Left Archive</description>
<copyright>&#169; Irish Left Archive <xsl:value-of select="$this-year" /></copyright>
<atom:link href="{$root}/rss/comments/" rel="self" type="application/rss+xml" />
<language>en</language>
<lastBuildDate>
            <xsl:call-template name="format-date">
                <xsl:with-param name="date" select="data/comments-rss/entry[position() = 1]/date"/>
                <xsl:with-param name="format" select="'w, d m Y T'"/>
            </xsl:call-template>
            <xsl:text>:00 </xsl:text>
            <xsl:value-of select="translate($timezone,':','')"/>
</lastBuildDate>
<image>
<title>Irish Left Archive</title>
<link><xsl:value-of select="$root" /></link>
<url><xsl:value-of select="$workspace" />/assets/images/icons/apple-touch-icon-144x144.png</url>
</image>

<xsl:apply-templates select="data/comments-rss/entry" />

    </channel>
</rss>
</xsl:template>


<xsl:template match="comments-rss/entry">
 <item>
      <title><xsl:value-of select="title" /></title>
<xsl:variable name="full-url">
<xsl:value-of select="$root" />
<xsl:if test="associated-page/item/@section-handle = 'documents'"><xsl:text>/document/</xsl:text></xsl:if>
<xsl:if test="associated-page/item/@section-handle = 'organisations'"><xsl:text>/organisation/</xsl:text></xsl:if>
<xsl:if test="associated-page/item/@section-handle = 'publications'"><xsl:text>/publication/</xsl:text></xsl:if>
<xsl:if test="associated-page/item/@section-handle = 'pages'"><xsl:text>/information/</xsl:text></xsl:if>
<xsl:if test="associated-page/item/@section-handle = 'collections'"><xsl:text>/collection/</xsl:text></xsl:if>
<xsl:if test="associated-page/item/@section-handle = 'people'"><xsl:text>/people/</xsl:text></xsl:if>
<xsl:value-of select="associated-page/item/@id" />/#comment-<xsl:value-of select="@id" />
</xsl:variable>
      <link>
<xsl:value-of select="$full-url" />
	</link>
      <pubDate>
            <xsl:call-template name="format-date">
                <xsl:with-param name="date" select="date"/>
                <xsl:with-param name="format" select="'w, d m Y T'"/>
            </xsl:call-template>
            <xsl:text>:00 </xsl:text>
            <xsl:value-of select="translate($timezone,':','')"/>
</pubDate>
<dc:creator><xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
<xsl:value-of select="name" />
<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text></dc:creator>
      <guid><xsl:value-of select="$full-url" /></guid>
      <description><xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
<xsl:value-of select="comment" />
<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
</description>
<content:encoded>
<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
<p><em><xsl:value-of select="name" /> commented on <xsl:value-of select="associated-page/item" />:</em></p>
<!--<xsl:apply-templates select="comment/*" mode="html" />-->
<xsl:copy-of select="comment/*" />
<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
</content:encoded>
</item>
</xsl:template>

</xsl:stylesheet>
