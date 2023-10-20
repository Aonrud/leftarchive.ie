<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="comments-recent/entry">
	<li>
		<a>
			<xsl:attribute name="href">
				<xsl:apply-templates select="associated-page/item" mode="entry-url" />
				<xsl:text>#comment-</xsl:text>
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:value-of select="title" />
		</a>
		<br />
		<small class="text-muted"><xsl:value-of select="name" /> on "<xsl:value-of select="associated-page/item" />" | <xsl:call-template name="format-date"><xsl:with-param name="date" select="date"/><xsl:with-param name="format" select="'D M Y, T'"/></xsl:call-template></small>
	</li>
</xsl:template>

</xsl:stylesheet>
