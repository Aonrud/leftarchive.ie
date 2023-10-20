<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="general-strings.xsl"/>

<xsl:template match="entry">
	<sort-name>
		<xsl:variable name="last">
			<xsl:call-template name="substring-after-last">
				<xsl:with-param name="string" select="name" />
				<xsl:with-param name="delimiter" select="' '" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="$last" />
		<xsl:if test="$last != name">
			<xsl:text>, </xsl:text><xsl:value-of select="substring-before(name,$last)" />
		</xsl:if>
	</sort-name>
</xsl:template>

</xsl:stylesheet>
 
