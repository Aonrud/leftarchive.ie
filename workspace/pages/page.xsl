<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="dc">

<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/meta-redirect.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="/data">
	<p>&#160;</p>
</xsl:template>

<xsl:template name="head-insert">
	<xsl:call-template name="redirect">
		<xsl:with-param name="url" select="'/'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
