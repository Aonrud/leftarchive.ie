<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template name="section-shortname">
    <xsl:param name="section" />
    <xsl:param name="section-id" />

    <xsl:choose>
        <xsl:when test="$section-id = '6' or $section = 'documents'">Documents</xsl:when>
        <xsl:when test="$section-id = '4' or $section = 'organisations'">Organisations</xsl:when>
        <xsl:when test="$section-id = '24' or $section = 'international'">Internationals</xsl:when>
        <xsl:when test="$section-id = '5' or $section = 'publications'">Publications</xsl:when>
        <xsl:when test="$section-id = '19' or $section = 'people'">People</xsl:when>
        <xsl:when test="$section-id = '17' or $section = 'collections'">Collections</xsl:when>
        <xsl:when test="$section-id = '15' or $section = 'extended-articles'">Articles</xsl:when>
        <xsl:when test="$section-id = '31' or $section = 'subjects'">Subjects</xsl:when>
        <xsl:when test="$section-id = '41' or $section = 'podcast'">Podcasts</xsl:when>
        <xsl:when test="$section-id = '46' or $section = 'demonstrations'">Demonstrations</xsl:when>
    </xsl:choose>
</xsl:template>
	
<!--Return the list page URL for the given section-->
<xsl:template name="section-root">
    <xsl:param name="section" />
    <xsl:param name="section-id" />

    <xsl:choose>
        <xsl:when test="$section-id = '6' or $section = 'documents'">/documents/</xsl:when>
        <xsl:when test="$section-id = '4' or $section = 'organisations'">/browse/organisations/</xsl:when>
        <xsl:when test="$section-id = '24' or $section = 'international'">/browse/international-organisations/</xsl:when>
        <xsl:when test="$section-id = '5' or $section = 'publications'">/browse/publications/</xsl:when>
        <xsl:when test="$section-id = '19' or $section = 'people'">/browse/people/</xsl:when>
        <xsl:when test="$section-id = '17' or $section = 'collections'">/collections/</xsl:when>
        <xsl:when test="$section-id = '15' or $section = 'extended-articles'">/articles/</xsl:when>
        <xsl:when test="$section-id = '31' or $section = 'subjects'">/browse/subjects/</xsl:when>
        <xsl:when test="$section-id = '41' or $section = 'podcast'">/podcast/</xsl:when>
        <xsl:when test="$section-id = '46' or $section = 'demonstrations'">/demonstrations/</xsl:when>
    </xsl:choose>
</xsl:template>

<!--Return the url directory slug for the given section-->
<xsl:template name="section-slug">
    <xsl:param name="section" />
    <xsl:param name="section-id" />

    <xsl:choose>
        <xsl:when test="$section-id = '6' or $section = 'documents'">document</xsl:when>
        <xsl:when test="$section-id = '4' or $section = 'organisations'">organisation</xsl:when>
        <xsl:when test="$section-id = '24' or $section = 'international'">international</xsl:when>
        <xsl:when test="$section-id = '5' or $section = 'publications'">publication</xsl:when>
        <xsl:when test="$section-id = '19' or $section = 'people'">people</xsl:when>
        <xsl:when test="$section-id = '17' or $section = 'collections'">collection</xsl:when>
        <xsl:when test="$section-id = '15' or $section = 'extended-articles'">article</xsl:when>
        <xsl:when test="$section-id = '31' or $section = 'subjects'">subject</xsl:when>
        <xsl:when test="$section-id = '13' or $section = 'pages'">information</xsl:when>
        <xsl:when test="$section-id = '41' or $section = 'podcast'">podcast</xsl:when>
        <xsl:when test="$section-id = '21' or $section = 'custom-pages'">page</xsl:when>
        <xsl:when test="$section-id = '46' or $section = 'demonstrations'">demonstration</xsl:when>
    </xsl:choose>
</xsl:template>
	
