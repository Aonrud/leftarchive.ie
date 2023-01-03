<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/general-html.xsl"/>
<xsl:import href="../utilities/general-year-range.xsl"/>

<xsl:output method="xml" encoding="UTF-8" indent="yes" />

<xsl:template match="/">
	<xsl:apply-templates select="/data/organisation-single/entry" />
</xsl:template>

<xsl:template match="organisation-single/entry">
	<entry>
		<name><xsl:value-of select="name" /></name>
		<link>/organisation/<xsl:value-of select="@id" />/</link>
		<xsl:apply-templates select="logo" />
		<listInfo>
			<item>
				<name>years</name>
				<value>
					<xsl:call-template name="year-range">
						<xsl:with-param name="first" select="year-founded" />
						<xsl:with-param name="last" select="year-dissolved" />
					</xsl:call-template>
				</value>
			</item>
		</listInfo>
		<description>
			<xsl:apply-templates select="about/*" mode="html"/>
		</description>
		<xsl:apply-templates select="/data/organisations-minor[entry/minor-type/item = 'Other Name' or entry/minor-type/item = 'Predecessor']" />
	</entry>
</xsl:template>

<xsl:template match="logo">
	<image>/image/1/400/0<xsl:value-of select="@path" />/<xsl:value-of select="filename" /></image>
</xsl:template>

<xsl:template match="organisations-minor">
	<minors>
		<xsl:apply-templates select="entry[minor-type/item = 'Other Name' or minor-type/item = 'Predecessor']">
			<xsl:sort select="year-founded" />
		</xsl:apply-templates>
	</minors>
</xsl:template>

<xsl:template match="organisations-minor/entry">
	<entry>
		<name><xsl:value-of select="name" /></name>
		<years>
			<xsl:call-template name="year-range">
				<xsl:with-param name="first" select="year-founded" />
				<xsl:with-param name="last" select="year-dissolved" />
				<xsl:with-param name="unknown" select="'No'" />
				<xsl:with-param name="brackets" select="'Yes'" />
			</xsl:call-template>
		</years>
		<type><xsl:value-of select="minor-type/item" /></type>
	</entry>
</xsl:template>

</xsl:stylesheet>
