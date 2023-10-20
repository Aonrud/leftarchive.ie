<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="collections-list/entry|collections-list-subject/entry">
    <xsl:param name="doc-count" select="'Yes'" />
    <xsl:param name="section-heading" select="'No'" />
    
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title"><a href="/collection/{@id}/" title="Collection - {name}"><xsl:if test="$section-heading = 'Yes'"><span class="far fa-copy"></span>&#8194;<span class="sr-only">Collection</span></xsl:if><xsl:value-of select="name" /></a></h3>
        </div>
        <div class="panel-body">
            <div class="pull-right collection-img">
            <xsl:choose>
                <xsl:when test="image">
                    <a href="/collection/{@id}/" title="{name}"><img src="/image/2/120/120/5{image/@path}/{image/filename}" alt="{name} collection" class="img-responsive" /></a>
                </xsl:when>
                <xsl:otherwise>
                    <div class="collection-default"><span class="far fa-copy"> </span></div>
                </xsl:otherwise>
            </xsl:choose>
            </div>
            <p><xsl:value-of select="summary" /></p>
            <xsl:if test="$doc-count = 'Yes'">
                <p><strong>Documents: </strong> <xsl:value-of select="count(documents/item)" /></p>
            </xsl:if>
        </div>
    </div>

</xsl:template> 


<xsl:template match="collections-related" mode="entry-table">
	<tr>
		<th scope="row"><span class="fas fa-archive fa-fw"></span> Related Collection<xsl:if test="count(entry) > 1">s</xsl:if>:</th>
		<td>
			<xsl:apply-templates select="entry" mode="entry-list-linked">
				<xsl:with-param name="separator" select="'break'" />
			</xsl:apply-templates>
		</td>
	</tr>
</xsl:template>


</xsl:stylesheet>
