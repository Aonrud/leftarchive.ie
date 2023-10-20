<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	exclude-result-prefixes="dc">

<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/general-datetime.xsl"/>
<xsl:import href="../utilities/entry.xsl"/>
<xsl:import href="../utilities/meta-redirect.xsl"/>
<xsl:import href="../utilities/section.xsl"/>
<xsl:import href="../utilities/section-documents.xsl"/>
<xsl:import href="../utilities/section-subjects.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<!--Select the date to display - either set by URL params, or today's date-->
<xsl:variable name="calc-month">
	<xsl:choose>
		<xsl:when test="/data/params/month != ''">
			<xsl:value-of select="/data/params/month" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="/data/params/this-month" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:variable name="month-days">
	<xsl:call-template name="month-days">
		<xsl:with-param name="month" select="$calc-month" />
	</xsl:call-template>
</xsl:variable>

<xsl:variable name="calc-day">
	<xsl:choose>
		<xsl:when test="/data/params/day != ''">
			<xsl:value-of select="/data/params/day" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="/data/params/this-day" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:variable name="date-valid">
	<xsl:choose>
		<xsl:when test="$calc-month &lt; 1 or $calc-month &gt; 12">No</xsl:when>
		<xsl:when test="$calc-day &lt; 1">No</xsl:when>
		<xsl:when test="$calc-day &gt; $month-days">No</xsl:when>
		<xsl:otherwise>Yes</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:template name="head-insert">
	<meta name="validity" value="{$date-valid}" />
	<xsl:if test="$date-valid = 'No'">
		<xsl:call-template name="redirect">
			<xsl:with-param name="url" select="'/calendar/on-this-day/'" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>
	
<xsl:variable name="date">
	<xsl:value-of select="$calc-month" />-<xsl:value-of select="$calc-day" />
</xsl:variable>

<xsl:variable name="display-date">
	<xsl:call-template name="format-date">
		<xsl:with-param name="date"><xsl:value-of select="/data/params/this-year" />-<xsl:value-of select="$date" /></xsl:with-param>
		<xsl:with-param name="format" select="'D M'" />
	</xsl:call-template>
</xsl:variable>

<xsl:template match="/data">
	<xsl:variable name="total">
		<xsl:value-of select="count(calendar-events-this-day/entry[contains(date, $date)]|demonstrations-this-day/entry[contains(date, $date)]|subjects-this-day/entry[contains(date, $date)]|documents-this-day[entry])" />
	</xsl:variable>

	<div class="page-header">
		<h1>
			<xsl:text>On This Day: </xsl:text><xsl:value-of select="$display-date" />&#160;
			<small>Events and documents from this date in history</small>
		</h1>
	</div>
	
	<p class="text-right"><a href="/calendar" class="btn btn-success"><i class="fas fa-calendar-alt"></i> Full Calendar</a></p>
	
	<xsl:choose>
		<xsl:when test="$date-valid = 'No'">
			<div class="alert alert-danger"><span class="fas fa-exclamation"></span> Invalid date in URL. Returning to main page.</div>
		</xsl:when>
		<xsl:otherwise>
			<div class="row">
				<div class="col-sm-12">
					<xsl:if test="$total = 0">
						<div class="alert alert-warning">There are no entries for this date. If you have suggestions for events that we should include here, <a href="/submit/" class="alert-link" title="Contact the Irish Left Archive">please get in touch with us</a>.</div>
					</xsl:if>
					<xsl:if test="$total &gt; 1">
						<ul>
							<xsl:apply-templates select="calendar-events-this-day/entry[contains(date, $date)]" mode="event-list" />
							<xsl:apply-templates select="demonstrations-this-day/entry[contains(date, $date)]" mode="event-list" />
							<xsl:apply-templates select="documents-this-day[entry]" mode="event-list" />
							<xsl:apply-templates select="subjects-this-day[contains(entry/date, $date)]" mode="event-list" />
						</ul>
					</xsl:if>
					
					<xsl:apply-templates select="calendar-events-this-day/entry[contains(date, $date)]" mode="event-article" />
					<xsl:apply-templates select="demonstrations-this-day/entry[contains(date, $date)]" mode="event-article" />
					<xsl:apply-templates select="documents-this-day[entry]" />
					<xsl:apply-templates select="subjects-this-day[contains(entry/date, $date)]" />
					
					<xsl:call-template name="date-next-prev" />
				</div>
			</div>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="calendar-events-this-day/entry|demonstrations-this-day/entry" mode="event-list">
	<li><a href="#event-{@id}"><xsl:value-of select="name" /></a></li>
