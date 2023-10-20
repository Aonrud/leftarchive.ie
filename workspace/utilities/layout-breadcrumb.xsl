<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<xsl:template name="breadcrumb">
    <ol class="breadcrumb" typeof="schema:BreadcrumbList">
        <xsl:call-template name="breadcrumb-list-item">
            <xsl:with-param name="name" select="'Home'" />
            <xsl:with-param name="link" select="'/'" />
            <xsl:with-param name="position" select="'1'" />
        </xsl:call-template>
        
        <xsl:call-template name="breadcrumb-contents" />
    </ol>
</xsl:template>

<!--Over-ride at page level. Empty template left here to prevent errors if not found-->
<xsl:template name="breadcrumb-contents">
&#160;
</xsl:template>

<xsl:template name="breadcrumb-list-item">
    <xsl:param name="name" />
    <xsl:param name="link" />
    <xsl:param name="position" />
    <xsl:param name="active" select="'No'" />
    <xsl:param name="schema-type" select="'WebPage'" />
    
    <li property="schema:itemListElement" typeof="schema:ListItem">
        <xsl:if test="$active = 'Yes'">
            <xsl:attribute name="class">active</xsl:attribute>
        </xsl:if>
        <a href="{$link}" property="schema:item" typeof="schema:{$schema-type}">
            <span property="schema:name"><xsl:value-of select="$name" /></span>
        </a>
        <meta property="schema:position" content="{$position}" />
    </li>
</xsl:template>

</xsl:stylesheet>
