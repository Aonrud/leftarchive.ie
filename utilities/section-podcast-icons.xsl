<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:podcast="https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md"
    exclude-result-prefixes="dc podcast">

<!--Match podcast:id declarations in RSS/ATOM feed.
	These are repeated because call-template[name] can't be dynamic.
-->

<!--Fallback for unmatched platform-->
<xsl:template match="podcast:id/@platform">
	<xsl:param name="colour" select="'#000'" />
	<span class="fas fa-headphones" style="color: {$colour}"></span>
</xsl:template>
    
<xsl:template match="podcast:id/@platform[. = 'antennapod']">
	<xsl:param name="colour" select="'#000'" />
	<xsl:call-template name="icon-antennapod">
		<xsl:with-param name="colour" select="$colour" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="podcast:id/@platform[. = 'apple']">
	<xsl:param name="colour" select="'#000'" />
	<xsl:call-template name="icon-apple">
		<xsl:with-param name="colour" select="$colour" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="podcast:id/@platform[. = 'fyyd']">
	<xsl:param name="colour" select="'#000'" />
	<xsl:call-template name="icon-fyyd">
		<xsl:with-param name="colour" select="$colour" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="podcast:id/@platform[. = 'playerfm']">
	<xsl:param name="colour" select="'#000'" />
	<xsl:call-template name="icon-playerfm">
		<xsl:with-param name="colour" select="$colour" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="podcast:id/@platform[. = 'pocketcasts']">
	<xsl:param name="colour" select="'#000'" />
	<xsl:call-template name="icon-pocketcasts">
		<xsl:with-param name="colour" select="$colour" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="podcast:id/@platform[. = 'podcastindex']">
	<xsl:param name="colour" select="'#000'" />
	<xsl:call-template name="icon-podcastindex">
		<xsl:with-param name="colour" select="$colour" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="podcast:id/@platform[. = 'spotify']">
	<xsl:param name="colour" select="'#000'" />
	<xsl:call-template name="icon-spotify">
		<xsl:with-param name="colour" select="$colour" />
	</xsl:call-template>
</xsl:template>
    
