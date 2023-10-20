<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	* Matches all entries that are in datasources from section '6', which is 'documents'.
	* The match for grandparent is needed for grouped datasources, where there's a level between the entry and the DS root.
-->
<xsl:template match="entry[../section/@id = '6']|entry[../../section/@id = '6']" mode="full">
    <xsl:param name="orgs" select="'No'" />
    <li class="media">
		<xsl:apply-templates select="." mode="document-linked-cover">
			<xsl:with-param name="class" select="'pull-left'" />
			<xsl:with-param name="width" select="'90'" />
			<xsl:with-param name="property" select="'thumbnailUrl'" />
		</xsl:apply-templates>

        <div class="media-body">
            <h4 class="media-heading">
				<xsl:apply-templates select="." mode="entry-link" />
            </h4>
            <p>
                <strong><xsl:value-of select="year" /> <xsl:if test="uncertain = 'Yes'"> c.</xsl:if></strong>
                <!--Switch to param for this convoluted nonsense at some point...-->
                <xsl:if test="count(organisation/item) &gt; 1
                                or organisation/item[@id != /data/organisation-single/entry/@id]
                                or count(/data/publication-single/entry/organisations/item) &gt; 1
                                or /data/params/current-page = 'people'
                                or $orgs = 'Yes'
                                ">
                    <br /><xsl:apply-templates select="organisation/item" mode="entry-list" />
                </xsl:if>
                <xsl:if test="issue-period">
                    <br /><xsl:value-of select="issue-period" />
                </xsl:if>
                <xsl:if test="series">
                    <br /><xsl:value-of select="series" /><xsl:if test="issue">, Number <xsl:value-of select="issue" /></xsl:if>
                </xsl:if>
                <xsl:if test="(authors/item and /data/params/current-page != 'people')
                                or count(authors/item) &gt; 1 
                                ">
                    <br /><xsl:apply-templates select="authors/item" mode="entry-list" />
                </xsl:if>
            </p>
        </div>
    </li>
</xsl:template>

<xsl:template match="entry[../section/@id = '6']|entry[../../section/@id = '6']" mode="simple">
    <li>
        <xsl:value-of select="year" /> <xsl:if test="uncertain = 'Yes'"> c.</xsl:if>
        <xsl:text> - </xsl:text>
        <xsl:apply-templates select="." mode="entry-link" />
    </li>
</xsl:template>

<xsl:template match="entry" mode="documents-thumbnails">
    
    <!--Determines whether organisation name will be shown under the document title.  Defaults to yes-->
    <xsl:param name="org-names" select="'Yes'" />
    <!--How many cols/12 wide is each thumbnail at xs, sm and md sizes (lg inherits).-->
    <xsl:param name="cols-xs" select="'6'" />
    <xsl:param name="cols-sm" select="'6'" />
    <xsl:param name="cols-md" select="'3'" />
    
    <div>
    <xsl:attribute name="class">
        <xsl:text>col-xs-</xsl:text><xsl:value-of select="$cols-xs" />
        <xsl:text> col-sm-</xsl:text><xsl:value-of select="$cols-sm" />
        <xsl:text> col-md-</xsl:text><xsl:value-of select="$cols-md" />
    </xsl:attribute>
        <a>
			<xsl:attribute name="href"><xsl:apply-templates select="." mode="entry-url" /></xsl:attribute>
            <xsl:attribute name="class">thumbnail<xsl:if test="position() &gt; floor(12 div $cols-xs)"> hidden-xs</xsl:if><xsl:if test="position() &gt; floor(12 div $cols-sm)"> hidden-sm</xsl:if></xsl:attribute>
            <img src="/image/1/350/0{cover-image/@path}/{cover-image/filename}" alt="{name}" class="img-responsive" />
            <div class="caption">
                <h4>
                    <xsl:call-template name="word-truncate">
						<xsl:with-param name="string" select="name" />
						<xsl:with-param name="ellipses" select="'Yes'" />
                    </xsl:call-template>

                    (<xsl:value-of select="year" /> <xsl:if test="uncertain = 'Yes'"> c.</xsl:if>)
                </h4>
                <xsl:if test="$org-names = 'Yes'">
                    <p><small><xsl:apply-templates select="organisation/item" mode="entry-list" /></small></p>
                </xsl:if>
            </div>
        </a>
    </div>
</xsl:template>

<xsl:template match="entry" mode="document-linked-cover">
	<xsl:param name="class" select="''" />
	<xsl:param name="width" select="'150'" />
	<xsl:param name="property" select="''" />
	
	<a class="{$class}">
		<xsl:attribute name="href">
			<xsl:apply-templates select="." mode="entry-url" />
		</xsl:attribute>
		<img src="/image/1/{$width}/0{cover-image/@path}/{cover-image/filename}" class="img-responsive" alt="{name}">
			<xsl:if test="$property != ''">
				<xsl:attribute name="property">
					<xsl:value-of select="$property" />
				</xsl:attribute>
			</xsl:if>
		</img>
	</a>
</xsl:template>

<xsl:template match="documents/item" mode="scroller">
    <xsl:param name="show-year" select="'Yes'" />
	<xsl:variable name="docName">
		<xsl:call-template name="word-truncate">
			<xsl:with-param name="string" select="string" />
		</xsl:call-template>
		<xsl:value-of select="name" />
	</xsl:variable>
	
	<li>
		<a href="/document/{@id}/">
			<img src="/image/1/0/300{cover-image/@path}/{cover-image/filename}" alt="{name}" class="img-responsive" />
			<div class="caption">
				<h4>
                    <xsl:value-of select="$docName" />
                    <xsl:if test="$show-year = 'Yes'"> (<xsl:value-of select="year" /><xsl:if test="uncertain = 'Yes'"> c.</xsl:if>)</xsl:if>
                </h4>
				<p><xsl:value-of select="organisation/item" /></p>
			</div>
		</a>
	</li>
</xsl:template>

</xsl:stylesheet>
