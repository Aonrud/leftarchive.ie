<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
	xmlns:podcast="https://podcastindex.org/namespace/1.0"
	exclude-result-prefixes="atom itunes podcast">
	
<xsl:import href="section-podcast-icons.xsl"/>

<xsl:variable name="podcast-image">/assets/images/ila-podcast.jpg</xsl:variable>
<xsl:variable name="podcast-image-absolute"><xsl:value-of select="/data/params/root" />/image/0<xsl:value-of select="$podcast-image" /></xsl:variable>

<xsl:variable name="podcast-tagline">
	Exploring Left politics in Ireland past and present
</xsl:variable>

<xsl:template name="podcast-disclaimer">
	The Irish Left Archive Podcast aims to hear from a broad range of voices on the Left. We are not affiliated with any particular political organisation, and the views, information, or opinions expressed by guests are solely their own and do not necessarily represent those of the Irish Left Archive or those associated with it.
</xsl:template>

<xsl:template match="rss/channel" mode="aside">
	<xsl:param name="current" />
	<xsl:param name="max-episodes" select="'3'" />
    <xsl:param name="listen-button" select="'Yes'" />
    <xsl:param name="footer" select="'Yes'" />
    
    <div class="panel panel-success">
		<div class="panel-heading"><h3 class="panel-title"><span class="fas fa-microphone-alt"></span>&#160;<a href="/podcast/">Irish Left Archive Podcast</a></h3></div>

		<div class="panel-body">
			<a href="/podcast/" title="Irish Left Archive Podcast"><img src="/image/1/500/0{$podcast-image}" alt="Irish Left Archive Podcast" class="img-responsive" /></a>
			<p><xsl:value-of select="$podcast-tagline" /></p>
			<xsl:if test="$listen-button = 'Yes'">
                <div class="text-center">
                    <a class="btn btn-success" href="/podcast/">Listen and subscribe <span class="fas fa-arrow-right"></span></a>
                </div>
            </xsl:if>
		</div>
		
		<div class="list-group">
			<xsl:apply-templates select="item[position() &lt;= $max-episodes]" mode="aside">
				<xsl:with-param name="current" select="$current" />
			</xsl:apply-templates>
		</div>
		
		<xsl:if test="$footer = 'Yes'">
            <div class="panel-footer text-center">
                <a href="/podcast/" title="Irish Left Archive Podcast" class="btn btn-primary">All Episodes <span class="fas fa-arrow-right"></span></a>
            </div>
        </xsl:if>
	</div>
</xsl:template>

<xsl:template match="rss/channel/item" mode="aside">
	<xsl:param name="current" />
	<a class="list-group-item" href="/podcast/episode/{itunes:episode}/">
		<xsl:if test="$current = itunes:episode">
			<xsl:attribute name="class">list-group-item list-group-item-info</xsl:attribute>
		</xsl:if>
		<p class="text-muted"><span class="fas fa-fw fa-play"></span>&#160;Episode <xsl:value-of select="itunes:episode" /></p>
		<h5><xsl:value-of select="title" /></h5>
		<div class="text-muted text-right small">
			<span class="fas fa-calendar"></span>&#160;
			<xsl:value-of select="substring(pubDate, 1, string-length(substring-before(pubDate, ':')) - 3)" />
		</div>
	</a>
</xsl:template>

<xsl:template match="rss/channel" mode="icons">
	<xsl:param name="colour" select="'#333'" />
	<ul class="list-inline">
		<li>
			<a href="{atom:link[@rel='self']/@href}" title="Podcast RSS feed" class="alert-link" property="schema:webFeed">
				<xsl:call-template name="icon-rss">
					<xsl:with-param name="colour" select="$colour" />
				</xsl:call-template>
			</a>
		</li>
		<xsl:apply-templates select="podcast:id[@platform = 'antennapod' or @platform = 'apple' or @platform = 'fyyd' or @platform = 'pocketcasts' or @platform = 'podcastindex' or @platform = 'spotify']">
			<xsl:with-param name="colour" select="$colour" />
		</xsl:apply-templates>
	</ul>
</xsl:template>

<!--Link to podcast platform with icon from section-podcast-icons.xsl-->
<xsl:template match="podcast:id">
	<xsl:param name="colour" select="'#333'" />
	<li>
		<a href="{@url}" class="alert-link">
			<xsl:attribute name="title">
				<xsl:text>Listen on </xsl:text>
				<xsl:call-template name="initial">
					<xsl:with-param name="string" select="@platform" />
				</xsl:call-template>
			</xsl:attribute>
			<xsl:apply-templates select="@platform">
				<xsl:with-param name="colour" select="$colour" />
			</xsl:apply-templates>
		</a>
	</li>
</xsl:template>

<xsl:template match="channel/item" mode="meta">
	<ul class="list-inline text-muted">
		<li property="schema:datePublished" content="{pubDate}">
			<span class="fas fa-calendar"></span>&#160;
			<xsl:value-of select="substring(pubDate, 1, string-length(substring-before(pubDate, ':')) - 3)" />
		</li>
		<li property="schema:duration">
			<xsl:attribute name="content">
				<xsl:apply-templates select="itunes:duration" mode="iso8601" />
			</xsl:attribute>
			<span class="fas fa-hourglass-start"></span>&#160;<xsl:apply-templates select="itunes:duration" />
		</li>
	</ul>
</xsl:template>

<!--Note - rounds to nearest minute and outputs in format e.g. "1 hr 12 mins" -->
<xsl:template match="itunes:duration">
	<xsl:variable name="hours"><xsl:value-of select="floor(number(.) div 3600)" /></xsl:variable>
	<xsl:variable name="mins"><xsl:value-of select="round(number(.) div 60) - ($hours * 60)" /></xsl:variable>
	
	<xsl:if test="$hours != 0"><xsl:value-of select="$hours" /> hr<xsl:if test="$hours &gt; 1">s</xsl:if>&#160;</xsl:if>
	<xsl:value-of select="format-number($mins,'00')" /> min<xsl:if test="$mins &gt; 1">s</xsl:if>
</xsl:template>

<xsl:template match="itunes:duration" mode="iso8601">
	<xsl:variable name="hours"><xsl:value-of select="floor(number(.) div 3600)" /></xsl:variable>
	<xsl:variable name="mins"><xsl:value-of select="floor(number(.) div 60) - ($hours * 60)" /></xsl:variable>
	<xsl:variable name="secs"><xsl:value-of select="number(.) mod 60" /></xsl:variable>
	
	<xsl:text>PT</xsl:text>
	<xsl:if test="$hours != 0"><xsl:value-of select="$hours" />H</xsl:if>
	<xsl:value-of select="$mins" /><xsl:text>M</xsl:text>
	<xsl:value-of select="$secs" /><xsl:text>S</xsl:text>
</xsl:template>

</xsl:stylesheet>
