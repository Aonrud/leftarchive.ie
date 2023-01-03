<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="section.xsl" />
<!--# Templates for entries in a number of sections
	#
	# The main templates match entry or item with these modes:
	#
	# entry-list-linked
	#	A linked list of entries, with separators.
	# entry-list
	# 	An unlinked list of entry names, with separators.
	#
	# Several additional templates used to construct these may be useful elsewhere - see documentation of each.
	#
	# In particular:
	#
	# entry-url
	#	Returns the URL for the entry, based on ID, section and parent, if present.
	#
	# @depends: section.xsl.  Some templates won't function without the templates imported from this.
	#
	# (This should remove the need for a lot of similar section-specific templates that were achieving the same result).
-->


<!--# Mode: entry-list-linked
	# Default: A comma-separated list, each entry linked to the right page.
	#
	# @param separator
	# 	The string/character to use as separator. Defaults to comma.
	#	If 'break' is specified, the template uses a <br /> element and not the string.
	# @param last-and
	# 	If 'Yes', use 'and' as the separator for the last item in the list, instead of the separator.
	# @param expand
	# 	Whether to expand minor entries to "X (see parent)", instead of directly linking the parent.
	# @param rdfa
	#	If 'Yes', apply rdfa schema to the entry
	#	Additional schema params are optional:
	# 	@param property
	#		The property to apply to the entry (i.e. if it is itself a property of another RDFa object). Defaults to none.
	#	@param type
	#		The RDFa object type. Default determined by section, if not specified. (Uses 'entry-default-schema-type' template).
	#	@param resource
	#		The resource URI for the object. Default determined by section & entry type. (Uses 'entry-resource-uri' template).
-->
<xsl:template match="entry|item" mode="entry-list-linked">
	<xsl:param name="separator" select="','" />
	<xsl:param name="last-and" select="'No'" />
	<xsl:param name="expand" select="'No'" />
    <xsl:param name="rdfa" select="'No'" />
    <xsl:param name="property" select="''" />
    <xsl:param name="type">
		<xsl:apply-templates select="." mode="entry-schema-type" />
    </xsl:param>
    <xsl:param name="resource">
		<xsl:apply-templates select="." mode="entry-resource-uri" />
    </xsl:param>
    
    <xsl:if test="position() = last() and $last-and = 'Yes'">
		<xsl:text> and </xsl:text>
	</xsl:if>
	<xsl:if test="position() != 1 and (position != last() or $last-and != 'Yes')">
		<xsl:choose>
			<xsl:when test="$separator = 'break'">
				<br />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$separator" /><xsl:text>&#32;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>        
    
    <xsl:choose>
		<xsl:when test="$rdfa='Yes' and $expand = 'Yes'">
			<xsl:apply-templates select="." mode="entry-link-rdfa-expanded">
				<xsl:with-param name="property" select="$property" />
				<xsl:with-param name="type" select="$type" />
				<xsl:with-param name="resource" select="$resource" />
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="$rdfa = 'Yes' and $expand = 'No'">
			<xsl:apply-templates select="." mode="entry-link-rdfa">
				<xsl:with-param name="property" select="$property" />
				<xsl:with-param name="type" select="$type" />
				<xsl:with-param name="resource" select="$resource" />
			</xsl:apply-templates>
		</xsl:when>
		<xsl:when test="$rdfa = 'No' and $expand = 'Yes'">
			<xsl:apply-templates select="." mode="entry-link-expanded" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="." mode="entry-link" />
		</xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<!--# Mode: entry-list
	# Default: A comma-separated list of entry names.
	#
	# @param separator
	# 	The string/character to use as separator. Defaults to comma.
	#	If 'break' is specified, the template uses a <br /> element and not the string.
	# @param last-and
	# 	If 'Yes', use 'and' as the separator for the last item in the list, instead of the separator.
-->
<xsl:template match="entry|item" mode="entry-list">
	<xsl:param name="separator" select="','" />
	<xsl:param name="last-and" select="'No'" />
	
	<xsl:if test="position() = last() and $last-and = 'Yes'">
		<xsl:text> and </xsl:text>
	</xsl:if>
	<xsl:if test="position() != 1 and (position() != last() or $last-and != 'Yes')">
		<xsl:choose>
			<xsl:when test="$separator = 'break'">
				<br />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$separator" /><xsl:text>&#32;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
	<xsl:apply-templates select="." mode="entry-name" />
</xsl:template>

