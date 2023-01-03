<!-- <?xml version="1.0" encoding="UTF-8"?> -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns:content="http://purl.org/rss/1.0/modules/content/"
	xmlns:media="http://search.yahoo.com/mrss/"
	xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
	xmlns:googleplay="http://www.google.com/schemas/play-podcasts/1.0"
>

<xsl:import href="../utilities/general-html.xsl"/>
<xsl:import href="../utilities/entry.xsl" />
<xsl:import href="../utilities/general-datetime.xsl"/>
<xsl:import href="../utilities/section-podcast.xsl" />

<xsl:output method="xml" encoding="UTF-8" indent="yes" />

<xsl:template match="/">
	<rss version="2.0">
		<channel>
			<title>Irish Left Archive Podcast<xsl:if test="/data/params/format = 'ogg'"> (Ogg Audio Format)</xsl:if></title>
			<link><xsl:value-of select="$root" />/podcast/</link>
			
			<!--Looking at Apple's spec (https://help.apple.com/itc/podcasts_connect/#/itcb54353390) the common itunes:summary tag must be deprecated.  No reason to specify additional closed company tags as all should read description.-->
			<description><xsl:call-template name="podcast-description" /></description>
			
			<itunes:author>Irish Left Archive</itunes:author>
			
			<itunes:category text="News">
				<itunes:category text="Politics" />
			</itunes:category>
			<itunes:category text="History" />
			<googleplay:category text="News &amp; Politics"/>
			
			<!--Brilliantly, the validator and Googleplay's spec say this should be yes/no. Apple say it should be true/false...
				We'll see who wins...-->
			<itunes:explicit>false</itunes:explicit>
			
			<itunes:owner>
				<itunes:name>Irish Left Archive</itunes:name>
				<itunes:email>contact@leftarchive.ie</itunes:email>
			</itunes:owner>
			
			<copyright>&#169; Irish Left Archive <xsl:value-of select="/data/params/this-year" /></copyright>
			<atom:link href="{/data/params/current-url}/" rel="self" type="application/rss+xml" />
			<language>en</language>
			<image>
				<title>Irish Left Archive Podcast</title>
				<link><xsl:value-of select="/data/params/root" />/podcast/</link>
				<url><xsl:value-of select="$podcast-image-absolute" /></url>
			</image>
			<itunes:image href="{$podcast-image-absolute}" />
			
			<xsl:apply-templates select="/data/podcast-feed/entry">
				<xsl:sort select="date" order="descending" />
			</xsl:apply-templates>

		</channel>
	</rss>
</xsl:template>

<xsl:template match="podcast-feed/entry">
	<xsl:variable name="ep-link"><xsl:value-of select="$root" />/podcast/<xsl:value-of select="url" />/</xsl:variable>
	
	<item>
		<title><xsl:value-of select="name" /></title>
		<itunes:episode><xsl:value-of select="episode" /></itunes:episode>
		<guid isPermaLink="false"><xsl:value-of select="/data/params/root" />/podcast/?<xsl:value-of select="@id" /></guid>
		<pubDate>
            <xsl:call-template name="format-date">
                <xsl:with-param name="date" select="date"/>
                <xsl:with-param name="format" select="'w, d m Y T'"/>
            </xsl:call-template>
            <xsl:text>:00 </xsl:text>
            <xsl:value-of select="translate($timezone,':','')"/>
        </pubDate>
		<link><xsl:value-of select="$ep-link" /></link>
		<description>
			<xsl:value-of select="description" />
		</description>
		
		<content:encoded>
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
			<xsl:apply-templates select="notes/*" mode="html" />
			<hr />
			<p><xsl:call-template name="podcast-description-short" /></p>
			<p>View this episode on our website: <a href="{$ep-link}">#<xsl:value-of select="episode" />: <xsl:value-of select="name" /></a>.</p>
			<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
		</content:encoded>
		
		<xsl:apply-templates select="image" />
		
		<xsl:choose>
			<xsl:when test="/data/params/format = 'ogg'">
				<enclosure url="https://dts.podtrac.com/redirect.ogg/{/data/params/http-host}{/data/params/workspace-path}{ogg/@path}/{ogg/filename}" length="{ogg/@bytes}" type="{ogg/@type}" />
			</xsl:when>
			<xsl:otherwise>
				<enclosure url="https://dts.podtrac.com/redirect.mp3/{/data/params/http-host}{/data/params/workspace-path}{mp3/@path}/{mp3/filename}" length="{mp3/@bytes}" type="audio/mpeg" />
			</xsl:otherwise>
		</xsl:choose>
		
		<itunes:duration><xsl:value-of select="duration" /></itunes:duration>
	</item>
</xsl:template>

<xsl:template match="podcast-feed/entry/image">
	<itunes:image href="{/data/params/root}/image/0{@path}/{filename}" />
</xsl:template>

<!--Over-ride inline elements to just include a link-->
<xsl:template match="p[starts-with(text(), '!documents')]" mode="html" priority="1">
	<xsl:variable name="string">
		<xsl:value-of select="substring-after(text(), '!documents ')" />
	</xsl:variable>
	
	<ul>
		<xsl:call-template name="show-inline-docs">
			<xsl:with-param name="string" select="$string" />
		</xsl:call-template>
	</ul>
</xsl:template>

<xsl:template match="documents-inline/entry">
	<li>
		<a title="{name}">
			<xsl:attribute name="href">
				<xsl:apply-templates select="." mode="entry-url">
					<xsl:with-param name="absolute" select="'Yes'" />
				</xsl:apply-templates>
			</xsl:attribute>
			<xsl:value-of select="name" />
		</a>
	</li>
</xsl:template>

<!--Override un-necessary modification of anchors. 'External' classes etc. not relevant for RSS feed.-->
<xsl:template match="a" priority="1" mode="html">
    <xsl:element name="a">
        <xsl:attribute name="href">
            <!--Change to absolute URLs for XML page type (RSS feeds should have abs. URLs).
				Not foolproof, but a URL shouldn't have //, except after the protocol.
            -->
            <xsl:if test="not(contains(@href,'//')) and /data/params/page-types/item = 'XML'"><xsl:value-of select="$root" /></xsl:if>
            <xsl:value-of select="@href" />
        </xsl:attribute>
        <xsl:apply-templates select="* | text()" mode="html" />
	</xsl:element>
</xsl:template>

</xsl:stylesheet>
