<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<!--Intro section-->
<xsl:template match="articles-intro|articles-intro-subject">
	<h2>Articles</h2>
	<xsl:apply-templates select="entry" />
</xsl:template>

<!--Standard intro entry -->
<xsl:template match="articles-intro/entry|articles-intro-subject/entry">
	<article>
		<h3><a href="/article/{@id}/"><xsl:value-of select="name" /></a></h3>
		<xsl:if test="from/item"><p class="text-muted"> From <xsl:value-of select="from/item" /></p></xsl:if>
		<p><xsl:value-of select="content/p[position() = 1]" /></p>
		<p><a href="/article/{@id}/" title="{name}" class="btn btn-success">Read full article <span class="fas fa-arrow-right"></span></a></p>
	</article>
</xsl:template>

<!--Row in table-->
<xsl:template match="articles-intro" mode="entry-table">
	<tr>
		<th scope="row"><xsl:call-template name="section-icon"><xsl:with-param name="section-id" select="'15'" /></xsl:call-template> Article<xsl:if test="count(entry) &gt; 1">s</xsl:if>:</th>
		<td>
			<xsl:apply-templates select="entry" mode="entry-list-linked">
				<xsl:with-param name="separator" select="'break'" />
			</xsl:apply-templates>
		</td>
	</tr>
</xsl:template>

</xsl:stylesheet>
