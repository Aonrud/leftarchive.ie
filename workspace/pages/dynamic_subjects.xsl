<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" omit-xml-declaration="yes" encoding="UTF-8" />

<xsl:template match="/">
[
	<xsl:apply-templates select="data/subjects-list/entry" />
]
</xsl:template>

<xsl:template match="subjects-list/entry">
    "<xsl:value-of select="group/item" /> - <xsl:value-of select="name" />"<xsl:if test="position() != last()">,</xsl:if>
</xsl:template>

</xsl:stylesheet>
