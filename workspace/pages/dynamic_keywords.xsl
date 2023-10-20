<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" omit-xml-declaration="yes" encoding="UTF-8" />

<!--
	Easy Autocomplete needs an object with named items.
	Opensearch specifies by order in array, so array is sent in that mode.
	(Ref: https://developer.mozilla.org/en-US/docs/Archive/Add-ons/Supporting_search_suggestions_in_search_plugins)
-->
<xsl:template match="/">
	<xsl:apply-templates select="data" />
</xsl:template>

<xsl:template match="data[params/url-mode = 'opensearch']">
	<xsl:text>["</xsl:text><xsl:value-of select="/data/params/url-keywords" /><xsl:text>",</xsl:text>
	<xsl:call-template name="keywords-array" />
	<xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="data">
	<xsl:text>{ "results": </xsl:text>
	<xsl:call-template name="keywords-array" />
	<xsl:text> , "input": "</xsl:text><xsl:value-of select="/data/params/url-keywords" /><xsl:text>" }</xsl:text>
</xsl:template>

<xsl:template name="keywords-array">

	<xsl:variable name="auto-count">
		<xsl:choose>
			<xsl:when test="count(//entry) &gt; 10">10</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="count(//entry)" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="difference">
		<xsl:choose>
			<xsl:when test="$auto-count &lt; 10">
				<xsl:value-of select="10 - $auto-count" />
			</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:text>[</xsl:text>
	<xsl:apply-templates select="//entry" mode="autocomplete">
		<xsl:with-param name="auto-count" select="$auto-count" />
		<xsl:with-param name="difference" select="$difference" />
	</xsl:apply-templates>

	<xsl:if test="$difference &gt; 0">
		<xsl:apply-templates select="/data/search-suggestions/word[position() &lt;= $difference]">
			<xsl:with-param name="auto-count" select="$auto-count" />
			<xsl:with-param name="difference" select="$difference" />
		</xsl:apply-templates>
	</xsl:if>
	<xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="entry" mode="autocomplete">
    <xsl:param name="auto-count" />
    <xsl:param name="difference" />
    
    <xsl:if test="position() &lt;= $auto-count">
        <xsl:apply-templates select=".">
            <xsl:with-param name="auto-count" select="$auto-count" />
			<xsl:with-param name="difference" select="$difference" />
			<xsl:with-param name="pos" select="position()" />
        </xsl:apply-templates>
    </xsl:if>
</xsl:template>

<xsl:template match="entry">
    <xsl:param name="auto-count" />
    <xsl:param name="difference" />
    <xsl:param name="pos" />
    
    <xsl:variable name="result">
        <xsl:choose>
        <xsl:when test="preceding-sibling::section/@handle = 'subjects'">
            <xsl:value-of select="heading" />
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="name" />
        </xsl:otherwise>
    </xsl:choose>
    </xsl:variable>
    
    "<xsl:value-of select="$result" />"<xsl:if test="$pos != $auto-count or ($difference &gt; 0 and count(/data/search-suggestions/word) &gt; 0)">,</xsl:if>
</xsl:template>

<xsl:template match="/data/search-suggestions/word">
    <xsl:param name="auto-count">10</xsl:param>
    <xsl:param name="difference">0</xsl:param>
    "<xsl:value-of select="." />"<xsl:if test="position() != $difference and position() != last()">,</xsl:if>
</xsl:template>


</xsl:stylesheet>
