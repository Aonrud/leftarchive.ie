<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="general-strings.xsl" />
    
<xsl:template match="//entry">
    
    <xsl:variable name="string">
        <xsl:call-template name="word-truncate">
            <xsl:with-param name="string" select="name/@handle" />
            <xsl:with-param name="length" select="'60'" />
            <xsl:with-param name="word-separator" select="'-'" />
        </xsl:call-template>
        <!--
        <xsl:value-of select="substring(name/@handle, 1, 50 + string-length(substring-before(substring(name/@handle, 51),'-')))" />
        -->
    </xsl:variable>
    
    <url>
        <id><xsl:value-of select="@id" /></id>
        <string-full><xsl:value-of select="name/@handle" /></string-full>
        <string-checked><xsl:value-of select="$string" /></string-checked>
    </url>
    
</xsl:template>
    
</xsl:stylesheet>
