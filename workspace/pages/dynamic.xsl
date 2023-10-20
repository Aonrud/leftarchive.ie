<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" encoding="UTF-8" indent="yes" />

<xsl:template match="/">
	<results>
		<xsl:apply-templates select="/data/organisations-list/entry" />
		<xsl:apply-templates select="/data/subjects-list/entry" />
		<xsl:apply-templates select="/data/internationals-list/entry" />
		<xsl:apply-templates select="/data/publications-list/entry" />
	</results>
</xsl:template>

<!--Return nothing for subjects that are linked to organisations or people - these should be represented by those sections instead-->
<xsl:template match="entry[group/item = 'Organisation']|entry[group/item = 'People']">
	<xsl:text></xsl:text>
</xsl:template>

<xsl:template match="entry">
	<entry>
		<id><xsl:value-of select="@id" /></id>
		<name><xsl:value-of select="name" /></name>
		<type><xsl:value-of select="../section" /></type>
	</entry>
</xsl:template>

</xsl:stylesheet>
