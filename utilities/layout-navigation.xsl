<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="navigation">
	<xsl:param name="top" select="'No'" />

	<nav class="navbar navbar-inverse" role="navigation">
		<xsl:if test="$top = 'Yes'">
			<xsl:attribute name="class">navbar navbar-inverse navbar-static-top</xsl:attribute>
		</xsl:if>
		
		<div class="container-fluid">
			
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#menu-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand visible-xs" href="/">
					<xsl:if test="$top = 'Yes'">
						<xsl:attribute name="class">navbar-brand sitename</xsl:attribute>
					</xsl:if>
					Irish Left Archive
				</a>
			</div>

			<div id="menu-collapse" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li>
						<xsl:if test="$current-page-id = 3"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
						<a href="/">Home</a>
					</li>
					
					<li>
						<xsl:if test="$current-page-id = 28 or ($current-page-id = 37 and /data/params/title = 'timeline-of-the-irish-left')"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">Browse <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li>
								<xsl:if test="$current-page-id = 28 and /data/params/type = ''"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/browse/">Full Index</a>
							</li>
							<li>
								<xsl:if test="$current-page-id = 37 and /data/params/title = 'timeline-of-the-irish-left'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/page/timeline-of-the-irish-left/">Left Timeline</a>
							</li>
							<li>
								<xsl:if test="$current-page-id = 28 and /data/params/type = 'organisations'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/browse/organisations/">Organisations</a>
							</li>
							<li>
								<xsl:if test="$current-page-id = 28 and /data/params/type = 'international-organisations'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/browse/international-organisations/">Internationals</a>
							</li>
							<li>
								<xsl:if test="$current-page-id = 28 and /data/params/type = 'publications'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/browse/publications/">Publications</a>
							</li>
							<li>
								<xsl:if test="$current-page-id = 28 and /data/params/type = 'people'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/browse/people/">People</a>
							</li>
							<li>
								<xsl:if test="$current-page-id = 48"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/browse/subjects/">Subjects</a>
							</li>
						</ul>
					</li>
					
					<li>
						<xsl:if test="$current-page-id = 5 or $current-page-id = 1"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
						<a href="/documents/">Documents</a>
					</li>
					
					<li>
						<xsl:if test="/data/params/current-page-id = 55 or /data/params/current-page-id = 42 or /data/params/current-page-id = 19 or /data/params/current-page-id = 57 or /data/params/current-page-id = 15"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">Overviews <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li>
								<xsl:if test="/data/params/current-page-id = 69 or /data/params/current-page-id = 70"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/demonstrations/">Demonstrations &amp; Protests</a>
							</li>
							<li>
								<xsl:if test="/data/params/current-page-id = 42 or /data/params/current-page-id = 19"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/collections/">Collections</a>
							</li>
							<li>
								<xsl:if test="/data/params/current-page-id = 57 or /data/params/current-page-id = 15"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/articles/">Articles</a>
							</li>
							<li>
								<xsl:if test="/data/params/current-page-id = 66"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/on-this-day/">On This Day</a>
							</li>
							<li>
								<xsl:if test="/data/params/current-page-id = 73"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/on-this-day/calendar/">Calendar</a>
							</li>
							<li>
								<xsl:if test="/data/params/current-page-id = 55"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/personal-accounts/">Personal Accounts</a>
							</li>
						</ul>
					</li>
					
					<li>
						<xsl:if test="/data/params/current-page-id = 52"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
						<a href="/podcast/">Podcast</a>
					</li>
					
					<li>
						<xsl:if test="$current-page-id = 9 or $current-page-id = 61 or $current-page-id = 13 or $current-page-id = 10 or $current-page-id = 65"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">Information <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<xsl:apply-templates select="/data/pages-list/entry" mode="nav-dropdown" />
							<li>
								<xsl:if test="$current-page-id = 61"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/information/news/">News</a>
							</li>
							<li>
								<xsl:if test="$current-page-id = 65"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/information/publications-bibliography/">Bibliography of Publications</a>
							</li>
							<li>
								<xsl:if test="$current-page-id = 13"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/information/further-resources/">Further Resources</a>
							</li>
							<li>
								<xsl:if test="$current-page-id = 10"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
								<a href="/submit/">Submit/Contact</a>
							</li>
						</ul>
					</li>
				</ul>
				<xsl:call-template name="navigation-right-element" />
			</div><!--navbar-collapse  -->
			
		</div><!--container-fluid-->
	</nav>
</xsl:template>

<xsl:template match="/data/pages-list/entry" mode="nav-dropdown">
	<li>
		<xsl:if test="/data/params/title = current()/title/@handle"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
		<a href="/information/{title/@handle}/"><xsl:value-of select="title" /></a>
	</li>
</xsl:template>

<!--This template shows the search form, but is separated to allow replacing that on the document view page with the doc. details dropdown-->
<xsl:template name="navigation-right-element">
	<form id="nav-search-form" class="navbar-form navbar-right hidden-sm" role="search" action="/search/" method="get">
		<label class="sr-only" for="nav-keywords">Search</label>
		<div class="input-group">
			<input id="nav-keywords" name="keywords" type="search" placeholder="Search the archive" class="form-control" />
			<span class="input-group-btn"><button type="submit" class="btn btn-primary"><span class="fas fa-search"> </span></button></span>
		</div>
	</form>
</xsl:template>

</xsl:stylesheet>
