<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<xsl:import href="general-strings.xsl"/>

<!--Over-ride this template at page level to set the metadata image-->
<xsl:template name="metadata-image">
	<xsl:call-template name="metadata-image-default" />
</xsl:template>

<xsl:template name="metadata-image-default">
	<meta property="og:image" content="{/data/params/workspace}/assets/images/icons/ILA_400.png" />
	<meta property="og:image:width" content="400" />
	<meta property="og:image:height" content="400" />
	<meta property="og:image:alt" content="Irish Left Archive logo" />
</xsl:template>

<!--OVer-ride this variable at page level to use e.g. summary_large_image-->
<xsl:variable name="metadata-twitter-card">summary</xsl:variable>

<!--Use this template to use the unprocessed image as the meta image-->
<xsl:template match="*" mode="metadata-image-raw">
	<xsl:param name="alt" select="''" />

	<meta property="og:image" content="{$root}/image/0{@path}/{filename}" />
	<meta property="og:image:width" content="{meta/@width}" />
	<meta property="og:image:height" content="{meta/@height}" />
	<xsl:if test="$alt != ''">
		<meta property="og:image:alt" content="{$alt}" />
	</xsl:if>
</xsl:template>

<!--Use this template to scale the metadata image within given square.
-->
<xsl:template match="*" mode="metadata-image-scale">
	<xsl:param name="size" select="'1600'" />
	<xsl:param name="alt" select="''" />

	<meta property="og:image" content="{$root}/image/4/{$size}/{$size}{@path}/{filename}" />
	
	<xsl:variable name="scaled">
		<xsl:value-of select="boolean((meta/@width &gt; $size) or (meta/@height &gt; $size))" />
	</xsl:variable>
	
	<xsl:choose>
		<xsl:when test="($scaled = 'true') and (meta/@width &gt; meta/@height)">
			<meta property="og:image:width" content="{$size}" />
			<meta property="og:image:height" content="{round(($size div meta/@width) * meta/@height)}" />
		</xsl:when>
		<xsl:when test="($scaled = 'true') and (meta/@width &lt;= meta/@height)">
			<meta property="og:image:width" content="{round(($size div meta/@height) * meta/@width)}" />
			<meta property="og:image:height" content="{$size}" />
		</xsl:when>
		<xsl:otherwise>
			<meta property="og:image:width" content="{meta/@width}" />
			<meta property="og:image:height" content="{meta/@height}" />
		</xsl:otherwise>
	</xsl:choose>

	<xsl:if test="$alt != ''">
		<meta property="og:image:alt" content="{$alt}" />
	</xsl:if>

</xsl:template>

<!--#Use this template to set a metadata-image depending on the image dimensions.
	#Returns the full path to the generated image.
-->
<xsl:template match="*" mode="metadata-image-ratio">
	<xsl:param name="bg-colour" select="'555'" />
	<xsl:param name="portrait-only" select="'No'" />
	<xsl:param name="alt" select="''" />
	<xsl:param name="ratio" select="'1.91'" />
	
	<xsl:variable name="width">
		<xsl:choose>
			<xsl:when test="meta/@width div $ratio &lt;= meta/@height">
				<xsl:value-of select="floor(meta/@height * $ratio)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="meta/@width" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="height">
		<xsl:choose>
			<xsl:when test="meta/@width div $ratio &gt; meta/@height">
				<xsl:value-of select="floor(meta/@width div $ratio)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="meta/@height" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="jit-process">
		<xsl:choose>
			<xsl:when test="meta/@width &lt; meta/@height or $portrait-only = 'No'">
				<xsl:text>/image/3/</xsl:text>
				<xsl:value-of select="$width" />
				<xsl:text>/</xsl:text>
				<xsl:value-of select="$height" />
				<xsl:text>/5/</xsl:text>
				<xsl:value-of select="$bg-colour" />
			</xsl:when>
			<xsl:otherwise>/image/0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	
	<meta property="og:image">
		<xsl:attribute name="content">
			<xsl:value-of select="/data/params/root" />
			<xsl:value-of select="$jit-process" />
			<xsl:value-of select="@path" />
			<xsl:text>/</xsl:text>
			<xsl:value-of select="filename" />
		</xsl:attribute>
	</meta>
	<meta property="og:image:width" content="{$width}" />
	<meta property="og:image:height" content="{$height}" />
	<xsl:if test="$alt != ''">
		<meta property="og:image:alt" content="{$alt}" />
	</xsl:if>
</xsl:template>

<xsl:template name="metadata-site-ldjson">
	<!--Put general site data in header of all pages.
    Use LD-JSON, because bloody OG and Twitter break schema.org-->
	<script type="application/ld+json">
	<xsl:text disable-output-escaping="yes" >
	<![CDATA[
	{
		"@context": "http://schema.org/",
		"@type": "WebSite",
		"url": "https://www.leftarchive.ie/",
		"name": "Irish Left Archive",
		"thumbnailUrl": "]]></xsl:text><xsl:value-of select="/data/params/workspace" /><xsl:text disable-output-escaping="yes" ><![CDATA[/assets/images/icons/ILA_400.png",
		"potentialAction": {
			"@type": "SearchAction",
			"target": "https://www.leftarchive.ie/search/?keywords={keywords}",
			"query-input": "required name=keywords"
		}
	}
	]]>
	</xsl:text>
	</script>
</xsl:template>

<!--This is set on the individual page level. Empty template included here to avoid missing template issues.-->
<xsl:template name="metadata-general">
	<xsl:text></xsl:text>
</xsl:template>

<xsl:template name="metadata-sm-shared">
	<meta property="og:site_name" content="Irish Left Archive" />
	<meta property="twitter:site" content="@IELeftArchive" />
	<meta property="twitter:creator" content="@IELeftArchive" />
	<meta property="twitter:card" content="{$metadata-twitter-card}" />
	<xsl:call-template name="metadata-image" />
</xsl:template>

</xsl:stylesheet>