<!--These templates return SVG for podcast-related icons. They are taken directly from Castopod (https://code.castopod.org/adaures/castopod)-->
    
<xsl:template name="icon-antennapod">
	<xsl:param name="colour" select="'#000'" />
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="icon">
		<path d="M0,0H24V24H0Z" fill="none" />
		<path d="M12.06,2.52A8.55,8.55,0,0,0,4.82,6.4,9.93,9.93,0,0,0,3.69,9a8.64,8.64,0,0,0,2.69,8.59,10.55,10.55,0,0,0,1,.73,3.82,3.82,0,0,0,.24-.61c.12-.34.21-.64.21-.66a1.08,1.08,0,0,0-.21-.19,8.14,8.14,0,0,1-1.2-1.16,7.2,7.2,0,0,1-1.62-4.61A7,7,0,0,1,5.5,7.88a7.23,7.23,0,0,1,5.49-4,8.62,8.62,0,0,1,2,0,7.27,7.27,0,0,1,6.17,6.17,9.1,9.1,0,0,1,0,1.88,7.35,7.35,0,0,1-1.62,3.76,9.94,9.94,0,0,1-1.14,1.11,1.31,1.31,0,0,0-.23.21s.1.31.22.64l.22.61.26-.17a8.18,8.18,0,0,0,1.14-1,8,8,0,0,0,1.62-2.25,8.58,8.58,0,0,0,.69-5.71A8.4,8.4,0,0,0,18.12,5.1a8.39,8.39,0,0,0-6.06-2.58ZM12,5.83a4.59,4.59,0,0,0-1.64.25A5.52,5.52,0,0,0,7.54,8.26a6.34,6.34,0,0,0-.74,1.93,7.2,7.2,0,0,0,0,1.67,5.44,5.44,0,0,0,1,2.39,5.31,5.31,0,0,0,.71.77,6.13,6.13,0,0,0,.26-.65c.12-.36.23-.67.23-.69a1.41,1.41,0,0,0-.17-.26,3.84,3.84,0,0,1-.75-2.36,3.68,3.68,0,0,1,.52-2,3.95,3.95,0,0,1,7,3.7,3.51,3.51,0,0,1-.36.61l-.19.26.17.44c.09.24.19.54.24.67a.74.74,0,0,0,.1.23,6.13,6.13,0,0,0,.8-.89,5.44,5.44,0,0,0,.85-2,5.14,5.14,0,0,0-.4-3.33,4.74,4.74,0,0,0-1-1.47,5.07,5.07,0,0,0-2.08-1.29A4.51,4.51,0,0,0,12,5.83Zm0,3.28a1.93,1.93,0,0,0-1.38.59A1.84,1.84,0,0,0,10,11.2a1.92,1.92,0,0,0,.44,1.14l.15.19-.11.3c0,.16-.49,1.4-1,2.75S8.36,18.92,8,20s-.64,1.8-.7,1.95a12.15,12.15,0,0,0,1.57.55L9,22c.1-.27.34-1,.55-1.55l.37-1H10l.55.1a6.71,6.71,0,0,0,1.43.08,6.43,6.43,0,0,0,1.41-.08l.54-.1.1,0L14.62,21c.27.78.5,1.44.53,1.54A12.34,12.34,0,0,0,16.73,22h0S16,19.89,15.1,17.39l-1.66-4.7-.06-.16.17-.22a2,2,0,0,0,.22-2.12,2.32,2.32,0,0,0-.87-.86A2,2,0,0,0,12,9.11Zm0,4.51s1.5,4.12,1.51,4.21a7.6,7.6,0,0,1-2.09.16,5.39,5.39,0,0,1-.9-.15S12,13.67,12,13.62Z" fill-opacity="0.88" fill="{$colour}" />
	</svg>
</xsl:template>

<xsl:template name="icon-apple">
	<xsl:param name="colour" select="'#000'" />
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="icon">
		<path d="M0,0H24V24H0Z" fill="none" />
		<path d="M11.36,22.27c-.77-.28-.94-.65-1.25-2.84-.37-2.54-.45-4.11-.23-4.61a2.11,2.11,0,0,1,2.11-1,2.09,2.09,0,0,1,2.12,1c.21.5.13,2.07-.24,4.61-.24,1.78-.38,2.23-.72,2.53a1.78,1.78,0,0,1-1.78.31ZM8.08,19.66a9,9,0,0,1-5-6.45,11.9,11.9,0,0,1,0-3.26A9.05,9.05,0,0,1,5.43,5.33,9,9,0,0,1,18.5,5.26,8.83,8.83,0,0,1,20.92,10a12.6,12.6,0,0,1,0,3.07,9.08,9.08,0,0,1-3.47,5.68A10.5,10.5,0,0,1,15,20.08c-.09,0-.1-.1-.06-.5.08-.63.16-.76.52-.92a8.2,8.2,0,0,0,4.31-5.33,10.13,10.13,0,0,0-.06-3.76,8,8,0,0,0-6-5.74,9.67,9.67,0,0,0-3.22,0A8.06,8.06,0,0,0,4.33,9.76a10.76,10.76,0,0,0,0,3.58,8.27,8.27,0,0,0,3.42,4.84,7,7,0,0,0,.89.5c.36.16.43.29.5.92,0,.39,0,.5-.06.5a6.76,6.76,0,0,1-1-.41Zm0-3.49A6.54,6.54,0,0,1,6.1,13a7.36,7.36,0,0,1,0-2.92A6.3,6.3,0,0,1,10.2,5.72a7.57,7.57,0,0,1,3.13-.12A6.12,6.12,0,0,1,18,12.23a6,6,0,0,1-1.3,3.09,5.44,5.44,0,0,1-1.39,1.23,2.06,2.06,0,0,1-.05-.65v-.64l.44-.54a4.87,4.87,0,0,0-.27-6.67,4.66,4.66,0,0,0-2.6-1.34,3.25,3.25,0,0,0-1.55,0A4.71,4.71,0,0,0,8.6,8.05a4.88,4.88,0,0,0-.28,6.67l.44.54v.65a1.9,1.9,0,0,1-.06.65,3,3,0,0,1-.55-.39Zm3-3.51a2,2,0,0,1-1.19-1.9,2.1,2.1,0,0,1,1.2-1.87,2.28,2.28,0,0,1,1.81,0A2.35,2.35,0,0,1,14,10.25a2.08,2.08,0,0,1-2.91,2.41Z" fill="{$colour}" />
	</svg>
</xsl:template>

<xsl:template name="icon-fyyd">
	<xsl:param name="colour" select="'#000'" />
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="icon">
    <path d="M0,0H24V24H0Z" fill="none" />
    <path d="M2,12A10,10,0,1,1,12,22,10,10,0,0,1,2,12Zm8.16,6.5a.85.85,0,0,0,1.18,0l5.91-5.91a.83.83,0,0,0,0-1.17L11.34,5.5a.85.85,0,0,0-1.18,0L8.84,6.83A.82.82,0,0,0,8.84,8l4,4-4,4a.82.82,0,0,0,0,1.17Z" fill-rule="evenodd" fill="{$colour}" />
</svg>
</xsl:template>

<xsl:template name="icon-playerfm">
	<xsl:param name="colour" select="'#000'" />
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="icon">
		<path d="M0,0H24V24H0Z" fill="none" />
		<path d="M11.4,22A9.4,9.4,0,0,1,9.17,3.48,2,2,0,0,1,11.62,5a2,2,0,0,1-1.5,2.44A5.37,5.37,0,0,0,11.4,18h0a5.36,5.36,0,0,0,5.23-4.12,2,2,0,0,1,3.95.95A9.47,9.47,0,0,1,11.4,22Zm9.74-11.24a.84.84,0,0,1-.84-.61,10.1,10.1,0,0,0-6.4-6.51A.84.84,0,1,1,14.36,2h.05A11.81,11.81,0,0,1,22,9.66a.86.86,0,0,1-.56,1.06A.5.5,0,0,1,21.14,10.77Zm-2.78.56a.85.85,0,0,1-.84-.61,7.38,7.38,0,0,0-4.17-4.34.85.85,0,0,1,.51-1.62,8.61,8.61,0,0,1,5.28,5.45.86.86,0,0,1-.56,1.06C18.52,11.27,18.41,11.33,18.36,11.33Zm-2.84.33a.82.82,0,0,1-.78-.5,4.61,4.61,0,0,0-2-2.06.87.87,0,1,1,.78-1.56h0a6.77,6.77,0,0,1,2.78,2.9A.8.8,0,0,1,16,11.53l0,0A.76.76,0,0,1,15.52,11.66Z" fill="{$colour}" />
	</svg>
</xsl:template>

<xsl:template name="icon-pocketcasts">
	<xsl:param name="colour" select="'#000'" />
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
		<path d="M0,0H24V24H0Z" fill="none" />
		<path d="M2,12a10,10,0,0,1,20,0H19.5A7.5,7.5,0,1,0,12,19.5V22A10,10,0,0,1,2,12Zm10,6a6,6,0,1,1,6-6H15.83A3.83,3.83,0,1,0,12,15.83h0Z" fill-rule="evenodd" />
	</svg>
</xsl:template>

<xsl:template name="icon-podcastindex">
	<xsl:param name="colour" select="'#000'" />
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="icon">
		<path d="M0 0h24v24H0Z" fill="none" />
		<path d="M7.53 12.59a5 5 0 0 1 0-7.36 1 1 0 0 1 1.35 1.45 3 3 0 0 0 0 4.48 1 1 0 0 1 0 1.39 1 1 0 0 1-1.35.04ZM6.83 14A.89.89 0 0 1 7 15.42a.92.92 0 0 1-.8.39 1.42 1.42 0 0 1-.6-.2 8.88 8.88 0 0 1-3.39-6.7A7.92 7.92 0 0 1 5.63 2.2 1 1 0 0 1 7 2.4a1 1 0 0 1-.2 1.38 6.23 6.23 0 0 0-2.56 5.13A6.34 6.34 0 0 0 6.83 14Zm8.23-1.48a1 1 0 0 1 0-1.4 3 3 0 0 0 0-4.48 1 1 0 0 1 0-1.39 1 1 0 0 1 1.41 0 5 5 0 0 1 0 7.36 1 1 0 0 1-1.41-.06ZM18.37 2.2a7.94 7.94 0 0 1 3.39 6.71 8.29 8.29 0 0 1-3.39 6.7 1.42 1.42 0 0 1-.6.2.92.92 0 0 1-.8-.39.89.89 0 0 1 .2-1.39 6.34 6.34 0 0 0 2.59-5.12 6.23 6.23 0 0 0-2.59-5.13A1 1 0 0 1 17 2.4a1 1 0 0 1 1.37-.2Zm-4.23 6.7a2.14 2.14 0 1 0-3.29 1.81L8.43 22h2.1l2.4-11.17a2.14 2.14 0 0 0 1.21-1.93Z" fill="{$colour}" />
	</svg>
</xsl:template>

<xsl:template name="icon-rss">
	<xsl:param name="colour" select="'#000'" />
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="icon">
		<g>
			<path fill="none" d="M0 0h24v24H0z"/>
			<path d="M3 3c9.941 0 18 8.059 18 18h-3c0-8.284-6.716-15-15-15V3zm0 7c6.075 0 11 4.925 11 11h-3a8 8 0 0 0-8-8v-3zm0 7a4 4 0 0 1 4 4H3v-4z" fill="{$colour}" />
		</g>
	</svg>
</xsl:template>

<xsl:template name="icon-spotify">
	<xsl:param name="colour" select="'#000'" />
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="icon">
		<path d="M0,0H24V24H0Z" fill="none" />
		<path d="M17.91,10.87C14.69,9,9.37,8.77,6.3,9.71a.93.93,0,1,1-.54-1.79c3.53-1.08,9.4-.87,13.11,1.34a.93.93,0,1,1-1,1.6h0Zm-.1,2.83a.78.78,0,0,1-1.07.26h0a13.14,13.14,0,0,0-10-1.17.78.78,0,0,1-1-.49.79.79,0,0,1,.5-1h0a14.58,14.58,0,0,1,11.23,1.33.78.78,0,0,1,.26,1.07Zm-1.22,2.72a.63.63,0,0,1-.86.21h0c-2.35-1.44-5.3-1.76-8.79-1a.62.62,0,0,1-.27-1.21c3.81-.87,7.07-.5,9.71,1.11a.63.63,0,0,1,.21.86ZM12,2A10,10,0,1,0,22,12,10,10,0,0,0,12,2Z" fill="{$colour}" />
	</svg>
</xsl:template>
    
</xsl:stylesheet>