</xsl:template>

<xsl:template match="subjects-this-day" mode="event-list">
	<li><a href="#subjects">Subject headings from <xsl:value-of select="$display-date" /></a></li>
</xsl:template>


<xsl:template match="documents-this-day" mode="event-list">
	<li><a href="#documents">Documents published on <xsl:value-of select="$display-date" /></a></li>
</xsl:template>

<xsl:template match="entry" mode="event-article">
	<article id="event-{@id}" class="bordered contained">
		<div class="label label-primary">
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="date" />
				<xsl:with-param name="format" select="'Y'" />
			</xsl:call-template>
		</div>
		<header>
			<h2><xsl:value-of select="name" /></h2>
		</header>
		<xsl:apply-templates select="." mode="event-body" />
	</article>
</xsl:template>

<xsl:template match="calendar-events-this-day/entry" mode="event-body">
	<section>
		<xsl:apply-templates select="description/*" mode="html" />
	</section>
	<footer>
		<xsl:apply-templates select="linked" />
	</footer>
</xsl:template>

<xsl:template match="demonstrations-this-day/entry" mode="event-body">
	<section>
		<xsl:apply-templates select="summary" mode="html" />
		<p><a href="/demonstration/{@id}/" class="btn btn-default"><span class="fas fa-bullhorn"></span> Details of this demonstration <span class="fas fa-arrow-right"></span></a></p>
	</section>
	<footer>
		<h3>Documents from this demonstration</h3>
		<ul class="scroller">
			<xsl:apply-templates select="documents/item" mode="scroller">
				<xsl:with-param name="show-year" select="'No'" />
			</xsl:apply-templates>
		</ul>
	</footer>
</xsl:template>

<xsl:template match="entry/linked">
	<h3>Related Pages</h3>
	<ul class="list-unstyled">
		<xsl:apply-templates select="item" />
	</ul>
</xsl:template>

<xsl:template match="linked/item">
	<li>
		<xsl:call-template name="section-icon">
			<xsl:with-param name="section" select="@section-handle" />
		</xsl:call-template>
		<xsl:apply-templates select="." mode="entry-link" />
	</li>
</xsl:template>

<xsl:template match="documents-this-day">
	<article id="documents" class="bordered contained">
		<div class="label label-primary">
			<xsl:call-template name="section-icon">
				<xsl:with-param name="section" select="'documents'" />
			</xsl:call-template>
		</div>
		<header>
			<h2>Published On This Day</h2>
		</header>
		<section>
			<ul class="media-list">
				<xsl:apply-templates select="entry" mode="full">
					<xsl:with-param name="orgs" select="'Yes'" />
				</xsl:apply-templates>
			</ul>
		</section>
	</article>
</xsl:template>

<xsl:template match="subjects-this-day">
	<article id="subjects" class="bordered contained">
		<div class="label label-primary">
			<xsl:call-template name="section-icon">
				<xsl:with-param name="section" select="'subjects'" />
			</xsl:call-template>
		</div>
		<header>
			<h2>Subject Headings</h2>
		</header>
		<section>
			<dl>
				<xsl:apply-templates select="entry[contains(date, $date)]" />
			</dl>
		</section>
	</article>
</xsl:template>

<xsl:template match="subjects-this-day/entry">
	<xsl:variable name="icon">
		<xsl:call-template name="subjects-group-icon">
			<xsl:with-param name="group" select="group/item" />
		</xsl:call-template>
	</xsl:variable>
	<dt>
		<span class="fas fa-{$icon}"></span>&#160;
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="date" />
			<xsl:with-param name="format" select="'Y'" />
		</xsl:call-template>
	</dt>
	<dd><a href="/subject/{@id}/"><xsl:value-of select="name" /></a></dd>