<!--# Mode: entry-link-rdfa-expanded
	# If entry is minor, outputs Name (see <Parent Link>) with RDFa. If not minor, outputs same as entry-link-rdfa.
	#
	# @param property
	#	The property to apply to the entry (i.e. if it is itself a property of another RDFa object). Defaults to none.
	# @param type
	#	The RDFa object type. Default determined by section, if not specified. (Uses 'entry-default-schema-type' template).
	# @param resource
	#	The resource URI for the object. Default determined by section & entry type. (Uses 'entry-resource-uri' template).
-->
<xsl:template match="entry[minor = 'Yes']|item[minor = 'Yes']" mode="entry-link-rdfa-expanded">
	
	<xsl:param name="property" select="''" />
    <xsl:param name="type">
		<xsl:apply-templates select="." mode="entry-schema-type" />
    </xsl:param>
    <xsl:param name="resource">
		<xsl:apply-templates select="." mode="entry-resource-uri" />
    </xsl:param>
	
	<span typeof="{$type}" resource="{$resource}">
		<xsl:if test="$property != ''">
			<xsl:attribute name="property">
				<xsl:value-of select="$property" />
			</xsl:attribute>
		</xsl:if>
		<span property="schema:name">
			<xsl:apply-templates select="." mode="entry-name" />
		</span>
	</span>
	<em>
		<xsl:text> (see </xsl:text>
			<xsl:apply-templates select="parent/item" mode="entry-link" />
		<xsl:text>)</xsl:text>
	</em>
</xsl:template>

<!--# Match includes not(minor) due to legacy database entries, where the value isn't set. Can be treated as 'no'.
	# This should be cleaned up in the DB....
-->
<xsl:template match="entry[minor != 'Yes' or not(minor)]|item[minor != 'Yes' or not(minor)]" mode="entry-link-rdfa-expanded">
	<xsl:param name="property" select="''" />
    <xsl:param name="type">
		<xsl:apply-templates select="." mode="entry-schema-type" />
    </xsl:param>
    <xsl:param name="resource">
		<xsl:apply-templates select="." mode="entry-resource-uri" />
    </xsl:param>
    
    <xsl:apply-templates select="." mode="entry-link-rdfa">
		<xsl:with-param name="property" select="$property" />
		<xsl:with-param name="type" select="$type" />
		<xsl:with-param name="resource" select="$resource" />
    </xsl:apply-templates>
</xsl:template>

<!--# Mode: entry-link-rdfa
	# Default: Outputs link for entry, marked up with RDFa.
	#
	# @param property
	#	The property to apply to the entry (i.e. if it is itself a property of another RDFa object). Defaults to none.
	# @param type
	#	The RDFa object type. Default determined by section, if not specified. (Uses 'entry-default-schema-type' template).
	# @param resource
	#	The resource URI for the object. Default determined by section & entry type. (Uses 'entry-resource-uri' template).
-->
<xsl:template match="entry|item" mode="entry-link-rdfa">
	<xsl:param name="property" select="''" />
    <xsl:param name="type">
		<xsl:apply-templates select="." mode="entry-schema-type" />
    </xsl:param>
    <xsl:param name="resource">
		<xsl:apply-templates select="." mode="entry-resource-uri" />
    </xsl:param>
	
	<span typeof="{$type}" resource="{$resource}">
		<xsl:if test="$property != ''">
			<xsl:attribute name="property">
				<xsl:value-of select="$property" />
			</xsl:attribute>
		</xsl:if>
		<a property="schema:url">
			<xsl:attribute name="href">
				<xsl:apply-templates select="." mode="entry-url" />
			</xsl:attribute>
			<xsl:attribute name="title">
				<xsl:apply-templates select="." mode="entry-name" />
			</xsl:attribute>
			<span property="schema:name">
				<xsl:apply-templates select="." mode="entry-name" />
			</span>
		</a>
	</span>
</xsl:template>

<!--# Mode: entry-link-expanded
	# Outputs 'Name (see <Parent Link>)' for minor entries.
-->
<xsl:template match="entry[minor = 'Yes']|item[minor = 'Yes']" mode="entry-link-expanded">
	<xsl:apply-templates select="." mode="entry-name" />
	<em>
		<xsl:text> (see </xsl:text>
		<a>
			<xsl:attribute name="href">
				<xsl:apply-templates select="." mode="entry-url" />
			</xsl:attribute>
			<xsl:attribute name="title">
				<xsl:apply-templates select="." mode="entry-name" /> - see <xsl:value-of select="parent/item" />
			</xsl:attribute>
			<xsl:value-of select="parent/item" />
		</a>
		<xsl:text>)</xsl:text>
	</em>
</xsl:template>

<!--# Match includes not(minor) due to legacy database entries, where the value isn't set. Can be treated as 'no'.
	# This should be cleaned up in the DB....
