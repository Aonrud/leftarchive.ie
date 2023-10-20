<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/general-strings.xsl"/>

<xsl:template match="key[@handle='wikipedia']" mode="wiki-insert">
    <xsl:variable name="title">
        <xsl:call-template name="substring-after-last">
            <xsl:with-param name="string" select="value" />
            <xsl:with-param name="delimiter" select="'/'" />
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="lang">
        <xsl:value-of select="substring-before(substring-after(value, '//'), '.')" />
    </xsl:variable>
    
    <!--The Wikipedia JS module inserts the wiki content into this div based on the provided title-->
    <div id="wiki" data-title="{$title}" lang="{$lang}"></div>
</xsl:template>

</xsl:stylesheet>
