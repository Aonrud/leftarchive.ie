<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="general-strings.xsl" />
<!--#Also depends on entry.xsl (imported in master).-->

<!--Key is duplicated for each so that filtered lists work-->
<xsl:key name="key-all" match="organisations-list/entry|people-list/entry|publications-list/entry|internationals-list/entry|subjects-list-index/entry" use="substring(sort-name/@handle, 1, 1)" />

<xsl:key name="key-org" match="organisations-list/entry" use="substring(sort-name/@handle, 1, 1)" />
<xsl:key name="key-people" match="people-list/entry" use="substring(sort-name/@handle, 1, 1)" />
<xsl:key name="key-pub" match="publications-list/entry" use="substring(sort-name/@handle, 1, 1)" />
<xsl:key name="key-int" match="internationals-list/entry" use="substring(sort-name/@handle, 1, 1)" />

<xsl:template match="entry" mode="index">
    <xsl:param name="key" />
    
    <xsl:variable name="initial" select="substring(sort-name/@handle, 1, 1)" />
    
    <xsl:variable name="items" select="key($key, $initial)" />
    <xsl:if test="generate-id() = generate-id($items[1])">
        <h2><xsl:call-template name="uppercase"><xsl:with-param name="string" select="$initial" /></xsl:call-template></h2>
        <ul class="list-unstyled list-index">
        <xsl:apply-templates select="$items">
            <xsl:sort select="sort-name/@handle" />
        </xsl:apply-templates>
        </ul>
    </xsl:if>
</xsl:template>

<xsl:template match="organisations-list/entry|people-list/entry|publications-list/entry|internationals-list/entry|subjects-list-index/entry">
    <li>
        <xsl:if test="/data/params/type = ''">
			<xsl:call-template name="section-icon">
				<xsl:with-param name="section-id" select="../section/@id" />
			</xsl:call-template>
        </xsl:if>
        <a>
			<xsl:attribute name="href">
				<xsl:apply-templates select="." mode="entry-url" />
			</xsl:attribute>
			
			<xsl:attribute name="title">
				<xsl:call-template name="initial">
					<xsl:with-param name="string">
						<xsl:call-template name="section-slug">
							<xsl:with-param name="section">
								<xsl:value-of select="../section/@handle" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:text> - </xsl:text>
				<xsl:value-of select="name" />
			</xsl:attribute>
			
			<xsl:attribute name="class">
				<xsl:if test="minor = 'Yes'">minor-entry </xsl:if>
			</xsl:attribute>
			
			<xsl:value-of select="sort-name" /> <xsl:apply-templates select="acronym" />
		</a>
		<xsl:apply-templates select="place[item != 'Ireland']" />
    </li>
</xsl:template>

<xsl:template match="acronym">
	(<xsl:value-of select="." />)
</xsl:template>

<xsl:template match="place">
	&#160;<small class="text-muted"><xsl:value-of select="item" /></small>
</xsl:template>

</xsl:stylesheet>