-->
<xsl:template match="entry[minor != 'Yes' or not(minor)]|item[minor != 'Yes' or not(minor)]" mode="entry-link-expanded">
	<xsl:apply-templates select="." mode="entry-link" />
</xsl:template>

<!--# Mode: entry-link
	# Outputs a bare <a> link to the entry
-->
<xsl:template match="entry|item" mode="entry-link">   
    <a>
		<xsl:attribute name="href">
			<xsl:apply-templates select="." mode="entry-url" />
		</xsl:attribute>
		<xsl:attribute name="title">
			<xsl:apply-templates select="." mode="entry-name" />
		</xsl:attribute>
			
		<xsl:apply-templates select="." mode="entry-name" />
	</a>
</xsl:template>

<!--# Mode: entry-resource-uri
	# Outputs the resource URI for the entry, based on section and entry-type.
-->
<xsl:template match="entry|item" mode="entry-resource-uri">
	<xsl:apply-templates select="." mode="entry-url" />
	<xsl:text>#</xsl:text>
	<xsl:apply-templates select="." mode="entry-resource-uri-hash" />
</xsl:template>

<!--# Mode: entry-resource-uri-hash
	# Returns the URI hash portion of the resource URI for the entry.
	#
	# !This is only required because minor entries are currently given an 'alt' URI on the parent page.
	# !As Schema URI's don't need to be URLs, that's probably not needed.
	# !Better to migrate all minor entry URIs to the default values.
	# !If used as a link, it will bring to the parent URL anyway, so everything will line up that way.
-->
<xsl:template match="entry|item" mode="entry-resource-uri-hash">
	<xsl:choose>
        <!--"minor != 'Yes'" doesn't seem to be sufficient... Won't evaluate if minor is absent-->
		<xsl:when test="not(minor) or minor != 'Yes'">
			<xsl:call-template name="section-default-schema-uri-hash">
				<xsl:with-param name="section">
					<xsl:apply-templates select="." mode="section-handle" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise><xsl:text>alt</xsl:text><xsl:value-of select="@id" /></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--# Mode: entry-name
	# Returns the entry name, accounting for entry/item node structure.

	# Used due to different item structures in the source XML.
	# If Association Output extension is applied, then there will be a name element. A bare association will have the name in the node text.
	# 'name' is the name in the preferred order for an entry in the 'people' section, so is pulled where present instead of 'name'.
-->
<xsl:template match="entry|item" mode="entry-name">
        <xsl:choose>
            <xsl:when test="name"><xsl:value-of select="name" /></xsl:when>
            <xsl:otherwise><xsl:value-of select="." /></xsl:otherwise>
        </xsl:choose>
</xsl:template>

<!--# Mode: entry-image
	# Returns an image element for the given entry
	
	# The image element varies by section - the default is to look for an 'image' element
-->
<xsl:template match="entry|item" mode="entry-image">
	<xsl:param name="width" select="'200'" />
	<xsl:param name="classes" select="'img-responsive'" />
	
	<xsl:variable name="url">
		<xsl:apply-templates select="." mode="entry-image-url" />
	</xsl:variable>
	
	<xsl:if test="normalize-space($url) != ''">
		<img class="{$classes}" src="/image/1/{$width}/0{$url}" alt="{name}" />
	</xsl:if>
</xsl:template>

<!--# Mode: entry-image-url
	# Returns an image URL for the entry, relative to the workspace.
	
	# The image element varies by section - the default is to look for an 'image' element
-->
<xsl:template match="entry|item" mode="entry-image-url">	
	<xsl:variable name="path">
		<xsl:choose>
			<xsl:when test="../section/@handle = 'documents'"><xsl:value-of select="cover-image/@path" /></xsl:when>
			<xsl:when test="../section/@handle = 'organisations' or ../section/@handle = 'international'"><xsl:value-of select="logo/@path" /></xsl:when>
			<xsl:when test="../section/@handle = 'publications'"><xsl:value-of select="masthead/@path" /></xsl:when>
			<xsl:when test="../section/@handle = 'people'"><xsl:value-of select="picture/@path" /></xsl:when>
			<xsl:otherwise><xsl:value-of select="image/@path" /></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="file">
		<xsl:choose>
			<xsl:when test="../section/@handle = 'documents'"><xsl:value-of select="cover-image/filename" /></xsl:when>
			<xsl:when test="../section/@handle = 'organisations' or ../section/@handle = 'international'"><xsl:value-of select="logo/filename" /></xsl:when>
			<xsl:when test="../section/@handle = 'publications'"><xsl:value-of select="masthead/filename" /></xsl:when>
			<xsl:when test="../section/@handle = 'people'"><xsl:value-of select="picture/filename" /></xsl:when>
			<xsl:otherwise><xsl:value-of select="image/filename" /></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:if test="$path != '' and $file != ''">
		<xsl:value-of select="$path" />/<xsl:value-of select="$file" />
	</xsl:if>
