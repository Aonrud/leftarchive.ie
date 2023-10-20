<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/section-personal-account-topics.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
    <div class="page-header"><h1>Submit A Personal Account</h1></div>
    <div class="row">
        <div class="col-sm-9">

            <xsl:apply-templates select="/data/events/story" />

            <p class="lead">The Irish Left Archive hopes to collate first-hand political reminiscences or observations from people involved in Irish Left political activity over the years. We'd be grateful to anyone who has been involved in political parties, campaigns or activism who would like to provide us an account of their personal experience.</p>
            <p>We are interested in hearing from people who are or have been involved in Left politics or campaigning at any level.</p>
            <p>For example, accounts might include:</p>
            <ul>
                <li>What first led you to political activism</li>
                <li>Experience of a particular referendum or election</li>
                <li>Being a member of a particular party or group</li>
            </ul>
            <form id="story-form" method="post" action="" enctype="multipart/form-data" role="form" class="wide-form">
                <div class="form-group">
                    <xsl:if test="/data/events/story[@result = 'error']/name">
                        <xsl:attribute name="class">has-error</xsl:attribute>
                    </xsl:if>
                    <label for="fields[name]">Name</label>
                    <p class="help-block">If you'd prefer not to include your real name, please feel free to use a pseudonym here.</p>
                    <input name="fields[name]" type="text" class="form-control" />
                </div>

                <div class="form-group">
                    <xsl:if test="/data/events/story[@result = 'error']/email">
                        <xsl:attribute name="class">has-error</xsl:attribute>
                    </xsl:if>
                    <label for="fields[email]">Email Address</label>
                    <p class="help-block">Your email address will not be made public, and will only be visible to the site administrators.</p>
                    <input name="fields[email]" type="email" class="form-control" />
                    <xsl:if test="/data/events/story[@result = 'error']/email">
                        <p class="help-block">Please check that you have included a valid email address.</p>
                    </xsl:if>
                </div>
                
                <div class="form-group">
                    <label for="fields[topic]">Topic</label>
                    <p class="help-block">If no topics suit your account, please select 'Other'.  You can then also optionally suggest a new topic.</p>
                    <select name="fields[topic]" class="form-control">
                        <option id="select-placeholder" value="">Please select...</option>
                        <xsl:apply-templates select="/data/personal-account-topics-list/entry" mode="select" />
                        <option id="suggest-other" value="">Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="fields[suggestion]" class="sr-only">Suggest a topic</label>
                    <input id="new-topic" name="fields[suggestion]" type="text" placeholder="Suggest a topic" class="form-control" />
                </div>
                    
                <div class="form-group">
                    <xsl:if test="/data/events/story[@result = 'error']/notes">
                        <xsl:attribute name="class">has-error</xsl:attribute>
                    </xsl:if>
                    <label for="fields[notes]">Personal Account</label>
                    <textarea name="fields[notes]" rows="30" class="form-control" />
                </div>

                <div class="form-group">
                    <label for="complete-list">Related Organisations, Subjects or Publications</label>
                    <p class="help-block">
                        If your account relates to a particular organisation, election, referendum or publication, please let us know.<br />
                        Type in the box below to see suggestions, and click any relevant entries to link them.
                    </p>
                    <input name="complete-list" id="complete-list" type="text" placeholder="Type for suggestions" class="form-control" />
                </div>

                <ul class="associations-list list-group">

                </ul>

                <input id="date" name="fields[date]" type="hidden" value="{/data/params/today}" />
                <input name="fields[status]" type="hidden" value="2834" />
                <select name="fields[associations][]" multiple="multiple" type="hidden" class="hidden">
                </select>
                <p class="help-block">
                Please make sure you are happy for what you've written to be visible on our website before sending.
                </p>
                <input name="action[story]" type="submit" value="Submit" class="btn btn-primary" />
            </form>
        </div>
        <aside class="col-sm-3">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><a href="/personal-accounts/">Personal Accounts</a></h3>
                </div>
                <div class="panel-body">
                    <p>Thanks to those who have already contributed their personal accounts. These are now available to browse on our site.</p>
                </div>
                <div class="panel-footer text-center">
                    <a href="/personal-accounts/" title="Browse personal accounts" class="btn btn-primary">Browse Personal Accounts <span class="fas fa-arrow-right"></span></a>
                </div>
            </div>
        </aside>
    </div>
</xsl:template>

<xsl:template match="events/story">
	<div id="comment-result" class="{@result}">
		<xsl:choose>
			<xsl:when test="@result = 'success'">
                <p class="alert alert-success"><span class="fas fa-check-circle fa-lg"></span> Thanks! Your personal account has been received. Please note these are reviewed before being added to the collection.</p>
                <p class="alert alert-info"><a href="/personal-accounts/" class="alert-link">Browse the personal accounts in our collection</a></p>
			</xsl:when>
			<xsl:otherwise><p class="alert alert-danger"><span class="fas fa-exclamation-triangle fa-lg"></span> Your account was not submitted. Please check you have completed the form correctly and try again.</p>
			</xsl:otherwise>
		</xsl:choose>
	</div>
</xsl:template>

<xsl:template name="page-title">
Submit A Personal Account | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">Send us your personal account of your experience participating in Left politics. The Irish Left Archive hopes to collate first-hand political reminiscences or observations from people involved in Irish Left political activity over the years. We'd be grateful to anyone who has been involved in political parties, campaigns or activism who would like to provide us an account of their personal experience.</xsl:variable>

	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Submit your Personal Account to the Irish Left Archive" />
	<meta property="og:url" content="http://www.leftarchive.ie/personal-accounts/submit/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
    <xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Personal Accounts'" />
		<xsl:with-param name="link" select="'/personal-accounts/'" />
		<xsl:with-param name="position" select="'2'" />
	</xsl:call-template>

	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Submit A Personal Account'" />
		<xsl:with-param name="link" select="'/personal-accounts/submit/'" />
		<xsl:with-param name="position" select="'3'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="end-insert">
	<script src="{/data/params/workspace}/assets/js/accounts.min.js"></script>
</xsl:template>

</xsl:stylesheet>
