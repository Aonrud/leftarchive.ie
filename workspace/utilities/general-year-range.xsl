<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="year-range">
	<xsl:param name="first" />
	<xsl:param name="last" />
	<xsl:param name="first-est" />
	<xsl:param name="last-est" />
	<xsl:param name="schema" />
	
	<!--Allows for applying the schema to only one of the first or last years.
		This is needed for ranges with gaps, where two ranges are used - e.g. 1965-1970, 1972-1980.
		Values can be 'first' or 'last'. 'Both' is assumed if not specified. 'None' would be represented by leaving the $schema param empty.
	-->
	<xsl:param name="schema-apply" />
	<xsl:param name="unknown" select="'Yes'" />
	<xsl:param name="brackets" select="'No'" />
	
	<xsl:choose>
		<xsl:when test="$first != '' or $last != ''">
			<xsl:if test="$brackets = 'Yes'">(</xsl:if>
			<xsl:choose>
				<xsl:when test="$first != ''">
					<span>
						<xsl:if test="$schema != '' and $schema-apply != 'last'">
							<xsl:attribute name="property">
								<xsl:choose>
									<xsl:when test="$schema = 'organisation'">schema:foundingDate</xsl:when>
									<xsl:when test="$schema = 'periodical'">schema:startDate</xsl:when>
								</xsl:choose>
							</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="$first" /><xsl:if test="$first-est = 'Yes' or ($first = $last and $last-est = 'Yes')"> c.</xsl:if>
					</span>
				</xsl:when>
				<xsl:otherwise>?</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="not($first = $last)"><xsl:text>–</xsl:text></xsl:if>
			<span>
				<xsl:if test="$schema != '' and $schema-apply != 'first'">
					<xsl:attribute name="property">
						<xsl:choose>
							<xsl:when test="$schema = 'organisation'">schema:dissolutionDate</xsl:when>
							<xsl:when test="$schema = 'periodical'">schema:endDate</xsl:when>
						</xsl:choose>
					</xsl:attribute>
				</xsl:if>
				<!--If first and last year are the same, don't show the last, but do include it hidden for the metadata-->
				<xsl:if test="$first = $last">
					<xsl:attribute name="class">hidden</xsl:attribute>
					<xsl:attribute name="aria-hidden">true</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="$last" /><xsl:if test="$last-est = 'Yes'"> c.</xsl:if>
			</span>
			<xsl:if test="$brackets = 'Yes'">)</xsl:if>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="$unknown = 'Yes'"><xsl:if test="$brackets = 'Yes'">(</xsl:if><span class="text-muted">Unknown</span><xsl:if test="$brackets = 'Yes'">)</xsl:if></xsl:if>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
