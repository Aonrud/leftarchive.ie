<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="external-listings">
	<section>
		<h2>External Resources</h2>
		<dl>
			<xsl:apply-templates select="entry" />
		</dl>
	</section>
</xsl:template>
	
<xsl:template match="external-listings/entry">
    <dt><a href="{url}" title="{org-pub/item} at {resource/item}" class="external-link"><xsl:value-of select="name" /><span class="fas fa-external-link-alt"></span></a></dt>
    <dd>
    <p class="text-muted"><xsl:value-of select="resource/item"/></p>
    <xsl:copy-of select="description/*" />
    </dd>
</xsl:template> 

</xsl:stylesheet>