<xsl:template name="section-icon">
    <!--As long as either section or section-id is set, the right value will be returned-->
    <xsl:param name="section" />
    <xsl:param name="section-id" />
    <xsl:param name="class-only" select="'no'" />
    <xsl:param name="fixed" select="'yes'" />
    <!--This appends trailing whitespace (deals with when the icon is followed by text and not a tag. Can be excluded if a tag follows the call directly or if spacing is inconsistent-->
    <xsl:param name="pad" select="'Yes'" />

    <xsl:variable name="section-class">
        <xsl:choose>
            <xsl:when test="$section-id = '6' or $section = 'documents'">fa-file-lines</xsl:when>
            <xsl:when test="$section-id = '4' or $section = 'organisations'">fa-users</xsl:when>
            <xsl:when test="$section-id = '24' or $section = 'international'">fa-globe-europe</xsl:when>
            <xsl:when test="$section-id = '5' or $section = 'publications'">fa-newspaper</xsl:when>
            <xsl:when test="$section-id = '19' or $section = 'people'">fa-user</xsl:when>
            <xsl:when test="$section-id = '17' or $section = 'collections'">fa-box-archive</xsl:when>
            <xsl:when test="$section-id = '15' or $section = 'extended-articles'">fa-book-open</xsl:when>
            <xsl:when test="$section-id = '31' or $section = 'subjects'">fa-bookmark</xsl:when>
            <xsl:when test="$section-id = '41' or $section = 'podcast'">fa-microphone-alt</xsl:when>
            <xsl:when test="$section-id = '46' or $section = 'demonstrations'">fa-bullhorn</xsl:when>
            <xsl:when test="$section-id = '47' or $section = 'places'">fa-map</xsl:when>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:choose>
        <xsl:when test="$class-only = 'yes'"><xsl:value-of select="$section-class" /></xsl:when>
        <xsl:otherwise>
            <span>
                <xsl:attribute name="class">fas <xsl:value-of select="$section-class" /> <xsl:if test="$fixed = 'yes'"> fa-fw</xsl:if></xsl:attribute>
            </span><xsl:if test="$pad = 'Yes'">&#160;</xsl:if>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="section-default-image">
	<xsl:param name="section" />
    <xsl:param name="section-id" />
    
    <xsl:variable name="filename">
        <xsl:choose>
            <xsl:when test="$section-id = '6' or $section = 'documents'"></xsl:when>
            <xsl:when test="$section-id = '4' or $section = 'organisations'">organisations.png</xsl:when>
            <xsl:when test="$section-id = '24' or $section = 'international'">international.png</xsl:when>
            <xsl:when test="$section-id = '5' or $section = 'publications'">publications.png</xsl:when>
            <xsl:when test="$section-id = '19' or $section = 'people'">people.png</xsl:when>
            <xsl:when test="$section-id = '17' or $section = 'collections'"></xsl:when>
            <xsl:when test="$section-id = '15' or $section = 'extended-articles'"></xsl:when>
            <xsl:when test="$section-id = '31' or $section = 'subjects'"></xsl:when>
            <xsl:when test="$section-id = '41' or $section = 'podcast'"></xsl:when>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:text>/assets/images/section-images/</xsl:text><xsl:value-of select="$filename" />
</xsl:template>

<xsl:template name="section-default-schema-type">
	<xsl:param name="section" />
	<xsl:param name="section-id" />
	
	<xsl:variable name="type">
		<xsl:choose>
			<!--Documents have variable type by entry, so shouldn't use this, but sensible default added as fallback-->
			<xsl:when test="$section-id = '6' or $section = 'documents'">CreativeWork</xsl:when>
            <xsl:when test="$section-id = '4' or $section = 'organisations'">Organization</xsl:when>
            <xsl:when test="$section-id = '24' or $section = 'international'">Organization</xsl:when>
            <xsl:when test="$section-id = '5' or $section = 'publications'">Periodical</xsl:when>
            <xsl:when test="$section-id = '19' or $section = 'people'">Person</xsl:when>
            <xsl:when test="$section-id = '17' or $section = 'collections'">Collection</xsl:when>
            <xsl:when test="$section-id = '15' or $section = 'extended-articles'">Article</xsl:when>
            <!--Not used for subjects. But collection is probably the safest default-->
            <xsl:when test="$section-id = '31' or $section = 'subjects'">Collection</xsl:when>  
            <xsl:when test="$section-id = '46' or $section = 'demonstrations'">Event</xsl:when>  
		</xsl:choose>
	</xsl:variable>
	<xsl:value-of select="$type" />
</xsl:template>

<xsl:template name="section-default-schema-uri-hash">
	<xsl:param name="section" />
	<xsl:param name="section-id" />
	
	<xsl:variable name="slug">
		<xsl:choose>
			<xsl:when test="$section-id = '6' or $section = 'documents'">doc</xsl:when>
            <xsl:when test="$section-id = '4' or $section = 'organisations'">org</xsl:when>
            <xsl:when test="$section-id = '24' or $section = 'international'">org</xsl:when>
            <xsl:when test="$section-id = '5' or $section = 'publications'">pub</xsl:when>
            <xsl:when test="$section-id = '19' or $section = 'people'">person</xsl:when>
            <xsl:when test="$section-id = '46' or $section = 'demonstrations'">demo</xsl:when>
            <!--The collection URI is the page URI, since it's not an entity distinct from the archive page really-->
            <xsl:when test="$section-id = '17' or $section = 'collections'"></xsl:when>
            <!--Articles and subjects are not marked up as schema objects-->
            <xsl:when test="$section-id = '15' or $section = 'extended-articles'"></xsl:when>
            <xsl:when test="$section-id = '31' or $section = 'subjects'"></xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:value-of select="$slug" />
</xsl:template>

</xsl:stylesheet>
