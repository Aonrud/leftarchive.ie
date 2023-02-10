<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:str="http://exslt.org/strings"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="str exsl"
	exclude-result-prefixes="str exsl">
	
<xsl:import href="general-strings.xsl" />

<!--#
	# Depends on entry.xsl (for inline entry display) - imported in master.xsl.
-->
	
<!--
Usage:
1. Invoke the HTML output using: <xsl:apply-templates select="path/to/your/body/*" mode="html"/>.
2. Write your own overriding matching templates to manipulate the HTML.
-->

<xsl:template match="*" mode="html">
	<xsl:element name="{name()}">
		<xsl:apply-templates select="* | @* | text()" mode="html"/>
	</xsl:element>
</xsl:template>

<xsl:template match="@*" mode="html">
	<xsl:attribute name="{name()}">
		<xsl:value-of select="."/>
	</xsl:attribute>
</xsl:template>

<xsl:template match="a" priority="1" mode="html">
    <xsl:variable name="external">
        <xsl:choose>
			<!--Don't add icon and rel to links with explicitly set 'no-ext' class-->
            <xsl:when test="not(contains(@class, 'no-ext')) and contains(@href,'//') and not(contains(@href, 'leftarchive.ie'))">Yes</xsl:when>
            <xsl:otherwise>No</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:element name="a">
        <xsl:attribute name="href">
            <!--Change to absolute URLs for XML page type (RSS feeds should have abs. URLs).
				Not foolproof, but a URL shouldn't have //, except after the protocol.
            -->
            <xsl:if test="not(contains(@href,'//')) and /data/params/page-types/item = 'XML'"><xsl:value-of select="$root" /></xsl:if>
            <xsl:value-of select="@href" />
        </xsl:attribute>

        <xsl:if test="$external = 'Yes'">
            <xsl:attribute name="rel">nofollow external</xsl:attribute>
        </xsl:if>
                
        <xsl:attribute name="class">
            <xsl:value-of select="@class" />
            <xsl:if test="$external = 'Yes'"> external-link</xsl:if>
        </xsl:attribute>

        <xsl:apply-templates select="* | text()" mode="html" />
        <xsl:if test="$external = 'Yes'">&#8239;<span class="fas fa-external-link-alt"></span></xsl:if>
    </xsl:element>
</xsl:template>

<xsl:template match="iframe" priority="1" mode="html">
	<xsl:variable name="ratio">
		<xsl:choose>
			<xsl:when test="@width and @height"><xsl:value-of select="@height / @width" /></xsl:when>
			<xsl:otherwise>0.67</xsl:otherwise> <!--Assume value to match default wrapper-->
		</xsl:choose>
	</xsl:variable>
	
	<div class="video-container">
		<div>
			<xsl:attribute name="class">
				<xsl:text>flex-video</xsl:text>
				<xsl:if test="$ratio &lt; 0.6"> widescreen</xsl:if>
				<xsl:if test="contains(@src, 'vimeo')"> vimeo</xsl:if>
			</xsl:attribute>
			<iframe src="{@src}" allowfullscreen="yes" frameborder="0"></iframe>
		</div>
	</div>
</xsl:template>

<!--Don't wrap iframes that explicitly set the nowrap class-->
<xsl:template match="iframe[contains(concat(' ', @class, ' '), ' nowrap ')]" priority="1" mode="html">
	<iframe frameborder="0">
		<xsl:apply-templates select="* | @* | text()" mode="html"/>
	</iframe>
</xsl:template>

<xsl:template match="img" priority="1" mode="html">
	<img class="img-responsive" alt="{@alt}">
		<xsl:attribute name="src">
			<!--Add root to relative img URLs on XML pages, to make absolute URL references-->
			<xsl:if test="not(contains(@src,'//')) and /data/params/page-types/item = 'XML'"><xsl:value-of select="$root" /></xsl:if>
			<xsl:value-of select="@src" />
		</xsl:attribute>
	</img>
</xsl:template>

<!--Add bootstrap classes to tables by default-->
<xsl:template match="table" priority="1" mode="html">
    <table class="table table-responsive">
        <xsl:apply-templates select="* | @* | text()" mode="html"/>
    </table>
</xsl:template>

<!--# Inline documents and images
	# Match paragraphs that start with ![document|image] and replace them with a custom HTML representation of the entry.
	# TODO: remove template duplication - maybe pass type
-->

<!--# Inline extract - a single one
-->
<xsl:template match="p[starts-with(text(), '!image')]" mode="html" priority="1">
	<xsl:variable name="id" select="substring-after(text(), ' ')" />
	<xsl:apply-templates select="/data/extracts-inline/entry[@id = $id]" />
</xsl:template>

<!--# Inline extracts - multiple in row
-->
<xsl:template match="p[starts-with(text(), '!images')]" mode="html" priority="1">
	<xsl:variable name="string">
		<xsl:value-of select="substring-after(text(), '!images ')" />
	</xsl:variable>
	
	<div class="row">
		<xsl:call-template name="show-inline-images">
			<xsl:with-param name="string" select="$string" />
		</xsl:call-template>
	</div>
</xsl:template>

<!--#This template is recursive, to allow multiple, space-separated extract IDs to be passed.
	#The displaying template will be called for each ID found in the string
