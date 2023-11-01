<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="dc">

<xsl:import href="general-settings.xsl" />

<xsl:template name="footer">
<div class="row">
<footer id="footer" class="clearfix">

<div class="col-sm-4">

	<h4><span class="fas fa-bars fa-fw"></span> Navigation</h4>
	<ul class="list-unstyled">
	<li><a href="/" title="Return to the home page">Home</a></li>
	<li><a href="/browse/" title="Browse the full index">Full Index</a></li>
	<li><a href="/search/" title="Search the archive">Search</a></li>
	</ul>


	<h4><span class="fas fa-info fa-fw"></span> Information</h4>
	<ul class="list-unstyled">
	<li><a href="/information/about-the-irish-left-archive/" title="About the CLR Irish Left Archive">About the Archive</a></li>
	<li><a href="/information/about-the-timeline/" title="About the Timeline of the Irish Left">About the Left Timeline</a></li>
	<li><a href="/information/about-the-website/" title="About the Website">About the Website</a></li>
	<li><a href="/information/content-submissions/" title="Submitting documents and content to the archive">Content Submissions</a></li>
	<li><a href="/information/copyright/" title="Copyright and fair use in the archive">Copyright</a></li>
	<li><a href="/information/privacy/" title="Privacy information">Privacy</a></li>
	<li><a href="/information/news/" title="Latest updates on the Irish Left Archive project">News</a></li>
	<li><a href="/information/publications-bibliography/" title="Bibliography of Irish left publications">Bibliography of Publications</a></li>
	<li><a href="/information/further-resources/" title="Other online archives">Further Resources</a></li>
	<li><a href="/submit/" title="Submit a document or contact the Irish Left Archive">Submit/Contact</a></li>
	</ul>

</div><!--end col-->

<div class="col-sm-4">

	<h4><span class="fas fa-archive fa-fw"></span> Archive Contents</h4>
	<ul class="list-unstyled">
        <li><a href="/documents/" title="Browse all political documents">Documents</a></li>
        <li><a href="/personal-accounts/" title="Browse personal accounts of political activity">Personal Accounts</a></li>
        <li><a href="/demonstrations/" title="Browse Snapshots of Political Action">Demonstrations &amp; Protests</a></li>
        <li><a href="/collections/" title="Browse document collections">Collections</a></li>
        <li><a href="/articles/" title="Browse articles on particular organisations or publications">Articles</a></li>
        <li><a href="/browse/organisations/" title="Browse organisations">Organisations</a></li>
        <li><a href="/browse/international-organisations/" title="Browse international Organisations">International Organisations</a></li>
        <li><a href="/browse/publications/" title="Browse publications">Publications</a></li>
        <li><a href="/browse/people/" title="Browse people">People</a></li>
        <li><a href="/browse/subjects/" title="Browse subject headings">Subjects</a></li>
		<li><a href="/calendar/" title="Calendar of historical events and documents">Calendar</a></li>
        <li><a href="/calendar/on-this-day/" title="Events from this date in history">On This Day</a></li>
	</ul>
	
	<h4><span class="fas fa-diagram-project fa-fw"></span> Timeline</h4>
	<p><small><a href="/page/timeline-of-the-irish-left/" title="View a timeline of Irish left organisations.">View our timeline of Irish left organisations from 1900 to the present</a>.</small></p>

</div><!--end col-->

<div class="col-sm-4">

	<h4><span class="fas fa-microphone-alt"></span> Podcast</h4>
	<p><a href="https://podcast.leftarchive.ie/"><img src="/image/1/200/200/assets/images/ila-podcast.jpg" class="img-responsive" alt="Irish Left Archive Podcast" /></a></p>

	<h4><span class="fas fa-bookmark fa-fw"></span> Follow the Archive</h4>
	<ul class="footer-icons list-unstyled">
		<li><a href="/rss/" title="New Additions RSS feed" class="rss"><span class="fas fa-rss fa-fw"></span></a></li>
		<li><a href="{$ila-activitypub-url}" rel="me" title="Irish Left Archive on the Fediverse" class="ila"><span class="fas fa-share-nodes fa-fw"></span></a></li>
		<li><a href="{$ila-git-url}" rel="me" title="Irish Left Archive Git Repositories" class="git"><span class="fab fa-git-alt fa-fw"></span></a></li>
		<li><a href="https://podcast.leftarchive.ie/" rel="me" title="Irish Left Archive Podcast" class="ila"><span class="fas fa-microphone fa-fw"></span></a></li>
	</ul>	

</div><!--end col-->
</footer>
</div>
</xsl:template>

</xsl:stylesheet>
