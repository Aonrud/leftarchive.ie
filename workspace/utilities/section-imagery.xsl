<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="imagery">
    <section>
        <h3>Images</h3>
        <ul class="image-list">
            <xsl:apply-templates select="entry" />
        </ul>
    </section>
</xsl:template>

<xsl:template match="imagery/entry">
    <xsl:variable name="with-caption">
        <xsl:choose>
            <xsl:when test="description">true</xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <li>
        <figure class="inline-image">
            <img class="img-responsive img-center viewer" alt="" src="/image/1/200/0{image/@path}/{image/filename}" data-full="/image/0{image/@path}/{image/filename}" data-with-caption="{$with-caption}" />
            <xsl:if test="$with-caption = 'true'">
                <figcaption class="caption"><xsl:apply-templates select="description/*" mode="html" /></figcaption>
            </xsl:if>
        </figure>
    </li>
</xsl:template>

</xsl:stylesheet>
