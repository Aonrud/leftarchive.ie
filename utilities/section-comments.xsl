<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:content="http://purl.org/rss/1.0/modules/content/"
	exclude-result-prefixes="dc content"
	>

<xsl:import href="general-datetime.xsl"/>

<xsl:template match="comments">

<xsl:variable name="include-clr">
<xsl:choose>
<xsl:when test="/data/params/ds-document-single.clr-page or /data/params/ds-article-single.clr-page">yes</xsl:when>
<xsl:otherwise>no</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="clr-count">
<xsl:choose>
<xsl:when test="$current-page-id = 1"><xsl:value-of select="count(/data/clr-comments-documents/item)" /></xsl:when>
<xsl:when test="$current-page-id = 15"><xsl:value-of select="count(/data/clr-comments-articles/item)" /></xsl:when>
<xsl:otherwise>0</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="name">
<xsl:choose>
<xsl:when test="$current-page-id = 1"><xsl:value-of select="/data/document-single/entry/name" /></xsl:when>
<xsl:when test="$current-page-id = 15"><xsl:value-of select="/data/organisation-article/entry/name" /></xsl:when>
</xsl:choose>
</xsl:variable>

<xsl:variable name="source">
<xsl:choose>
<xsl:when test="$current-page-id = 1"><xsl:value-of select="/data/document-single/entry/clr-page" />#comments</xsl:when>
<xsl:when test="$current-page-id = 15"><xsl:value-of select="/data/article-single/entry/clr-page" />#comments</xsl:when>
</xsl:choose>
</xsl:variable>


<hr />
<section id="comments">
<h2>Comments <xsl:if test="count(.//entry) != 0 and $clr-count = 0"><span class="badge"><xsl:value-of select="count(.//entry)" /></span></xsl:if></h2>

<xsl:choose>
<xsl:when test="$include-clr = 'yes' and $clr-count != 0">
<ul class="nav nav-tabs" role="tablist">
<li class="active"><a href="#ila-comments" role="tab" data-toggle="tab">On this site <xsl:if test="count(.//entry) != 0"><span class="badge"><xsl:value-of select="count(.//entry)" /></span></xsl:if></a></li>
<li ><a href="#clr-comments" role="tab" data-toggle="tab">From the <abbr title="Cedar Lounge Revolution">CLR</abbr> <xsl:text> </xsl:text><span class="badge"><xsl:value-of select="$clr-count" /></span></a></li>
</ul>
<p></p>
<div class="tab-content">
<div class="tab-pane fade in active" id="ila-comments">
<xsl:call-template name="ila-comments">
<xsl:with-param name="include-clr" select="$include-clr" />
<xsl:with-param name="clr-count" select="$clr-count" />
<xsl:with-param name="name" select="$name" />
<xsl:with-param name="source" select="$source" />
</xsl:call-template>
</div>
<div class="tab-pane fade" id="clr-comments">
<xsl:call-template name="clr-comments">
<xsl:with-param name="clr-count" select="$clr-count" />
<xsl:with-param name="name" select="$name" />
<xsl:with-param name="source" select="$source" />
</xsl:call-template>
</div>
</div><!--tab-content-->
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="ila-comments">
<xsl:with-param name="include-clr" select="$include-clr" />
<xsl:with-param name="clr-count" select="$clr-count" />
<xsl:with-param name="name" select="$name" />
<xsl:with-param name="source" select="$source" />
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</section>
</xsl:template>

<xsl:template name="ila-comments">
<xsl:param name="include-clr" select="no" />
<xsl:param name="clr-count" select="0" />
<xsl:param name="name" />
<xsl:param name="source" />

<xsl:if test="$include-clr = 'yes' and $clr-count = 0">
<p class="alert alert-info"><span class="fas fa-info-circle fa-lg"></span> You can also join the discussion on <a href="{$source}" title="Discuss {$name} on the Cedar Lounge Revolution" class="alert-link external-link">The Cedar Lounge Revolution<span class="fas fa-external-link-alt"></span></a></p>
</xsl:if>
<xsl:if test="count(.//entry) = 0">
<p><em>No Comments yet.</em></p>
</xsl:if>
<xsl:apply-templates select="parent[@value = 'None']" />
<xsl:apply-templates select="/data/events/submit-comment" />
<xsl:call-template name="comment-form" />
</xsl:template>

