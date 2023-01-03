<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/general-strings.xsl"/>
	
<xsl:output method="text" omit-xml-declaration="yes" encoding="UTF-8" />


<xsl:template match="/">
{
    "draw": <xsl:call-template name="force-number"><xsl:with-param name="string" select="/data/params/url-draw" /></xsl:call-template>,
    "query": "<xsl:value-of select="/data/params/current-query-string" />",
    "page": <xsl:call-template name="force-number"><xsl:with-param name="string" select="/data/params/url-page" /><xsl:with-param name="default" select="'1'" /></xsl:call-template>,
    "pages": <xsl:value-of select="/data/documents-dynamic/pagination/@total-pages" />,
    "recordsTotal": <xsl:value-of select="/data/section-count/section[@id = '6']/count/text()" />,
    "recordsFiltered": <xsl:value-of select="/data/documents-dynamic/pagination/@total-entries" />,
    "data": [
        <xsl:apply-templates select="/data/documents-dynamic/entry" />
    ]
}
</xsl:template>

<xsl:template match="documents-dynamic/entry">
    [
        "&lt;strong&gt;&lt;a href=\"/document/<xsl:value-of select="@id" />/\"&gt;<xsl:call-template name="escape-quote"><xsl:with-param name="string" select="name" /></xsl:call-template>&lt;/a&gt; <xsl:apply-templates select="authors" />&lt;/strong&gt;",
        "<xsl:value-of select="year" /><xsl:if test="uncertain = 'Yes'"> c.</xsl:if>",
        "<xsl:value-of select="organisation/item/name" />",
        "<xsl:value-of select="publication/item/name" />"
    ]<xsl:if test="position() != last()">,</xsl:if>
</xsl:template>


<xsl:template name="escape-quote">
    <xsl:param name="string" select="concat(normalize-space(.), '')" />
    <xsl:if test="string-length($string) >0">
        <xsl:value-of select="substring-before(concat($string, '&quot;'), '&quot;')" />

        <xsl:if test="contains($string, '&quot;')">
            <xsl:text>\"</xsl:text>    
            <xsl:call-template name="escape-quote">
                <xsl:with-param name="string" select="substring-after($string, '&quot;')" />
            </xsl:call-template>
        </xsl:if>
    </xsl:if>
</xsl:template>

<xsl:template match="authors">&lt;em&gt;&lt;span class=\"text-muted\"&gt;(<xsl:apply-templates select="item" />)&lt;/span&gt;&lt;/em&gt;</xsl:template>

<xsl:template match="authors/item">
    <xsl:value-of select="name" /><xsl:if test="position() != last()">,</xsl:if>
</xsl:template>

</xsl:stylesheet>
