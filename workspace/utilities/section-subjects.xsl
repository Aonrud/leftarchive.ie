<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="subjects-table">
    <tr><th scope="row"><span class="fas fa-bookmark fa-fw"></span> Subjects:</th><td><xsl:apply-templates select="/data/document-single/entry/subjects/item" /> <xsl:call-template name="subject-suggestion-form" /></td></tr>
</xsl:template>

<xsl:template match="subjects/item">

    <xsl:variable name="group-icon">
        <xsl:call-template name="subjects-group-icon">
            <xsl:with-param name="group-handle" select="group/item/@handle" />
        </xsl:call-template>
    </xsl:variable>
    
    <a href="/subject/{@id}/" title="{group/item} - {name}" class="btn btn-default btn-subject"><span class="text-muted fas fa-{$group-icon}"></span>&#8194;<xsl:value-of select="name" /></a>&#8197;
</xsl:template>

<xsl:template match="subjects/item[linked/item]">
    <xsl:variable name="path">
        <xsl:choose>
            <xsl:when test="linked/item/@section-handle = 'organisations'">/organisation</xsl:when>
            <xsl:when test="linked/item/@section-handle = 'people'">/people</xsl:when>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="group-icon">
        <xsl:call-template name="subjects-group-icon">
            <xsl:with-param name="group-handle" select="group/item/@handle" />
        </xsl:call-template>
    </xsl:variable>
    
    <a href="{$path}/{linked/item/@id}/" title="{group/item} - {name}" class="btn btn-default btn-subject"><span class="text-muted fas fa-{$group-icon}"></span>&#8194;<xsl:value-of select="name" /></a>&#8197;
    
</xsl:template>

<xsl:template name="subjects-group-icon">
    <xsl:param name="group-handle" />
    <xsl:param name="group" />
    <xsl:choose>
        <xsl:when test="$group = 'Policy Area' or $group-handle = 'policy-area'">list-ol</xsl:when>
        <xsl:when test="$group = 'Event' or $group-handle = 'event'">calendar</xsl:when>
        <xsl:when test="$group = 'Election' or $group-handle = 'election'">calendar-check</xsl:when>
        <xsl:when test="$group = 'Referendum' or $group-handle = 'referendum'">calendar-check</xsl:when>
        <xsl:when test="$group = 'Organisation' or $group-handle = 'organisation'">users</xsl:when>
        <xsl:when test="$group = 'People' or $group-handle = 'people'">user</xsl:when>
        <xsl:when test="$group = 'International Affairs' or $group-handle = 'international-affairs'">globe-europe</xsl:when>
        <xsl:when test="$group = 'Local' or $group-handle = 'local'">map-marker</xsl:when>
    </xsl:choose>
</xsl:template>

<xsl:template name="subject-suggestion-form">
    <button type="button" title="Suggest a subject" class="btn btn-success btn-subject" data-toggle="collapse" data-target="#subject-suggestion" aria-expanded="false" aria-controls="subject-suggestion"><span class="fas fa-plus"></span> Suggest a subject</button>&#8197;
    <div id="subject-suggestion" class="collapse">
        <form id="subject-suggestion-form" method="post" action="" enctype="multipart/form-data">
            <label class="sr-only" for="fields[suggestion]">Suggested subject</label>
            <div class="input-group">
                <input id="suggestion" name="fields[suggestion]" type="text" class="form-control" autocomplete="off" placeholder="Begin typing to select an existing subject, or suggest a new one."></input>
                <input name="fields[associated]" type="hidden" value="{$id}" />
                <span class="input-group-btn"><button type="submit" name="action[subject-suggestion]" class="btn btn-primary">Suggest</button></span>
            </div>
        </form>
    </div>
</xsl:template>

</xsl:stylesheet>