<xsl:template match="parent">
<ul><xsl:if test="current()[@value = 'None']"><xsl:attribute name="class">media-list</xsl:attribute></xsl:if>
<xsl:apply-templates select="entry" />
</ul>
</xsl:template>

<xsl:template match="comments/parent/entry">
<li class="media comment">
    <div class="media-body">
						<img class="media-object pull-right" src="//www.gravatar.com/avatar/{email/@hash}?s=64&amp;d=mm" alt="{name}" />
      <h4 id="comment-{@id}" class="media-heading"><xsl:value-of select="title" /></h4>
						<p class="text-muted"><small>By: <xsl:choose><xsl:when test="website != ''"><a href="{website}" rel="nofollow"><xsl:value-of select="name" /></a></xsl:when><xsl:otherwise><xsl:value-of select="name" /></xsl:otherwise></xsl:choose> | <a href="#comment-{@id}"><xsl:call-template name="format-date"><xsl:with-param name="date" select="date"/><xsl:with-param name="format" select="'D M Y, t'"/></xsl:call-template></a></small></p>
      <div class="comment-body clearfix"><xsl:apply-templates select="comment/*" mode="html"/></div>
						<p><a href="javascript:;" class="reply-link" data-comment-id="{@id}" data-comment-name="{name}"><span class="fas fa-reply"></span> Reply to this comment</a></p>
					<xsl:apply-templates select="/data/comments/parent[@link-id = current()/@id]" />
    </div>
</li>
</xsl:template>

<xsl:template match="events/submit-comment">
	<div id="comment-result" class="{@result}">

		<xsl:choose>
		
			<xsl:when test="@result = 'success'">
				<p class="alert alert-success"><span class="fas fa-check-circle fa-lg"></span> Thank you for your comment.</p>
			</xsl:when>

			<xsl:otherwise>
				<p class="alert alert-danger"><span class="fas fa-exclamation-triangle fa-lg"></span> Your comment could not be added. Please check that you have completed the form correctly and try again.</p>
			</xsl:otherwise>
		
		</xsl:choose>
	</div>
</xsl:template>

<xsl:template name="comment-form">

<h4>Add a Comment</h4>
<form id="comment-form" method="post" action="#comment-result" enctype="multipart/form-data">
  <input name="MAX_FILE_SIZE" type="hidden" value="15242880" />
		<div class="form-group">
<xsl:if test="/data/events/submit-comment[@result = 'error']/title">
<xsl:attribute name="class">has-error</xsl:attribute>
</xsl:if>
		<label for="f-title">Title</label>
    <input id="f-title" name="fields[title]" type="text" class="form-control"><xsl:if test="/data/events/submit-comment/@result = 'error'"><xsl:attribute name="value"><xsl:value-of select="/data/events/submit-comment/post-values/title" /></xsl:attribute></xsl:if></input> 
<p id="reply-status"> </p> 
		<xsl:if test="/data/events/submit-comment[@result = 'error']/title">
		<p class="help-block">Please include a title.</p>
		</xsl:if>
		</div>
		<div class="form-group">
<xsl:if test="/data/events/submit-comment[@result = 'error']/comment[@type = 'missing']">
<xsl:attribute name="class">has-error</xsl:attribute>
</xsl:if>
<xsl:if test="/data/events/submit-comment[@result = 'error']/comment[@type = 'invalid']">
<xsl:attribute name="class">has-error</xsl:attribute>
</xsl:if>
  <label for="f-comment">Comment</label>
  <div class="help">
  <a id="comment-help" href="javascript:;" data-toggle="popover" data-placement="bottom" tabindex="-1">Formatting Help <span class="caret"></span></a>
  </div>
    <textarea id="f-comment" name="fields[comment]" rows="4" class="form-control"><xsl:if test="/data/events/submit-comment/@result = 'error'"><xsl:value-of select="/data/events/submit-comment/post-values/comment" /></xsl:if></textarea>
		
		<xsl:if test="/data/events/submit-comment[@result = 'error']/comment[@type = 'missing']">
		<p class="help-block">Please add your comment.</p>
		</xsl:if>