-->
<xsl:template name="show-inline-images">
	<xsl:param name="string" />
	
	<xsl:variable name="id">
		<xsl:value-of select="substring-before(concat($string,' '),' ')" />
	</xsl:variable>
	
	<xsl:apply-templates select="/data/extracts-inline/entry[@id = $id]|/data/inline-images/entry[@id = $id]">
		<xsl:with-param name="class" select="'col-sm-6'" />
	</xsl:apply-templates>
	
	<xsl:if test="contains($string,' ')">
		<xsl:call-template name="show-inline-images">
			<xsl:with-param name="string" select="substring-after($string,' ')" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template match="extracts-inline/entry|inline-images/entry">
    <xsl:param name="class" select="''" />
    
    <xsl:variable name="alt">
		<xsl:choose>
			<xsl:when test="transcription"><xsl:value-of select="transcription" /></xsl:when>
			<xsl:when test="caption and not(transcription)"><xsl:value-of select="caption" /></xsl:when>
			<xsl:otherwise><xsl:value-of select="name" /></xsl:otherwise>
		</xsl:choose>
    </xsl:variable>
	
	<figure class="inline-figure inline-image {$class}">
        
        <xsl:choose>
			<xsl:when test="document">
				<a>
					<xsl:attribute name="href"><xsl:if test="/data/params/page-types/item = 'XML'"><xsl:value-of select="/data/params/root" /></xsl:if>/document/view/<xsl:value-of select="document/item/@id" />?page=<xsl:value-of select="document-page" /></xsl:attribute>
					<xsl:apply-templates select="image">
						<xsl:with-param name="alt" select="$alt" />
					</xsl:apply-templates>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="image">
					<xsl:with-param name="alt" select="$alt" />
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
        
		<xsl:if test="caption">
            <figcaption class="caption"><xsl:value-of select="caption" /></figcaption>
        </xsl:if>
	</figure>
</xsl:template>

<xsl:template match="extracts-inline/entry/image|inline-images/entry/image">
	<xsl:param name="alt" select="''" />
	<xsl:param name="class" select="'col-xs-6 col-md-4'" />

	<img class="img-responsive img-center viewer" alt="{$alt}" data-full="/image/0{@path}/{filename}">
		<xsl:attribute name="src"><xsl:if test="/data/params/page-types/item = 'XML'"><xsl:value-of select="/data/params/root" /></xsl:if>/image/4/1200/1200<xsl:value-of select="@path" />/<xsl:value-of select="filename" /></xsl:attribute>
		
		<xsl:if test="../document/item">
			<xsl:attribute name="data-source-id"><xsl:value-of select="../document/item/@id" /></xsl:attribute>
		</xsl:if>
		
		<xsl:if test="../document-page">
			<xsl:attribute name="data-source-page"><xsl:value-of select="../document-page" /></xsl:attribute>
		</xsl:if>
		
	</img>
</xsl:template>

<!--Inline document (a single one)-->
<xsl:template match="p[starts-with(text(), '!document')]" mode="html" priority="1">
	<xsl:variable name="id">
		<xsl:value-of select="substring-after(text(), '!document ')" />
	</xsl:variable>
	
	<xsl:apply-templates select="/data/documents-inline/entry[@id = $id]">
		<xsl:with-param name="class" select="'inline-entry'" />
	</xsl:apply-templates>
</xsl:template>

<!--Multiple documents in a row can be shown using the 'documents' prefixes
-->
<xsl:template match="p[starts-with(text(), '!documents')]" mode="html" priority="1">
	<xsl:variable name="string">
		<xsl:value-of select="substring-after(text(), '!documents ')" />
	</xsl:variable>
	
	<div class="row">
		<xsl:call-template name="show-inline-docs">
			<xsl:with-param name="string" select="$string" />
		</xsl:call-template>
	</div>
</xsl:template>

<!--#This template is recursive, to allow multiple, space-separated doc IDs to be passed.
	#The displaying template will be called for each ID found in the string
-->
<xsl:template name="show-inline-docs">
	<xsl:param name="string" />
	
	<xsl:variable name="id">
		<xsl:value-of select="substring-before(concat($string,' '),' ')" />
	</xsl:variable>
	
	<xsl:apply-templates select="/data/documents-inline/entry[@id = $id]" />
	
	<xsl:if test="contains($string,' ')">
		<xsl:call-template name="show-inline-docs">
			<xsl:with-param name="string" select="substring-after($string,' ')" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template match="documents-inline/entry">
	<xsl:param name="class" select="'col-xs-6 col-md-4'" />
	
	<div class="{$class}">
		<a class="thumbnail">
			<xsl:attribute name="href">
				<xsl:if test="/data/params/page-types/item = 'XML'"><xsl:value-of select="/data/params/root" /></xsl:if>
				<xsl:apply-templates select="." mode="entry-url" />
			</xsl:attribute>
			<img alt="{name}">
				<xsl:attribute name="src">
					<xsl:if test="/data/params/page-types/item = 'XML'"><xsl:value-of select="/data/params/root" /></xsl:if>
					<xsl:text>/image/1/400/0/</xsl:text>
					<xsl:value-of select="cover-image/@path" />/<xsl:value-of select="cover-image/filename" />
				</xsl:attribute>
			</img>
			<div class="caption">
				<h4><xsl:value-of select="name" /></h4>
				<ul class="list-unstyled">
					<xsl:apply-templates select="organisation|publication" />
					<li>
						<span class="fas fa-calendar fa-fw"></span>&#160;
						<xsl:value-of select="year" />
					</li>
				</ul>
			</div>
		</a>
	</div>
</xsl:template>

<xsl:template match="documents-inline/entry/organisation|documents-inline/entry/publication">
	<li>
		<xsl:call-template name="section-icon">
			<xsl:with-param name="section" select="item/@section-handle" />
		</xsl:call-template>
		<xsl:apply-templates select="item" mode="entry-list" />
	</li>
</xsl:template>

</xsl:stylesheet>
