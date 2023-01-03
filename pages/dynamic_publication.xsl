<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/general-html.xsl"/>
<xsl:import href="../utilities/general-year-range.xsl"/>
<xsl:import href="../utilities/entry.xsl"/>

<xsl:output method="xml" encoding="UTF-8" indent="yes" />

<xsl:template match="/">
	<xsl:apply-templates select="/data/publication-single-dynamic/entry" />
</xsl:template>

<xsl:template match="publication-single-dynamic/entry">
	<entry>
		<published>
			<xsl:choose>
				<xsl:when test="hidden = 'Yes'">false</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</published>
		<name><xsl:value-of select="name" /></name>
		<link>/publication/<xsl:value-of select="@id" />/</link>
		<xsl:apply-templates select="masthead" />
		<listInfo>
			<xsl:if test="organisations/item">
				<item>
					<name>publisher</name>
					<value><xsl:apply-templates select="organisations/item" mode="entry-list" /></value>
				</item>
			</xsl:if>
			<item>
				<name>years</name>
				<value>
					<xsl:call-template name="year-range">
						<xsl:with-param name="first" select="year-started" />
						<xsl:with-param name="last" select="year-ended" />
					</xsl:call-template>
				</value>
			</item>
		</listInfo>
		<description>
			<xsl:apply-templates select="about/*" mode="html"/>
		</description>
		<xsl:apply-templates select="/data/publications-minor[entry]" />
	</entry>
</xsl:template>

<xsl:template match="masthead">
	<image>/image/1/400/0<xsl:value-of select="@path" />/<xsl:value-of select="filename" /></image>
</xsl:template>

<xsl:template match="publications-minor">
	<minors>
		<xsl:apply-templates select="entry">
			<xsl:sort select="year-started" />
		</xsl:apply-templates>
	</minors>
</xsl:template>

<xsl:template match="publications-minor/entry">
	<entry>
		<name><xsl:value-of select="name" /></name>
		<years>
			<xsl:call-template name="year-range">
				<xsl:with-param name="first" select="year-started" />
				<xsl:with-param name="last" select="year-ended" />
				<xsl:with-param name="unknown" select="'No'" />
				<xsl:with-param name="brackets" select="'Yes'" />
			</xsl:call-template>
		</years>
		<type><xsl:value-of select="minor-type/item" /></type>
	</entry>
</xsl:template>

</xsl:stylesheet>