<xsl:if test="/data/events/submit-comment[@result = 'error']/comment[@type = 'invalid']">
<p class="help-block">Your comment contains invalid content. Please ensure your comment does not include any disallowed HTML or scripts.</p>
</xsl:if>
		</div>
		<div class="form-group">
<xsl:if test="/data/events/submit-comment[@result = 'error']/name">
<xsl:attribute name="class">has-error</xsl:attribute>
</xsl:if>
		<label for="f-name">Name</label>
    <input id="f-name" name="fields[name]" type="text" class="form-control"><xsl:if test="/data/events/submit-comment/@result = 'error'"><xsl:attribute name="value"><xsl:value-of select="/data/events/submit-comment/post-values/name" /></xsl:attribute></xsl:if></input>
		<xsl:if test="/data/events/submit-comment[@result = 'error']/name">
		<p class="help-block">Please include your name.</p>
		</xsl:if>
		</div>
		<div class="form-group">
<xsl:if test="/data/events/submit-comment[@result = 'error']/email[@type = 'missing']">
<xsl:attribute name="class">has-error</xsl:attribute>
</xsl:if>
<xsl:if test="/data/events/submit-comment[@result = 'error']/email[@type = 'invalid']">
<xsl:attribute name="class">has-warning</xsl:attribute>
</xsl:if>
  <label for="f-email">Email</label>
    <input id="f-email" name="fields[email]" type="text" class="form-control"><xsl:if test="/data/events/submit-comment/@result = 'error'"><xsl:attribute name="value"><xsl:value-of select="/data/events/submit-comment/post-values/email" /></xsl:attribute></xsl:if></input>
		<xsl:if test="/data/events/submit-comment[@result = 'error']/email[@type = 'missing']">
		<p class="help-block">Please include your email address (this will not be published).</p>
		</xsl:if>
		<xsl:if test="/data/events/submit-comment[@result = 'error']/email[@type = 'invalid']">
		<p class="help-block">Please include a valid email address (this will not be published).</p>
		</xsl:if>
		</div>
<div class="form-group">
<xsl:if test="/data/events/submit-comment[@result = 'error']/website">
<xsl:attribute name="class">has-warning</xsl:attribute>
</xsl:if>
<label for="f-website">Website <small class="text-muted">(Optional)</small></label>
<input id="f-website" name="fields[website]" type="text" class="form-control"><xsl:if test="/data/events/submit-comment/@result = 'error'"><xsl:attribute name="value"><xsl:value-of select="/data/events/submit-comment/post-values/website" /></xsl:attribute></xsl:if></input>
		<xsl:if test="/data/events/submit-comment[@result = 'error']/website">
		<p class="help-block">Please ensure you have entered a valid URL.</p>
		</xsl:if>
