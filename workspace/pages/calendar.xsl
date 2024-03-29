<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/general-datetime.xsl"/>
<xsl:import href="../utilities/general-strings.xsl"/>
<xsl:import href="../utilities/section.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<header class="page-header">
		<h1>Calendar of Events <small>Showing events, documents, demonstrations and subjects from each day of the year</small></h1>
	</header>
	<ul class="list-inline text-muted">
		<li>
			<xsl:call-template name="section-icon">
				<xsl:with-param name="section" select="'calendar-events'" />
			</xsl:call-template>
			<xsl:text>Historical Events</xsl:text>
		</li>
		<li>
			<xsl:call-template name="section-icon">
				<xsl:with-param name="section" select="'demonstrations'" />
			</xsl:call-template>
			<xsl:text>Demonstrations</xsl:text>
		</li>
		<li>
			<xsl:call-template name="section-icon">
				<xsl:with-param name="section" select="'documents'" />
			</xsl:call-template>
			<xsl:text>Documents Published</xsl:text>
		</li>
		<li>
			<xsl:call-template name="section-icon">
				<xsl:with-param name="section" select="'subjects'" />
			</xsl:call-template>
			<xsl:text>Subject Headings</xsl:text>
		</li>
	</ul>
	<div class="calendar">
		<xsl:call-template name="calendar" />
	</div>
</xsl:template>

<xsl:template name="calendar">
	<xsl:param name="months" select="'12'" />
	<xsl:param name="current" select="'1'" />
	
	<xsl:variable name="total-events">
		<xsl:variable name="match">-<xsl:value-of select="format-number($current, '00')" />-</xsl:variable>
		<xsl:value-of select="count(/data/calendar-events-list/entry[contains(date, $match)])" />
	</xsl:variable>
	
	<details class="month">
		<summary>
			<p>
				<xsl:call-template name="format-month">
					<xsl:with-param name="month" select="format-number($current, '00')" />
					<xsl:with-param name="format" select="'M'" />
				</xsl:call-template>
			</p>
			<span class="summary-btn" aria-hidden="true"></span>
		</summary>
		<ol class="days">
			<xsl:call-template name="days">
				<xsl:with-param name="month" select="$current" />
			</xsl:call-template>
		</ol>
	</details>
	
	<xsl:if test="$current &lt; $months">
		<xsl:call-template name="calendar">
			<xsl:with-param name="current" select="$current + 1" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="days">
	<xsl:param name="month" />
	<xsl:param name="current" select="'1'" />
	
	<xsl:variable name="total">
		<xsl:call-template name="month-days">
			<xsl:with-param name="month" select="$month" />
		</xsl:call-template>
	</xsl:variable>
	
	<xsl:variable name="date-match">
		<xsl:text>-</xsl:text><xsl:value-of select="format-number($month, '00')" /><xsl:text>-</xsl:text><xsl:value-of select="format-number($current, '00')" />
	</xsl:variable>
	
	<xsl:variable name="events-count">
		<xsl:value-of select="count(/data/calendar-events-list/entry[contains(date, $date-match)])" />
	</xsl:variable>
	
	<xsl:variable name="demonstrations-count">
		<xsl:value-of select="count(/data/demonstrations-list/entry[contains(date, $date-match)])" />
	</xsl:variable>
	
	<xsl:variable name="documents-count">
		<xsl:value-of select="count(/data/documents-fixed-date/entry[month = $month and day = $current])" />
	</xsl:variable>
	
	<xsl:variable name="subjects-count">
		<xsl:value-of select="count(/data/subjects-list-calendar/entry[contains(date, $date-match)])" />
	</xsl:variable>
	
	<li>
		<a href="/calendar/on-this-day/{format-number($month, '00')}/{format-number($current, '00')}/" data-events="{$events-count}" data-demonstrations="{$demonstrations-count}" data-documents="{$documents-count}" data-subjects="{$subjects-count}" data-total="{$events-count + $documents-count + $demonstrations-count + $subjects-count}">
			<xsl:attribute name="data-date">
				<xsl:value-of select="format-number($month, '00')" />/<xsl:value-of select="format-number($current, '00')" />
			</xsl:attribute>
			<xsl:if test="$events-count + $documents-count + $demonstrations-count + $subjects-count != 0">
				<xsl:attribute name="title">
					<xsl:text> View </xsl:text>
					<xsl:call-template name="make-list">
						<xsl:with-param name="string">
							<xsl:if test="$events-count != 0"> events</xsl:if>
							<xsl:if test="$demonstrations-count != 0"> demonstrations</xsl:if>
							<xsl:if test="$documents-count != 0"> documents</xsl:if>
							<xsl:if test="$subjects-count != 0"> subjects</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:text> from </xsl:text>
					<xsl:call-template name="format-date">
						<xsl:with-param name="date">1900-<xsl:value-of select="format-number($month, '00')" />-<xsl:value-of select="format-number($current, '00')" /></xsl:with-param>
						<xsl:with-param name="format" select="'D M'" />
					</xsl:call-template>
				</xsl:attribute>
			</xsl:if>
			
			<div><xsl:value-of select="format-number($current, '00')" /></div>
			
			<ul class="indicators">
				<li class="events">
					<xsl:call-template name="section-icon">
						<xsl:with-param name="section" select="'calendar-events'" />
					</xsl:call-template>
				</li>
				<li class="demonstrations">
					<xsl:call-template name="section-icon">
						<xsl:with-param name="section" select="'demonstrations'" />
					</xsl:call-template>
				</li>
				<li class="documents">
					<xsl:call-template name="section-icon">
						<xsl:with-param name="section" select="'documents'" />
					</xsl:call-template>
				</li>
				<li class="subjects">
					<xsl:call-template name="section-icon">
						<xsl:with-param name="section" select="'subjects'" />
					</xsl:call-template>
				</li>
			</ul>
		</a>
	</li>
	
	<xsl:if test="$current &lt; $total">
		<xsl:call-template name="days">
			<xsl:with-param name="month" select="$month" />
			<xsl:with-param name="current" select="$current + 1" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="page-title">
	Calendar of Events — Irish Left Archive
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">A calendar of events, documents, demonstrations and subjects from each day of the year.</xsl:variable>
	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Calendar of Events" />
	<meta property="og:url" content="{/data/params/root}/{/data/params/current-path}/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name">
			<xsl:text>Calendar</xsl:text>
		</xsl:with-param>
		<xsl:with-param name="link">/calendar/</xsl:with-param>
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