</xsl:template>

<!--# Mode: entry-url
	# Ouputs the URL for the matched entry
	#
	# !Really just duplicates get-url... but makes it easier to get the URL without passing the params every time.
-->

<!--# Special cases, where entry URL isn't ID-based.
	# NOTE: Putting these here for now, because even with a higher priority, the import precedence rules them out
	# 		if they are left in section-comments-recent.xsl. TODO: Audit the import of XSLT utilities so this is
	#		more in control...
	#		@see https://www.w3.org/TR/1999/REC-xslt-19991116#dt-import-precedence
-->
<xsl:template match="entry[../section/@handle = 'pages']|item[@section-handle = 'pages']" mode="entry-url">
	<xsl:param name="absolute" select="'No'" />
	<xsl:if test="$absolute = 'Yes'"><xsl:value-of select="/data/params/root" /></xsl:if>
	<xsl:text>/information/</xsl:text><xsl:value-of select="@handle" /><xsl:text>/</xsl:text>
</xsl:template>


<!--Podcast URLs are different - this requires a DS to provide the URL reflection field-->
<xsl:template match="entry[../section/@handle = 'podcast']|item[@section-handle = 'podcast']" mode="entry-url">
	<xsl:param name="absolute" select="'No'" />
	
	<xsl:if test="$absolute = 'Yes'"><xsl:value-of select="/data/params/root" /></xsl:if>
	<xsl:text>/podcast/</xsl:text>
	<xsl:value-of select="/data/podcast-url/entry[@id = current()/@id]/url" />
	<xsl:text>/</xsl:text>
</xsl:template>

<xsl:template match="entry|item" mode="entry-url">
	<xsl:param name="absolute" select="'No'" />

	<xsl:call-template name="get-url">
		<xsl:with-param name="id">
			<xsl:apply-templates select="." mode="entry-link-id" />
		</xsl:with-param>
		<xsl:with-param name="section">
			<xsl:apply-templates select="." mode="section-handle" />
		</xsl:with-param>
		<xsl:with-param name="absolute" select="$absolute" />
	</xsl:call-template>
</xsl:template>

<!--# Mode: entry-link-id
	# Return the page link ID for a given item. (Parent ID for minor items, otherwise entry ID)
-->
<xsl:template match="entry|item" mode="entry-link-id">
        <xsl:choose>
            <xsl:when test="minor = 'Yes'">
                <xsl:value-of select="parent/item/@id" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="@id" />
            </xsl:otherwise>
        </xsl:choose>
</xsl:template>

<!--# Mode: entry-schema-type
	# Returns the schema type for the specific entry
-->
<xsl:template match="entry|item" mode="entry-schema-type">
	<xsl:choose>
		<xsl:when test="type/item/meta/item[starts-with(@handle, 'schema')]">
			<xsl:value-of select="type/item/meta/item[starts-with(@handle, 'schema')]" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>schema:</xsl:text>
			<xsl:call-template name="section-default-schema-type">
				<xsl:with-param name="section">
					<xsl:apply-templates select="." mode="section-handle" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--# Mode: section-handle
	# Returns the section handle for an entry or item
-->
<xsl:template match="entry" mode="section-handle">
	<xsl:value-of select="../section/@handle" />
</xsl:template>

<!--# This one catches grouped datasources, where entry is a grandchild of the DS root node
	#
-->
<xsl:template match="entry[../../section]" mode="section-handle">
	<xsl:value-of select="../../section/@handle" />
</xsl:template>

<xsl:template match="item" mode="section-handle">
	<xsl:value-of select="@section-handle" />
</xsl:template>

<!--# Named: get-url
	# Return a URL based on provided ID and section.
	#
	# !Works for ID-based URLs only - exludes 'podcast', 'pages' and 'custom-pages' sections.
-->
<xsl:template name="get-url">
    <xsl:param name="id" />
    <xsl:param name="section" />
    <xsl:param name="section-id" />
    <xsl:param name="absolute" select="'No'" />
    
    <xsl:if test="$absolute = 'Yes'"><xsl:value-of select="/data/params/root" /></xsl:if>
    <xsl:text>/</xsl:text><xsl:call-template name="section-slug"><xsl:with-param name="section" select="$section" /><xsl:with-param name="section-id" select="$section-id" /></xsl:call-template><xsl:text>/</xsl:text><xsl:value-of select="$id" /><xsl:text>/</xsl:text>
</xsl:template>

</xsl:stylesheet>
