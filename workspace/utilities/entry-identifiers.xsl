<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:str="http://exslt.org/strings"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="str exsl"
	exclude-result-prefixes="str exsl">

<xsl:import href="general-strings.xsl" />

<xsl:template match="key">
    <xsl:param name="schema-match" />
    
    <xsl:variable name="tooltip">
        <xsl:choose>
            <xsl:when test="@name = 'VIAF'">Virtual International Authority File</xsl:when>
            <xsl:when test="@name = 'ISNI'">International Standard Name Identifier</xsl:when>
            <xsl:when test="@name = 'ISSN'">International Standard Serial Number</xsl:when>
        </xsl:choose>
    </xsl:variable>
    
    <tr>
        <th scope="row">
            <xsl:value-of select="@name" />
            <xsl:if test="$tooltip != ''">
                <a href="#" class="tooltip-icon" data-toggle="tooltip" title="{$tooltip}">
                <sup>
                    <span class="sr-only">Info</span>
                    <i class="fa-solid fa-fw fa-question"></i>
                </sup>
                </a>
            </xsl:if>
        </th>
        <td>
            <xsl:apply-templates select="value"><xsl:with-param name="schema-match" select="$schema-match" /></xsl:apply-templates>
        </td>
    </tr>
</xsl:template>

<xsl:template match="key/value">
    <xsl:value-of select="." />
</xsl:template>

<xsl:template match="links/key/value">
    <xsl:param name="schema-match" />

    <a href="{.}" class="external" about="{$schema-match}" property="schema:sameAs"><xsl:value-of select="substring-before(substring-after(./text(),'//'),'/')" />&#160;<span class="fas fa-external-link-alt"></span></a>
</xsl:template>

<xsl:template match="key[@name = 'VIAF']/value">
    <xsl:param name="schema-match" />

    <a href="https://viaf.org/viaf/{.}/" class="external" about="{$schema-match}" property="schema:sameAs"><xsl:value-of select="." />&#160;<span class="fas fa-external-link-alt"></span></a>
</xsl:template>

<xsl:template match="key[@name = 'ISNI']/value">
    <xsl:param name="schema-match" />

    <a href="http://www.isni.org/isni/{translate(./text(),' ','')}" class="external" about="{$schema-match}" property="schema:sameAs"><xsl:value-of select="." />&#160;<span class="fas fa-external-link-alt"></span></a>
</xsl:template>

<xsl:template match="key[@name = 'ISSN']/value">
    <xsl:param name="schema-match" />

    <a href="https://www.worldcat.org/ISSN/{.}/" class="external" about="{$schema-match}" property="schema:sameAs"><xsl:value-of select="." />&#160;<span class="fas fa-external-link-alt"></span></a>
</xsl:template>

<xsl:template match="key[@name = 'Wikipedia']/value">
    <xsl:param name="schema-match" />

    <xsl:variable name="slug">
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text">
                <xsl:call-template name="substring-after-last">
                    <xsl:with-param name="string" select="." />
                    <xsl:with-param name="delimiter" select="'/'" />
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="replace" select="'_'" />
            <xsl:with-param name="by" select="' '" />
        </xsl:call-template>
    </xsl:variable>
    
    <a href="{.}" class="external" about="{$schema-match}" property="schema:sameAs"><xsl:value-of select="str:decode-uri($slug)" />&#160;<span class="fa fas fa-external-link-alt"></span></a>
</xsl:template>

</xsl:stylesheet>
