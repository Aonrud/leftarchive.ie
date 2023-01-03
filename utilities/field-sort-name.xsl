<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="general-strings.xsl" />

<!--Returns the name parsed for alphabetical ordering with article moved the the end-->
<xsl:template match="//entry">
    <!--Bracketed qualifiers after the name aren't part of the name-->
    <xsl:variable name="suffix">
        <xsl:value-of select="substring-before(substring-after(name, '['),']')" />
    </xsl:variable>
    
    <!--Remove bracketed part from core name-->
    <xsl:variable name="core">
        <xsl:choose>
            <xsl:when test="contains(name,' [')"><xsl:value-of select="substring-before(name,' [')" /></xsl:when>
            <xsl:otherwise><xsl:value-of select="name" /></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="root">
        <xsl:choose>
            <xsl:when test="starts-with($core, 'The ')"><xsl:value-of select="substring-after($core, 'The ')" /></xsl:when>
            <xsl:when test="starts-with($core, 'An ')"><xsl:value-of select="substring-after($core, 'An ')" /></xsl:when>
            <xsl:when test="starts-with($core, 'Na ')"><xsl:value-of select="substring-after($core, 'Na ')" /></xsl:when>
            <xsl:otherwise><xsl:value-of select="$core" /></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="article">
        <xsl:value-of select="substring-before($core, $root)" />
    </xsl:variable>
    
    <value>
        <xsl:value-of select="$root" />
        <xsl:if test="$article != ''">, </xsl:if>
        <xsl:value-of select="$article" />
        <xsl:if test="$suffix != ''"> [<xsl:value-of select="$suffix" />]</xsl:if>
        
    </value>
</xsl:template>
    
</xsl:stylesheet>
