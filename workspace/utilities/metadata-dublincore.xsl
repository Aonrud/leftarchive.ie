<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="metadata-dublincore">

<!--Document-->
<xsl:if test="$current-page-id = 1 or $current-page-id = 39">
	<meta property="dc:type" content="document" />
	<meta property="dc:title" content="{/data/document-single/entry/name}" />
	
	<meta property="dc:description">
		<xsl:attribute name="content">PDF of <xsl:value-of select="/data/document-single/entry/name" /><xsl:if test="/data/document-single/entry/authors/item"> by <xsl:for-each select="/data/document-single/entry/authors/item/name"><xsl:choose><xsl:when test="position() = 1"></xsl:when><xsl:when test="position() = last()"> and </xsl:when><xsl:otherwise>, </xsl:otherwise></xsl:choose><xsl:value-of select="." /></xsl:for-each></xsl:if><xsl:if test="/data/document-single/entry/organisation/item">, published by <xsl:value-of select="/data/document-single/entry/organisation/item/name" /></xsl:if>.</xsl:attribute>
	</meta>
	
	<xsl:choose>
		<xsl:when test="/data/document-single/entry/authors/item">
			<xsl:for-each select="/data/document-single/entry/authors/item">
				<meta property="dc:creator" content="{name}"  />
			</xsl:for-each>
		</xsl:when>
		<xsl:when test="not(/data/document-single/entry/authors/item) and /data/document-single/entry/organisation/item">
			<xsl:for-each select="/data/document-single/entry/organisation/item">
				<meta property="dc:creator" content="{name}"  />
			</xsl:for-each>
		</xsl:when>
		<xsl:when test="not(/data/document-single/entry/authors/item) and not(/data/document-single/entry/organisation/item) and /data/document-single/entry/publication/item">
			<meta property="dc:creator" content="{/data/document-single/entry/publication/item}" />
		</xsl:when>
	</xsl:choose>
	
	<xsl:if test="/data/document-single/entry/contributors/item">
		<xsl:for-each select="/data/document-single/entry/contributors/item">
			<meta property="dc:contributor" content="{name}"  />
		</xsl:for-each>		
	</xsl:if>
	
	<xsl:if test="/data/document-single/entry/organisation/item">
		<meta property="dc:publisher" content="{/data/document-single/entry/organisation/item/name}" />
	</xsl:if>
	
	<meta property="dc:issued" content="{/data/document-single/entry/year}" />
	<meta property="dc:identifier" content="https://www.leftarchive.ie/document/{/data/document-single/entry/@id}/" />
	<meta property="dc:format" content="{/data/document-single/entry/document/@type}" />
	<meta property="dc:rights" content="The Irish Left Archive is provided as a non-commercial historical resource, open to all, and has reproduced this document as an accessible digital reference. Copyright remains with its original authors. If used on other sites, we would appreciate a link back and reference to the Irish Left Archive, in addition to the original creators. For re-publication, commercial, or other uses, please contact the original owners." />
</xsl:if>

</xsl:template>


</xsl:stylesheet>
