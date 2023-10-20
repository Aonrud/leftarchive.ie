<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="str exsl"
	exclude-result-prefixes="str exsl">

<xsl:template name="metadata-coins">

	<xsl:if test="$current-page-id = 1 or $current-page-id = 39">
		<xsl:variable name="identifier"><xsl:value-of select="/data/params/root" />/document/<xsl:value-of select="/data/document-single/entry/@id" />/</xsl:variable>
		
		<xsl:variable name="description">PDF of <xsl:value-of select="/data/document-single/entry/name" /><xsl:if test="/data/document-single/entry/authors/item"> by <xsl:for-each select="/data/document-single/entry/authors/item"><xsl:choose><xsl:when test="position() = 1"></xsl:when><xsl:when test="position() = last()"> and </xsl:when><xsl:otherwise>, </xsl:otherwise></xsl:choose><xsl:value-of select="name" /></xsl:for-each></xsl:if><xsl:if test="/data/document-single/entry/organisation/item">, published by <xsl:value-of select="/data/document-single/entry/organisation/item/name" /></xsl:if>.</xsl:variable>

		<xsl:variable name="coins">ctx_ver=Z39.88-2004&amp;rfr_id=<xsl:value-of select="str:encode-uri('info:sid/leftarchive.ie',true())" />&amp;rft_val_fmt=<xsl:value-of select="str:encode-uri('info:ofi/fmt:kev:mtx:dc',true())" />&amp;rft.type=document&amp;rft.title=<xsl:value-of select="str:encode-uri(/data/document-single/entry/name,true())" />&amp;rft.publisher=<xsl:value-of select="str:encode-uri(/data/document-single/entry/organisation/item/name,true())" />&amp;rft.description=<xsl:value-of select="str:encode-uri($description,true())" />&amp;rft.identifier=<xsl:value-of select="str:encode-uri($identifier,true())" />&amp;rft.date=<xsl:value-of select="/data/document-single/entry/year" /><xsl:choose><xsl:when test="/data/document-single/entry/authors/item"><xsl:for-each select="/data/document-single/entry/authors/item">&amp;rft.au=<xsl:value-of select="str:encode-uri(name,true())" /></xsl:for-each></xsl:when><xsl:when test="not(/data/document-single/entry/authors/item) and /data/document-single/entry/organisation/item"><xsl:for-each select="/data/document-single/entry/organisation/item">&amp;rft.aucorp=<xsl:value-of select="str:encode-uri(name,true())" /></xsl:for-each></xsl:when><xsl:when test="not(/data/document-single/entry/authors/item) and not(/data/document-single/entry/organisation/item) and /data/document-single/entry/publication/item">&amp;rft.aucorp=<xsl:value-of select="str:encode-uri(/data/document-single/entry/publication/item/name,true())" /></xsl:when></xsl:choose>
		</xsl:variable>

		<span class="Z3988" title="{$coins}"></span>
	</xsl:if>

</xsl:template>

</xsl:stylesheet>
