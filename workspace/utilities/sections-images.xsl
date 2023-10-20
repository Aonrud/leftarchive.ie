<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!--# Mode: entry-image-url
	#	Return the url of the entry image.
	#	If the entry has no image, a default can be returned.
	#
	#	@param default
	#		If 'Yes', return a default for entries with no image. Any other value, then nothing is returned.
	#	@param default-override
	#		If non-empty, this URL will be used as default instead of the default section image.
-->
<xsl:template match="entry" mode="entry-image-url">
	<xsl:param name="default" select="'Yes'" />
	<xsl:param name="default-override" select="''" />
	
	<xsl:variable name="entry-image-path">
		<xsl:apply-templates select="." mode="entry-image-path" />
	</xsl:variable>
	
	<xsl:choose>
		<xsl:when test="normalize-space($entry-image-path)">
			<xsl:value-of select="$entry-image-path" />
		</xsl:when>
		<xsl:when test="not(normalize-space($entry-image-path)) and $default = 'Yes' and $default-override != ''">
			<xsl:value-of select="$default-override" />
		</xsl:when>
		<xsl:when test="not(normalize-space($entry-image-path)) and $default = 'Yes' and $default-override = ''">
			<xsl:call-template name="section-default-image">
				<xsl:with-param name="section">
					<xsl:apply-templates select="." mode="section-handle" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<!--# Mode: entry-image-path
	# Return the path to the entry image (depends on section)
	# Returns nothing if the entry has no image
-->
<xsl:template match="entry[../section/@handle = 'people'][picture]" mode="entry-image-path">
	<xsl:value-of select="picture/@path" />/<xsl:value-of select="picture/filename" />
</xsl:template>

<xsl:template match="entry[../section/@handle = 'organisations' or ../section/@handle = 'international'][logo]" mode="entry-image-path">
	<xsl:value-of select="logo/@path" />/<xsl:value-of select="logo/filename" />
</xsl:template>

<xsl:template match="entry[../section/@handle = 'publications']" mode="entry-image-path">
	<xsl:choose>
		<xsl:when test="sample-issue/item/cover-image">
			<xsl:value-of select="sample-issue/item/cover-image/@path" />/<xsl:value-of select="sample-issue/item/cover-image/filename" />
		</xsl:when>
		<xsl:when test="not(sample-issue/item/cover-image) and masthead">
			<xsl:value-of select="masthead/@path" />/<xsl:value-of select="masthead/filename" />
		</xsl:when>
	</xsl:choose>
</xsl:template>

<!--If none of the above are matched, then default to returning nothing-->
<xsl:template match="entry" mode="entry-image-path">
	<xsl:text></xsl:text>
</xsl:template>

<!--# Mode: image-dimensions
	# Get the dimensions of an entry image.
	#
	# Since the node name differs by section, the default template looks for the first file node that's jpeg, png or gif.
-->

<!--# For publications, we favour the document cover over the masthead cropped image, so this is checked for first-->
<xsl:template match="entry[../section/@handle = 'publications']" mode="image-dimensions">
	<xsl:choose>
		<xsl:when test="sample-issue/item/cover-image">
			<xsl:value-of select="sample-issue/item/cover-image/meta/@width div sample-issue/item/cover-image/meta/@height" />
		</xsl:when>
		<xsl:when test="masthead and not(sample-issue/item/cover-image)">
			<xsl:value-of select="masthead/meta/@width div masthead/meta/@height" />
		</xsl:when>
		<xsl:otherwise>0</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="entry" mode="image-dimensions">
	<xsl:variable name="width">
		<xsl:value-of select="*[@type = 'image/jpeg' or @type = 'image/png' or @type = 'image/gif'][position() = 1]/meta/@width" />
	</xsl:variable>
	
	<xsl:variable name="height">
		<xsl:value-of select="*[@type = 'image/jpeg' or @type = 'image/png' or @type = 'image/gif'][position() = 1]/meta/@height" />
	</xsl:variable>
	
	<xsl:choose>
		<xsl:when test="$height &gt; 0"><xsl:value-of select="$width div $height" /></xsl:when>
		<xsl:otherwise>0</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
 
