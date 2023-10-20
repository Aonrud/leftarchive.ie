<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<xsl:template name="ordinals">
	<xsl:param name="no" />
	
	<xsl:variable name="length" select="string-length($no)" />
	
	<xsl:variable name="last" select="substring($no,$length)" />
	
	<xsl:variable name="second-last">
		<xsl:choose>
			<xsl:when test="$length = 1">0</xsl:when>
			<xsl:otherwise><xsl:value-of select="substring($no,$length-1)" /></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="suffix">
		<xsl:choose>
			<xsl:when test="$last = 1 and $second-last != 1">st</xsl:when>
			<xsl:when test="$last = 2 and $second-last != 1">nd</xsl:when>
			<xsl:when test="$last = 3 and $second-last != 1">rd</xsl:when>
			<xsl:otherwise>th</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:value-of select="$no" /><xsl:value-of select="$suffix" />
</xsl:template>

</xsl:stylesheet>
