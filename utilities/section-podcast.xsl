<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="podcast-image">/assets/images/ila-podcast.jpg</xsl:variable>
<xsl:variable name="podcast-image-absolute"><xsl:value-of select="/data/params/root" />/image/0<xsl:value-of select="$podcast-image" /></xsl:variable>

<xsl:variable name="podcast-tagline">
	Exploring Left politics in Ireland past and present
</xsl:variable>

<xsl:template name="podcast-description-html">
	<p>
	A podcast looking at Left politics in Ireland from the Irish Left Archive.
	</p><p>
	We talk to activists, writers, historians, politicians and others involved in Left organisations and movements about their experiences of participating in Left parties and campaigns; Left publications and political documents they've been involved in; and the history and development of progressive politics in Ireland. We also look at the role of the Irish Left Archive and similar informal projects.
	</p><p>
	The podcast is hosted by Ciarán Swan and Aonghus Storey.
	</p>
</xsl:template>

<xsl:template name="podcast-description">
	A podcast looking at Left politics in Ireland from the Irish Left Archive.
	
	We talk to activists, writers, historians, politicians and others involved in Left organisations and movements about their experiences of participating in Left parties and campaigns; Left publications and political documents they've been involved in; and the history and development of progressive politics in Ireland. We also look at the role of the Irish Left Archive and similar informal projects.
	
	The podcast is hosted by Ciarán Swan and Aonghus Storey.
</xsl:template>

<xsl:template name="podcast-disclaimer">
	The Irish Left Archive Podcast aims to hear from a broad range of voices on the Left. We are not affiliated with any particular political organisation, and the views, information, or opinions expressed by guests are solely their own and do not necessarily represent those of the Irish Left Archive or those associated with it.
</xsl:template>

<!--Used for very short footer description in RSS feed episode notes-->
<xsl:template name="podcast-description-short">
	The Irish Left Archive Podcast looks at Left politics in Ireland, talking to activists, writers, historians, politicians and others involved in Left organisations and movements about their experiences of participating in Left parties and campaigns. The podcast is hosted by Ciarán Swan and Aonghus Storey.
</xsl:template>

<xsl:template match="entry" mode="podcast-image-url">
	<xsl:choose>
		<xsl:when test="image"><xsl:value-of select="image/@path" />/<xsl:value-of select="image/filename" /></xsl:when>
		<xsl:otherwise><xsl:value-of select="$podcast-image" /></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--Related podcast episode(s)-->
<xsl:template match="podcast-related">
	<h2>Podcast Episode<xsl:if test="count(entry) > 1">s</xsl:if></h2>
	<ul class="media-list">
		<xsl:apply-templates select="entry" />
	</ul>
</xsl:template>

<!--List version, for podcast page (and dynamic page for insertion)-->
<xsl:template match="podcast-related/entry|podcast-list/entry">
	<li class="media" typeof="schema:PodcastEpisode" resource="/podcast/{url}/#episode">
		<span property="schema:isPartOf" content="#podcast" />
		<div class="media-left">
			<a href="/podcast/{url}/">
				<img alt="Episode {episode}: {name}" class="bordered">
					<xsl:attribute name="src">/image/1/150/0<xsl:apply-templates select="." mode="podcast-image-url" /></xsl:attribute>
				</img>
			</a>
		</div>
		<div class="media-body">
			<span class="hidden"><xsl:value-of select="name(..)" /></span>
			<xsl:choose>
				<xsl:when test="name(..) = 'podcast-related'">
					<h3 class="media-heading" property="schema:name"><a href="/podcast/{url}/"><xsl:value-of select="episode" />: <xsl:value-of select="name" /></a></h3>
				</xsl:when>
				<xsl:otherwise>
					<h2 class="media-heading" property="schema:name"><a href="/podcast/{url}/"><xsl:value-of select="episode" />: <xsl:value-of select="name" /></a></h2>
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:apply-templates select="." mode="meta" />
			
			<span property="schema:episodeNumber" content="{episode}" />
			<p property="schema:description">
				<xsl:value-of select="description" />
			</p>
			<a href="/podcast/{url}/" class="btn btn-success">Listen or download <span class="fas fa-arrow-right"></span></a>
		</div>
	</li>
</xsl:template>

