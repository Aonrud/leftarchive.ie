<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="information-menu">
    <aside class="panel panel-default">
        <div class="panel-heading"><h3 class="panel-title">Information</h3></div>
        <nav class="list-group">
            <xsl:apply-templates select="/data/pages-list/entry" mode="aside" />
            <a href="/information/news" class="list-group-item">
				<xsl:if test="/data/params/current-page-id = '61'">
					<xsl:attribute name="class">list-group-item active</xsl:attribute>
				</xsl:if>
				News
			</a>
			<a href="/information/publications-bibliography/" class="list-group-item">
				<xsl:if test="/data/params/current-page-id = '65'">
					<xsl:attribute name="class">list-group-item active</xsl:attribute>
				</xsl:if>
				Bibliography of Publications
			</a>
            <a href="/information/further-resources/" class="list-group-item">
				<xsl:if test="/data/params/current-page-id = '13'">
					<xsl:attribute name="class">list-group-item active</xsl:attribute>
				</xsl:if>
				Further Resources
			</a>
            <a href="/submit/" class="list-group-item">
				<xsl:if test="/data/params/current-page-id = '10'">
					<xsl:attribute name="class">list-group-item active</xsl:attribute>
				</xsl:if>
				Submit/Contact
			</a>
        </nav>
    </aside>
</xsl:template>

<xsl:template match="pages-list/entry" mode="aside">
    <a href="/information/{title/@handle}/" class="list-group-item">
        <xsl:if test="/data/params/title = current()/title/@handle"><xsl:attribute name="class">list-group-item active</xsl:attribute></xsl:if>
    <xsl:value-of select="title" /></a>
</xsl:template>

</xsl:stylesheet>
