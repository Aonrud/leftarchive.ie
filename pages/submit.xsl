<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/general-datetime.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/layout-information-menu.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
	<div class="page-header"><h1>Submit/Contact</h1></div> 
	
	<div class="row">
		<div class="col-sm-9">
			<p class="lead">You can contact the archive using the form below.</p>
			<p>If you are submitting content for inclusion and have a digital copy, please include it with your message by uploading it under 'Submit Content'.</p>
			
			<xsl:apply-templates select="events/submit" />
			
			<form method="post" action="" enctype="multipart/form-data" role="form" class="wide-form">
				<input name="MAX_FILE_SIZE" type="hidden" value="15242880" />
				<input name="fields[date]" type="hidden" value="{$today} {$current-time} {$timezone}" />
				
				<div class="form-group">
					<xsl:if test="/data/events/submit[@result = 'error']/name">
						<xsl:attribute name="class">has-error</xsl:attribute>
					</xsl:if>
					<label for="fields[name]">Name</label>
					<input name="fields[name]" type="text" class="form-control">
						<xsl:if test="/data/events/submit/@result = 'error'"><xsl:attribute name="value"><xsl:value-of select="/data/events/submit/post-values/name" /></xsl:attribute></xsl:if>
					</input>
					<xsl:if test="/data/events/submit[@result = 'error']/name">
						<p class="help-block">Please include your name.</p>
					</xsl:if>
				</div>
				<div class="form-group">
					<xsl:if test="/data/events/submit[@result = 'error']/email[@type = 'missing']">
						<xsl:attribute name="class">has-error</xsl:attribute>
					</xsl:if>
					<xsl:if test="/data/events/submit[@result = 'error']/email[@type = 'invalid']">
						<xsl:attribute name="class">has-warning</xsl:attribute>
					</xsl:if> 
					<label for="fields[email]">Email</label>
					<input name="fields[email]" type="text" class="form-control">
						<xsl:if test="/data/events/submit/@result = 'error'"><xsl:attribute name="value"><xsl:value-of select="/data/events/submit/post-values/email" /></xsl:attribute></xsl:if>
					</input>
					<xsl:if test="/data/events/submit[@result = 'error']/email[@type = 'missing']">
						<p class="help-block">Please include your email address.</p>
					</xsl:if>
					<xsl:if test="/data/events/submit[@result = 'error']/email[@type = 'invalid']">
						<p class="help-block">Please include a valid email address.</p>
					</xsl:if>
				</div>
				<div class="form-group">
					<xsl:if test="/data/events/submit[@result = 'error']/subject">
						<xsl:attribute name="class">has-error</xsl:attribute>
					</xsl:if>
					<label for="fields[subject]">Subject</label>
					<input name="fields[subject]" type="text" class="form-control">
						<xsl:if test="/data/events/submit/@result = 'error'"><xsl:attribute name="value"><xsl:value-of select="/data/events/submit/post-values/subject" /></xsl:attribute></xsl:if>
					</input>
					<xsl:if test="/data/events/submit[@result = 'error']/subject">
						<p class="help-block">Please include a subject.</p>
					</xsl:if>
				</div>
				<div class="form-group">
					<xsl:if test="/data/events/submit[@result = 'error']/user-message">
						<xsl:attribute name="class">has-error</xsl:attribute>
					</xsl:if>
					<label for="fields[message]">Message</label>
					<textarea name="fields[user-message]" rows="4" class="form-control">
						<xsl:if test="/data/events/submit/@result = 'error'"><xsl:value-of select="/data/events/submit/post-values/user-message" /></xsl:if>
					</textarea>
					<xsl:if test="/data/events/submit[@result = 'error']/user-message">
						<p class="help-block">Please include a message.</p>
					</xsl:if>
				</div>
				<div class="form-group">
					<xsl:if test="/data/events/submit[@result = 'error']/document[@type = 'invalid']">
						<xsl:attribute name="class">has-warning</xsl:attribute>
					</xsl:if>
					<label for="fields[document]">Submit Content</label>
					<input name="fields[document]" type="file" />
					<p class="help-block">
						<xsl:if test="/data/events/submit[@result = 'error']/document[@type = 'invalid']">
							This file is invalid. Please ensure you upload a document or image in one of the allowed formats.
						</xsl:if>
					Documents or images must be of one of the following file types:<br /> .pdf, .doc, .docx, .odt, .rtf, .txt, .jpg, .bmp, .gif, .png</p>
				</div>

				<input name="send-email[reply-to-email]" value="fields[email]" type="hidden" />
				<input name="send-email[reply-to-name]" value="fields[name]" type="hidden" />
				<input name="send-email[subject]" value="CLR Irish Left Archive Contact" type="hidden" />
				<input name="send-email[body]" value="fields[user-message]" type="hidden" />
				<input name="send-email[recipient]" value="email-recipient" type="hidden" />

				<input name="akismet[author]" value="name" type="hidden" />
				<input name="akismet[email]" value="email" type="hidden" />
				
				<button name="action[submit]" type="submit" class="btn btn-primary">Send</button>
				
			</form>
		</div>

		<div class="col-sm-3">
			<xsl:call-template name="information-menu" />
		</div><!--End col-->
	</div><!--End row-->
</xsl:template>

<xsl:template match="events/submit">
	<div id="comment-result" class="{@result}">
		<xsl:choose>
			<xsl:when test="@result = 'success'"><p class="alert alert-success"><span class="fas fa-check-circle fa-lg"></span> Your message has been sent.</p></xsl:when>
			<xsl:otherwise><p class="alert alert-danger"><span class="fas fa-exclamation-triangle fa-lg"></span> Your message could not be sent. Please check you have completed the form correctly and try again.</p>
			</xsl:otherwise>
		</xsl:choose>
	</div>
</xsl:template>

<xsl:template match="pages-list/entry">
	<a href="/information/{title/@handle}/" class="list-group-item">
	<xsl:value-of select="title" /></a>
</xsl:template>

<xsl:template name="page-title">
Contact or Submit a Document | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">Get in touch with the Irish Left Archive, or submit materials for inclusion.</xsl:variable>

	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Contact or Submit Materials" />
	<meta property="og:url" content="http://www.leftarchive.ie/submit/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Submit or Contact'" />
		<xsl:with-param name="link" select="'/submit/'" />
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'Yes'" />
		<xsl:with-param name="schema-type" select="'ContactPage'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