</div>
		<!--Check which section we're in-->
		<xsl:if test="$current-page-id = 1">
			<input name="fields[associated-page]" type="hidden" value="{/data/document-single/entry/@id}" />
		</xsl:if>
		<xsl:if test="$current-page-id = 7">
			<input name="fields[associated-page]" type="hidden" value="{/data/organisation-single/entry/@id}" />
		</xsl:if>
		<xsl:if test="$current-page-id = 8">
			<input name="fields[associated-page]" type="hidden" value="{/data/publication-single/entry/@id}" />
		</xsl:if>
		<xsl:if test="$current-page-id = 15">
			<input name="fields[associated-page]" type="hidden" value="{/data/article-single/entry/@id}" />
		</xsl:if>
		<xsl:if test="$current-page-id = 9">
			<input name="fields[associated-page]" type="hidden" value="{/data/pages-single/entry/@id}" />
		</xsl:if>
		<xsl:if test="$current-page-id = 19">
			<input name="fields[associated-page]" type="hidden" value="{/data/collection-single/entry/@id}" />
		</xsl:if>
		<xsl:if test="$current-page-id = 29">
			<input name="fields[associated-page]" type="hidden" value="{/data/person-single/entry/@id}" />
		</xsl:if>
		<xsl:if test="$current-page-id = 41">
			<input name="fields[associated-page]" type="hidden" value="{/data/international-single/entry/@id}" />
		</xsl:if>
		<xsl:if test="$current-page-id = 70">
			<input name="fields[associated-page]" type="hidden" value="{/data/demonstration-single/entry/@id}" />
		</xsl:if>
		
		<input name="fields[date]" type="hidden" value="{$today} {$current-time} {$timezone}" />
		<input name="fields[published]" type="hidden" value="yes" />
  <input id="comment-parent" name="fields[parent]" type="hidden" value="{/data/events/submit-comment/post-values/parent}" />
<input name="akismet[author]" value="name" type="hidden" />
<input name="akismet[email]" value="email" type="hidden" />
<input name="akismet[url]" value="website" type="hidden" />
  <button name="action[submit-comment]" type="submit" class="btn btn-primary">Comment</button>
</form>
<div id="comments-help-head" class="hide">Formatting Help</div>
<div id="comments-help-content" class="hide">
<p>Comments can be formatted in <a href="https://en.wikipedia.org/wiki/Markdown#Example" class="external">Markdown format <span class="fas fa-external-link-alt"></span></a>.  Use the toolbar to apply the correct syntax to your comment. The basic formats are:</p>
<p>**Bold text**<br /><strong>Bold text</strong></p>
<p> _Italic text_<br /><em>Italic text</em></p>
<p>[A link](http://www.example.com)<br /><a href="http://www.example.com" class="external-link">A link<span class="fas fa-external-link-alt"></span></a></p>
</div>
</xsl:template>

<xsl:template name="clr-comments">
<xsl:param name="clr-count" select="0" />
<xsl:param name="name" />
<xsl:param name="source" />

<p class="alert alert-info"><span class="fas fa-info-circle fa-lg"></span> You can join this discussion on <a href="{$source}" title="Discuss {$name} on the Cedar Lounge Revolution" class="alert-link external-link">The Cedar Lounge Revolution<span class="fas fa-external-link-alt"></span></a></p>
<xsl:choose>
<xsl:when test="$clr-count &gt; 0">
<ul class="media-list">
<xsl:choose>
<xsl:when test="$current-page-id = 1">
<xsl:apply-templates select="/data/clr-comments-documents/item" mode="clr-comment">
<xsl:sort select="position()" data-type="number" order="descending"/>
</xsl:apply-templates>
</xsl:when>
<xsl:when test="$current-page-id = 15">
<xsl:apply-templates select="/data/clr-comments-articles/item" mode="clr-comment">
<xsl:sort select="position()" data-type="number" order="descending"/>
</xsl:apply-templates>
</xsl:when>
</xsl:choose>
</ul>
</xsl:when>
<xsl:otherwise>
<p><em>No comments yet.</em></p>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="//item" mode="clr-comment">

<xsl:variable name="date-content">
<xsl:value-of select="pubDate" />
</xsl:variable>
<xsl:variable name="comment-content">
<xsl:value-of select="content:encoded" />
</xsl:variable>

<li class="media">
<div class="media-body">
<h4 class="media-heading">By: <xsl:value-of select="dc:creator" /><xsl:text> </xsl:text><small> <xsl:value-of select="substring-before($date-content, '+')" /></small></h4>
<div class="comment-body clearfix"><xsl:value-of select="substring-before($comment-content,'&lt;p id=&quot;comment-like')" disable-output-escaping="yes" /></div>
<p><a href="{link}"><span class="fas fa-reply"></span> Reply on the CLR</a></p>
</div>
</li>
</xsl:template>

</xsl:stylesheet>
