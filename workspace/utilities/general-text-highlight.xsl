<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:str="http://exslt.org/strings"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="str exsl"
	exclude-result-prefixes="str exsl">
	
<xsl:import href="general-strings.xsl"/>

<xsl:template name="text-highlight">
    <xsl:param name="text" />
    <xsl:param name="search" />
    
    <xsl:param name="words" select="str:tokenize($search)" />
    
    <xsl:param name="index" select="1" />
    <xsl:param name="total" select="count($words)" />
    
    <xsl:variable name="current">
        <xsl:call-template name="text-highlight-word">
            <xsl:with-param name="text" select="$text" />
            <xsl:with-param name="search" select="$words[position() = $index]" />
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:choose>
        <xsl:when test="$index = $total">
            <xsl:value-of select="$current" disable-output-escaping="yes" />
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="text-highlight">
                <xsl:with-param name="text" select="$current" />
                <xsl:with-param name="search" select="$search" />
                <xsl:with-param name="index" select="$index + 1" />
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>    
</xsl:template>

<xsl:template name="text-highlight-word">
    <xsl:param name="text" />
    <xsl:param name="search" />
    
    <xsl:variable name="text-lc">
        <xsl:call-template name="lowercase">
            <xsl:with-param name="string" select="$text" />
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="search-lc">
        <xsl:call-template name="lowercase">
            <xsl:with-param name="string" select="translate($search,'&quot;','')" />
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:choose>
        <xsl:when test="contains($text-lc,$search-lc)">
            <xsl:value-of select="substring($text,1,string-length(substring-before($text-lc,$search-lc)))" />
            <xsl:text disable-output-escaping="yes">&lt;strong&gt;</xsl:text>
                <!--This way, we preserve the case of the original instance of the term-->
                <xsl:value-of select="substring($text,string-length(substring-before($text-lc,$search-lc))+1,string-length($search))" />
            <xsl:text disable-output-escaping="yes">&lt;/strong&gt;</xsl:text>
            <xsl:call-template name="text-highlight-word">
                <xsl:with-param name="text" select="substring($text,string-length(substring-before($text-lc,$search-lc))+string-length($search)+1)" />
                <xsl:with-param name="search" select="$search" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$text" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>
