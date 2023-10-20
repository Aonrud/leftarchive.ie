<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<xsl:import href="../utilities/general-year-range.xsl"/>

<!--Templates for a table of publications-->
<xsl:template match="entry[../section/@handle = 'publications']" mode="publication-table-row">
	<tr typeof="schema:Periodical">
		<xsl:if test="hidden = 'Yes'">
			<xsl:attribute name="class">
				<xsl:text>active</xsl:text>
			</xsl:attribute>
		</xsl:if>
		<td>
			<span property="schema:name"><xsl:apply-templates select="name" mode="publication-table-row" /></span>
			<xsl:if test="irish">&#160;(<i property="schema:name" lang="ga"><xsl:value-of select="irish" /></i>)</xsl:if>
			<xsl:if test="tagline">
				<xsl:text>: </xsl:text>
				<xsl:value-of select="tagline" />
			</xsl:if>
		</td>
		<td>
			<xsl:attribute name="data-sort">
				<xsl:choose>
					<xsl:when test="year-started != ''">
						<xsl:value-of select="year-started" />
					</xsl:when>
					<xsl:otherwise>null</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:apply-templates select="." mode="dates-list" />
		</td>
		<td>
			<xsl:apply-templates select="." mode="orgs" />
		</td>
	</tr>
</xsl:template>

<xsl:template match="entry[../section/@handle = 'publications'][hidden='No']/name" mode="publication-table-row">
	<a>
		<xsl:attribute name="href">
			<xsl:apply-templates select=".." mode="entry-url" />
		</xsl:attribute>
		<xsl:value-of select="../sort-name" />
	</a>
</xsl:template>

<xsl:template match="entry[../section/@handle = 'publications'][hidden='Yes']/name" mode="publication-table-row">
	<xsl:value-of select="../sort-name" />
</xsl:template>

<xsl:template match="entry[../section/@handle = 'publications'][organisations]" mode="orgs">
	<xsl:apply-templates select="organisations/item" mode="entry-list-linked">
		<xsl:with-param name="rdfa" select="'Yes'" />
		<xsl:with-param name="property" select="'schema:publisher'" />
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="entry[../section/@handle = 'publications'][not(organisations)]" mode="orgs">
	<xsl:text>…</xsl:text>
</xsl:template>

<xsl:template match="entry[../section/@handle = 'publications']" mode="dates-list">
	<xsl:param name="schema" select="'periodical'" />
	
	<xsl:call-template name="year-range">
        <xsl:with-param name="first" select="year-started" />
        <xsl:with-param name="last" select="year-ended" />
        <xsl:with-param name="first-est" select="start-est" />
        <xsl:with-param name="last-est" select="end-est" />
        <xsl:with-param name="schema" select="$schema" />
    </xsl:call-template>
    
    <xsl:if test="irregular = 'Yes'"><i> [Irregular]</i></xsl:if>
</xsl:template>

<!-- List the active dates including gaps, e.g. "1930-1940, 1946, 1950-1960" -->
<xsl:template match="entry[../section/@handle = 'publications'][publication-gaps]" mode="dates-list">
	<xsl:param name="schema" select="'periodical'" />
	
	<xsl:call-template name="year-range">
        <xsl:with-param name="first" select="year-started" />
        <xsl:with-param name="last" select="publication-gaps/key[1]/@handle" />
        <xsl:with-param name="first-est" select="start-est" />
        <xsl:with-param name="schema" select="'periodical'" />
        <xsl:with-param name="schema-apply" select="'first'" />
    </xsl:call-template>
	
	<xsl:apply-templates select="publication-gaps/key" mode="dates-list" />
	
	<xsl:if test="irregular = 'Yes'"><i> [Irregular]</i></xsl:if>
</xsl:template>

<!--Gives an active range from the publication gaps, i.e. from the end of the gap to the start of the next one, or the publication end-->
<xsl:template match="publication-gaps/key" mode="dates-list">
	<xsl:param name="schema" select="'periodical'" />

	<xsl:variable name="last">
		<xsl:choose>
			<xsl:when test="position() != last()"><xsl:value-of select="following-sibling::key/@handle" /></xsl:when>
			<xsl:otherwise><xsl:value-of select="../../year-ended" /></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:text>, </xsl:text>
	<xsl:call-template name="year-range">
        <xsl:with-param name="first" select="value" />
        <xsl:with-param name="last" select="$last" />
        <xsl:with-param name="schema" select="'periodical'" />
        <xsl:with-param name="schema-apply"><xsl:if test="position() = last()">last</xsl:if></xsl:with-param>
        <xsl:with-param name="last-est"><xsl:if test="position() = last()"><xsl:value-of select="../../end-est" /></xsl:if></xsl:with-param>
    </xsl:call-template>
	
</xsl:template>

<!--#Provides the dates of publication, including if they are estimated, publication gaps and whether it's irregular.
-->
<xsl:template match="entry[../section/@handle = 'publications']" mode="dates">
	<xsl:param name="schema" select="'periodical'" />
	
    <xsl:call-template name="year-range">
        <xsl:with-param name="first" select="year-started" />
        <xsl:with-param name="last" select="year-ended" />
        <xsl:with-param name="first-est" select="start-est" />
        <xsl:with-param name="last-est" select="end-est" />
        <xsl:with-param name="schema" select="$schema" />
    </xsl:call-template>
    
    <xsl:if test="irregular = 'Yes'"><br /><i>[Irregular]</i></xsl:if>
    <xsl:apply-templates select="publication-gaps" />
</xsl:template>

<xsl:template match="publication-gaps">
	<br />
	<i>
		<xsl:text> [Excluding: </xsl:text>
		<xsl:apply-templates select="key" />
		<xsl:text>]</xsl:text>
	</i>
</xsl:template>

<xsl:template match="publication-gaps/key">
	<xsl:if test="position() != last()">, </xsl:if>
	<xsl:call-template name="year-range">
		<xsl:with-param name="first" select="@handle" />
		<xsl:with-param name="last" select="value" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
