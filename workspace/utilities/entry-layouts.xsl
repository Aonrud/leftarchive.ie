<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<xsl:import href="sections-images.xsl" />

<xsl:template match="entry" mode="thumbnail">
	<!--Determines whether organisation/publication names will be shown under the entry name (where relevent to section).  Defaults to yes-->
    <xsl:param name="org-names" select="'Yes'" />
    <xsl:param name="pub-names" select="'Yes'" />
    <!--How many cols/12 wide is each thumbnail at xs, sm, md and lg sizes.-->
    <xsl:param name="cols-xs" select="'6'" />
    <xsl:param name="cols-sm" select="'6'" />
    <xsl:param name="cols-md" select="'3'" />
    <xsl:param name="cols-lg" select="'3'" />
        
    <!--If 'Yes', then entries that won't fit on a single row (for each breakpoint) are hidden.
		Used for e.g. latest entries, where total no. shown depends on space.
		(Only checks smaller screens - it's assumed more than 1 row's worth won't be sent for md or lg).
	-->
    <xsl:param name="single-row" select="'No'" />
    
    <!--Whether to show the section icon beside orgs. or pubs. in caption-->
    <xsl:param name="section-icons" select="'No'" />
	
    <xsl:variable name="hide-classes">
		<xsl:if test="position() &gt; floor(12 div $cols-xs) and $single-row = 'Yes'"> hidden-xs</xsl:if>
		<xsl:if test="position() &gt; floor(12 div $cols-sm) and $single-row = 'Yes'"> hidden-sm</xsl:if>
    </xsl:variable>
    
    <xsl:variable name="ratio">
		<xsl:apply-templates select="." mode="image-dimensions" />
	</xsl:variable>
    
    <xsl:variable name="jit-settings">
		<xsl:choose>
			<!--Crop to square for people images-->
			<xsl:when test="../section/@handle = 'people'">/image/2/280/280/2</xsl:when>
			<!--For publications, crop to square if we are using a document cover. If its a masthead, go to default-->
			<xsl:when test="../section/@handle = 'publications' and sample-issue/item/cover-image">/image/2/280/280/2</xsl:when>
			<!--By default, fit to a square canvass-->
			<xsl:otherwise>/image/4/280/280</xsl:otherwise>
		</xsl:choose>
    </xsl:variable>
    
    <div>
    <xsl:attribute name="class">
        <xsl:text>col-xs-</xsl:text><xsl:value-of select="$cols-xs" />
        <xsl:text> col-sm-</xsl:text><xsl:value-of select="$cols-sm" />
        <xsl:text> col-md-</xsl:text><xsl:value-of select="$cols-md" />
        <xsl:text> col-lg-</xsl:text><xsl:value-of select="$cols-lg" />
        <xsl:text> </xsl:text><xsl:value-of select="$hide-classes" />
        <xsl:text> flex-col</xsl:text>
    </xsl:attribute>
        <a class="thumbnail {../section/@handle}">
			<xsl:attribute name="href"><xsl:apply-templates select="." mode="entry-url" /></xsl:attribute>

            <xsl:if test="$ratio &gt; 1">
				<!--When the image is landscape, this div is treated by flexbox as an element in the column, 
					and therefore spaces it away from being flush to the top of the box.
				-->
				<div></div>
			</xsl:if>
			<img alt="{name}" class="img-responsive">
				<xsl:attribute name="src">
					<xsl:value-of select="$jit-settings" /><xsl:apply-templates select="." mode="entry-image-url" />
				</xsl:attribute>
			</img>
            <div class="caption">
                <h4>
					<xsl:attribute name="class">
						<xsl:text>name</xsl:text>
						<xsl:if test="minor = 'Yes'"> text-italics</xsl:if>
					</xsl:attribute>
					
					<xsl:apply-templates select="." mode="entry-thumbnail-title" />

                </h4>
                <xsl:if test="$org-names = 'Yes' and count(organisation/item|organisations/item) != 0">
                    <p class="organisations">
						<small>
							<xsl:if test="$section-icons = 'Yes'">
								<xsl:call-template name="section-icon">
									<xsl:with-param name="section" select="'organisations'" />
								</xsl:call-template>
							</xsl:if>
							<xsl:apply-templates select="organisation/item|organisations/item" mode="entry-list" />
						</small>
					</p>
                </xsl:if>
                 <xsl:if test="$pub-names = 'Yes' and count(publication/item|publications/item) != 0">
                    <p class="publications">
						<small>
							<xsl:if test="$section-icons = 'Yes'">
								<xsl:call-template name="section-icon">
									<xsl:with-param name="section" select="'publications'" />
								</xsl:call-template>
							</xsl:if>
							<xsl:apply-templates select="publication/item|publications/item" mode="entry-list" />
						</small>
					</p>
                </xsl:if>
                
            </div>
        </a>
    </div>
</xsl:template>

<!--# Templates for entry names shown on thumbnails.
	# Allows including some extra info in some instances.
-->
<xsl:template match="entry[../section/@handle = 'documents']" mode="entry-thumbnail-title">
	<xsl:call-template name="word-truncate">
		<xsl:with-param name="string">
			<xsl:apply-templates select="." mode="entry-name" />
		</xsl:with-param>
		<xsl:with-param name="ellipses" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="entry[../section/@handle = 'organisations']" mode="entry-thumbnail-title">
	<xsl:apply-templates select="." mode="entry-name" /> <xsl:if test="acronym"> (<xsl:value-of select="acronym" />)</xsl:if>
	<xsl:if test="place/item != 'Ireland'"><small>&#160;<xsl:value-of select="place/item" /></small></xsl:if>
</xsl:template>

<!--Defaults to just the entry name-->
<xsl:template match="entry" mode="entry-thumbnail-title">
	<xsl:apply-templates select="." mode="entry-name" />
</xsl:template>
	
</xsl:stylesheet>
