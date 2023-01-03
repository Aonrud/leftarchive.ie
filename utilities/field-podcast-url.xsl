<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="general-strings.xsl" />
    
<xsl:template match="//entry">
    
    <xsl:variable name="string">
        <xsl:call-template name="word-truncate">
            <xsl:with-param name="string" select="name/@handle" />
            <xsl:with-param name="length" select="'50'" />
            <xsl:with-param name="word-separator" select="'-'" />
        </xsl:call-template>
    </xsl:variable>
    
    <url>
        <id><xsl:value-of select="@id" /></id>
        <episode><xsl:value-of select="episode" /></episode>
        <string-full><xsl:value-of select="name/@handle" /></string-full>
        <string-checked><xsl:value-of select="$string" /></string-checked>
    </url>
    
</xsl:template>
    
</xsl:stylesheet>