<xsl:template match="podcast-list" mode="aside">
    
    <xsl:param name="max-episodes" select="'5'" />
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
			<xsl:apply-templates select="entry[position() &lt;= $max-episodes]" mode="aside" />
		</div>
		
		<xsl:if test="$footer = 'Yes'">
            <div class="panel-footer text-center">
                <a href="/podcast/" title="Irish Left Archive Podcast" class="btn btn-primary">All Episodes <span class="fas fa-arrow-right"></span></a>
            </div>
        </xsl:if>
	</div>
</xsl:template>

<xsl:template match="podcast-list/entry" mode="aside">
	<a class="list-group-item" href="/podcast/{url}/">
		<xsl:if test="name = /data/podcast-single/entry/name">
			<xsl:attribute name="class">list-group-item list-group-item-info</xsl:attribute>
		</xsl:if>
		<p class="text-muted"><span class="fas fa-fw fa-play"></span>&#160;Episode <xsl:value-of select="episode" /></p>
		<h5><xsl:value-of select="name" /></h5>
		<div class="text-muted text-right small">
			<span class="fas fa-calendar"></span>&#160;
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="date/@iso"/><xsl:with-param name="format" select="'D M Y'"/>
			</xsl:call-template>
		</div>
	</a>
</xsl:template>

<!--Re-usable metadata header inline list-->
<xsl:template match="entry[../section/@handle = 'podcast']" mode="meta">
	<ul class="list-inline text-muted">
		<li property="schema:datePublished" content="{date/@iso}">
			<span class="fas fa-calendar"></span>&#160;
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="date/@iso"/><xsl:with-param name="format" select="'D M Y'"/>
			</xsl:call-template>
		</li>
		<li property="schema:duration">
			<xsl:attribute name="content">
				<xsl:apply-templates select="duration" mode="iso8601" />
			</xsl:attribute>
			<span class="fas fa-hourglass-start"></span>&#160;
			<xsl:apply-templates select="duration" />
		</li>
	</ul>
</xsl:template>

<xsl:template match="/data/podcast-inline/entry">
	<figure class="inline-entry">
		<a class="thumbnail" title="Listen to episode {episode} of the Irish Left Archive podcast">
			<xsl:attribute name="href">
				<xsl:if test="/data/params/page-types/item = 'XML'"><xsl:value-of select="/data/params/root" /></xsl:if>
				<xsl:apply-templates select="." mode="entry-url" />
			</xsl:attribute>
			<img alt="{name}">
				<xsl:attribute name="src">
					<xsl:if test="/data/params/page-types/item = 'XML'"><xsl:value-of select="/data/params/root" /></xsl:if>
					<xsl:text>/image/1/400/0/</xsl:text>
					<xsl:value-of select="image/@path" />/<xsl:value-of select="image/filename" />
				</xsl:attribute>
			</img>
			<figcaption class="caption">
				<h4><xsl:value-of select="name" /></h4>
				<p class="text-muted"><span class="fas fa-fw fa-play"></span>&#160;Episode <xsl:value-of select="episode" /></p>
			</figcaption>
		</a>
	</figure>
</xsl:template>

<!--Note - rounds to nearest minute and outputs in format e.g. "1 hr 12 mins" -->
<xsl:template match="duration">
	<xsl:variable name="hours"><xsl:value-of select="floor(number(.) div 3600)" /></xsl:variable>
	<xsl:variable name="mins"><xsl:value-of select="round(number(.) div 60) - ($hours * 60)" /></xsl:variable>
	
	<xsl:if test="$hours != 0"><xsl:value-of select="$hours" /> hr<xsl:if test="$hours &gt; 1">s</xsl:if>&#160;</xsl:if>
	<xsl:value-of select="format-number($mins,'00')" /> min<xsl:if test="$mins &gt; 1">s</xsl:if>
</xsl:template>

<xsl:template match="duration" mode="iso8601">
	<xsl:variable name="hours"><xsl:value-of select="floor(number(.) div 3600)" /></xsl:variable>
	<xsl:variable name="mins"><xsl:value-of select="floor(number(.) div 60) - ($hours * 60)" /></xsl:variable>
	<xsl:variable name="secs"><xsl:value-of select="number(.) mod 60" /></xsl:variable>
	
	<xsl:text>PT</xsl:text>
	<xsl:if test="$hours != 0"><xsl:value-of select="$hours" />H</xsl:if>
	<xsl:value-of select="$mins" /><xsl:text>M</xsl:text>
	<xsl:value-of select="$secs" /><xsl:text>S</xsl:text>
</xsl:template>

</xsl:stylesheet>
