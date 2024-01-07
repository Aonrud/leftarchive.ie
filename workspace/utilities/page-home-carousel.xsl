<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="dc">

<xsl:template name="carousel">
	<div id="featured" class="carousel slide" data-ride="carousel">

        <!--Selectors-->
		<ol class="carousel-indicators">
			<xsl:for-each select="/data/documents-this-day/entry">
				<li data-target="#featured" data-slide-to="{position()-1}">
				<xsl:if test="position() = 1"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
				</li>
			</xsl:for-each>
			<xsl:for-each select="/data/featured/entry">
				<li data-target="#featured" data-slide-to="{position()-1+count(/data/documents-this-day/entry)}">
				<xsl:if test="position() = 1 and count(/data/documents-this-day/entry) = 0"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
				</li>
			</xsl:for-each>
		</ol>

        <!--Slides-->
		<div class="carousel-inner">
			<xsl:apply-templates select="/data/documents-this-day/entry" />
			<xsl:apply-templates select="/data/featured/entry" />
		</div>
        <!-- Controls -->
		<a class="left carousel-control" href="#featured" role="button" data-slide="prev">
			<span class="fas fa-chevron-left"></span>
		</a>
		<a class="right carousel-control" href="#featured" role="button" data-slide="next">
			<span class="fas fa-chevron-right"></span>
		</a>
	</div>
</xsl:template>

<xsl:template match="documents-this-day/entry">

    <div class="item type-portrait">
        <xsl:attribute name="class">
            <xsl:text>item type-portrait</xsl:text>
            <xsl:if test="position() = 1"> active</xsl:if>
        </xsl:attribute>
        <a href="/document/{@id}/" data-umami-event="hp-slide" data-umami-event-slide="On This Day: {name}">
            <h4 class="label"><xsl:call-template name="format-date"><xsl:with-param name="date" select="/data/params/today" /><xsl:with-param name="format" select="'D M'" /></xsl:call-template></h4>
            <img src="/image/2/430/460/2{cover-image/@path}/{cover-image/filename}" alt="{name} scan." />
            <div class="carousel-caption">
                <div class="caption-inner">
                    <h3>This day in... <xsl:value-of select="year" /></h3>
                    <p class="hidden-xs"><xsl:value-of select="name" />, from <xsl:call-template name="format-date"><xsl:with-param name="date"><xsl:value-of select="year" />-<xsl:if test="string-length(month) = 1">0</xsl:if><xsl:value-of select="month" />-<xsl:if test="string-length(day) = 1">0</xsl:if><xsl:value-of select="day" /></xsl:with-param><xsl:with-param name="format" select="'D M Y'" /></xsl:call-template></p>
                </div>
            </div>
        </a>
    </div>
</xsl:template>

<xsl:template match="featured/entry">
    <!--Item type-->
    <xsl:variable name="section-url">
        <xsl:call-template name="section-slug">
			<xsl:with-param name="section" select="item/item/@section-handle" />
		</xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="entry-slug">
		<xsl:choose>
			<xsl:when test="item/item/@section-handle = 'pages' or item/item/@section-handle = 'custom-pages'">
				<xsl:value-of select="item/item/@handle" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="item/item/@id" />
			</xsl:otherwise>
		</xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="link">
        <xsl:choose>
            <xsl:when test="custom-url">
                <xsl:value-of select="custom-url" />
            </xsl:when>
            <xsl:otherwise>/<xsl:value-of select="$section-url" />/<xsl:value-of select="$entry-slug" />/</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="caption">
		<xsl:choose>
			<xsl:when test="custom-title">
				<xsl:value-of select="custom-title" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="item/item" mode="entry-name" />
			</xsl:otherwise>
		</xsl:choose>
    </xsl:variable>

    <div class="item">
        <xsl:attribute name="class">
            <xsl:text>item</xsl:text>
            <xsl:text> type-</xsl:text><xsl:value-of select="type/item/@handle" />
            <xsl:if test="position() = 1 and count(/data/documents-this-day/entry) = 0"> active</xsl:if>
        </xsl:attribute>
    
        <a href="{$link}" data-umami-event="hp-slide" data-umami-event-slide="{label}: {$caption}">

            <!--If no image is set and the item is a document, use the cover image
                JIT doesn't have a fit to canvas and fill option, which would solve for orgs.
                This would require switching from association output to chained DSs anyway, as it can't handle
                multiple sections in a single field.
            -->
            <xsl:variable name="image-path">
                <xsl:choose>
                    <xsl:when test="image">
                        <xsl:value-of select="image/@path" />/<xsl:value-of select="image/filename" />
                    </xsl:when>
                    <xsl:when test="item/item/@section-handle = 'documents'">
                        <xsl:value-of select="item/item/cover-image/@path" />/<xsl:value-of select="item/item/cover-image/filename" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>/assets/images/black.png</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="image-width">
                <xsl:choose>
                    <xsl:when test="type/item/@handle = 'landscape'">860</xsl:when>
                    <xsl:otherwise>430</xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <h4 class="label"><xsl:value-of select="label" /></h4>
            <img src="/image/2/{$image-width}/460/2{$image-path}" alt="{$caption}" />
            <div class="carousel-caption">
                <div class="caption-inner">
                    <h3><xsl:value-of select="$caption" /></h3>
                    <xsl:apply-templates select="summary" />
                </div>
            </div>
        </a>
    </div>
</xsl:template>

<xsl:template match="summary">
	<p class="hidden-xs"><xsl:value-of select="." /></p>
</xsl:template>

</xsl:stylesheet>
