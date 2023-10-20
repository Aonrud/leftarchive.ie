<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" omit-xml-declaration="yes" encoding="UTF-8" />

<xsl:template match="/">
    <xsl:choose>
        <xsl:when test="/data/events/subject-suggestion">
            <xsl:apply-templates select="/data/events/subject-suggestion" />
        </xsl:when>
        <xsl:otherwise>[ "No subject suggestions submitted."]</xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="subject-suggestion">
{
    "result": "<xsl:value-of select="@result" />",
    "message": "<xsl:value-of select="message" />",
    "suggestion": "<xsl:value-of select="post-values/suggestion" />"
}
</xsl:template>

</xsl:stylesheet>
