<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="dc">

<xsl:import href="general-strings.xsl"/>
<xsl:import href="section.xsl"/>

<!--Tracker templates-->
<xsl:template match="latest-changes/activity">
    
    <xsl:variable name="type">
        <xsl:choose>
            <xsl:when test="section/@id = '19'">Person</xsl:when>
            <xsl:when test="section/@id = '24'">International</xsl:when>
            <xsl:when test="section/@id = '46'">Demonstration</xsl:when>
            <xsl:otherwise><xsl:value-of select="substring(section,1,string-length(section)-1)" /></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="title">
        <xsl:choose>
            <xsl:when test="$type = 'Document'"><xsl:value-of select="/data/documents-tracker/entry[@id = current()/@entry-id]/name" /></xsl:when>
            <xsl:when test="$type = 'Organisation'"><xsl:value-of select="/data/organisations-tracker/entry[@id = current()/@entry-id]/name" /></xsl:when>
            <xsl:when test="$type = 'International'"><xsl:value-of select="/data/internationals-tracker/entry[@id = current()/@entry-id]/name" /></xsl:when>
            <xsl:when test="$type = 'Publication'"><xsl:value-of select="/data/publications-tracker/entry[@id = current()/@entry-id]/name" /></xsl:when>
            <xsl:when test="$type = 'Collection'"><xsl:value-of select="/data/collections-tracker/entry[@id = current()/@entry-id]/name" /></xsl:when>
            <xsl:when test="$type = 'Person'"><xsl:value-of select="/data/people-tracker/entry[@id = current()/@entry-id]/name" /></xsl:when>
            <xsl:when test="$type = 'Subject'"><xsl:value-of select="/data/subjects-tracker/entry[@id = current()/@entry-id]/name" /></xsl:when>
            <xsl:when test="$type = 'Demonstration'"><xsl:value-of select="/data/demonstrations-tracker/entry[@id = current()/@entry-id]/name" /></xsl:when>
        </xsl:choose>
    
    </xsl:variable>
    
    <xsl:variable name="status">
        <xsl:choose>
            <xsl:when test="@type = 'created'">New</xsl:when>
            <xsl:otherwise><xsl:call-template name="initial"><xsl:with-param name="string" select="@type" /></xsl:call-template></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="link-id">
        <xsl:choose>
            <xsl:when test="$type = 'Organisation' and /data/organisations-tracker/entry[@id = current()/@entry-id]/minor = 'Yes'"><xsl:value-of select="/data/organisations-tracker/entry[@id = current()/@entry-id]/parent/item/@id" /></xsl:when>
            <xsl:when test="$type = 'International' and /data/internationals-tracker/entry[@id = current()/@entry-id]/minor = 'Yes'"><xsl:value-of select="/data/internationals-tracker/entry[@id = current()/@entry-id]/parent/item/@id" /></xsl:when>
            <xsl:when test="$type = 'Publication' and /data/publications-tracker/entry[@id = current()/@entry-id]/minor = 'Yes'"><xsl:value-of select="/data/publications-tracker/entry[@id = current()/@entry-id]/parent/item/@id" /></xsl:when>
            <xsl:when test="$type = 'Person' and /data/people-tracker/entry[@id = current()/@entry-id]/minor = 'Yes'"><xsl:value-of select="/data/people-tracker/entry[@id = current()/@entry-id]/parent/item/@id" /></xsl:when>           
            <xsl:otherwise><xsl:value-of select="@entry-id" /></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="link"><xsl:call-template name="get-url"><xsl:with-param name="section-id" select="section/@id" /><xsl:with-param name="id" select="$link-id" /></xsl:call-template></xsl:variable>
    
    <li>
        <h5><xsl:value-of select="$status" />: <a href="{$link}" title="{$title}"><xsl:value-of select="$title" /></a></h5>
        <small class="text-muted">
            <xsl:call-template name="section-icon"><xsl:with-param name="section-id" select="section/@id" /></xsl:call-template><xsl:value-of select="$type" /> | <xsl:call-template name="format-date"><xsl:with-param name="date" select="date" /><xsl:with-param name="format" select="'D M Y'"/></xsl:call-template>
        </small>
    </li>
</xsl:template>

</xsl:stylesheet>