</xsl:template>

<xsl:template name="date-next-prev">
	<xsl:variable name="this-month-days">
		<xsl:call-template name="month-days">
			<xsl:with-param name="month" select="$calc-month" />
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="next">
		<xsl:choose>
			<xsl:when test="$date = '12-31'">
				<xsl:text>01/01/</xsl:text>
			</xsl:when>
			<xsl:when test="$calc-day = $this-month-days">
				<xsl:value-of select="format-number($calc-month + 1, '00')" />
				<xsl:text>/01/</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number($calc-month, '00')" />
				<xsl:text>/</xsl:text>
				<xsl:value-of select="format-number($calc-day + 1, '00')" />
				<xsl:text>/</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="prev">
		<xsl:choose>
			<xsl:when test="$date = '01-01'">
				<xsl:text>12/31/</xsl:text>
			</xsl:when>
			<xsl:when test="$calc-day = 1">
				<xsl:value-of select="format-number($calc-month - 1, '00')" />
				<xsl:text>/</xsl:text>
				<xsl:call-template name="month-days">
					<xsl:with-param name="month" select="$calc-month - 1" />
				</xsl:call-template>
				<xsl:text>/</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number($calc-month, '00')" />
				<xsl:text>/</xsl:text>
				<xsl:value-of select="format-number($calc-day - 1, '00')" />
				<xsl:text>/</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<div class="text-center">
		<div class="btn-group" role="group">
			<a href="/calendar/on-this-day/{$prev}" class="btn btn-default">
				<span class="fas fa-arrow-left"></span>&#160;
				<xsl:call-template name="format-date">
					<xsl:with-param name="date"><xsl:value-of select="/data/params/this-year" />-<xsl:value-of select="$prev" /></xsl:with-param>
					<xsl:with-param name="format" select="'D M'" />
				</xsl:call-template>
			</a>
			<span class="btn btn-default disabled">
				<xsl:value-of select="$display-date" />
			</span>
			<a href="/calendar/on-this-day/{$next}" class="btn btn-default">
				<xsl:call-template name="format-date">
					<xsl:with-param name="date"><xsl:value-of select="/data/params/this-year" />-<xsl:value-of select="$next" /></xsl:with-param>
					<xsl:with-param name="format" select="'D M'" />
				</xsl:call-template>
				&#160;<span class="fas fa-arrow-right"></span>
			</a>
		</div>
	</div>
</xsl:template>

<xsl:template name="page-title">
	On This Day, <xsl:value-of select="$display-date" /> | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">Events and documents from this day in history from the Irish Left Archive.</xsl:variable>
	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="On This Day, {$display-date}" />
	<meta property="og:url" content="{/data/params/root}/{/data/params/current-path}/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Calendar'" />
		<xsl:with-param name="link">/calendar/</xsl:with-param>
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'No'" />
	</xsl:call-template>
	
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name">
			<xsl:text>On This Day</xsl:text>
			<xsl:if test="$date != concat(/data/params/this-month, '-', /data/params/this-day)">: <xsl:value-of select="$display-date" /></xsl:if>
		</xsl:with-param>
		<xsl:with-param name="link">/calendar/on-this-day/</xsl:with-param>
		<xsl:with-param name="position" select="'3'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="end-insert">
	<xsl:if test="/data/demonstrations-this-day/entry[contains(date, $date)]">
	<script type="text/javascript">
		new ila.Scroller(
			document.querySelector(".scroller"),
			{
				classes: {
					left: "scroller-left btn btn-default btn-scroller",
					right: "scroller-right btn btn-default btn-scroller",
				},
				texts: {	
					left: '',
					right:'',
				},
				icons: {
					left: "far fa-arrow-alt-circle-left",
					right: "far fa-arrow-alt-circle-right",
				},
				breakpoints: [ [0, 2], [768, 4], [992, 6], [1200, 6] ]
			}
		);
	</script>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
