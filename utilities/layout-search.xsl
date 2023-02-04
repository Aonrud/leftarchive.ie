<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="search-form" mode="full">
    <xsl:param name="collapse" select="'no'" />
    <div id="advanced-search" class="panel panel-primary">
        <xsl:if test="$collapse = 'yes'"><xsl:attribute name="class">panel panel-primary panel-collapse collapse</xsl:attribute></xsl:if>
        
        <div class="panel-heading">
            <h3 class="panel-title"><span class="fas fa-search"></span> Advanced Search</h3> <a id="search-tips" href="javascript:;" data-toggle="popover" data-placement="bottom" class="pull-right">Search tips <span class="caret"></span></a>
        </div>
        
        <div class="panel-body">
            <form role="form" action="/search/" method="get">
                <div class="form-group">
                    <div class="input-group">
                    <label for="keywords" class="sr-only">Search </label>
                    <input type="search" id="keywords" name="keywords" placeholder="search" class="form-control"><xsl:attribute name="value"><xsl:value-of select="/data/params/url-keywords" /></xsl:attribute></input>
                    <span class="input-group-btn"><button type="submit" class="btn  btn-primary"><span class="fas fa-search"> </span> Search</button></span>
                    </div>
                </div>

                <div class="form-group">
                    <fieldset id="checkboxes">
                        <legend>Search Sections</legend>
                        <div>
                            <label>
                                <input type="checkbox" name="sections[]" id="colCheck" value="collections"><xsl:choose><xsl:when test="/data/search/sections and not(/data/search/sections/section[@id = '17'])"></xsl:when><xsl:otherwise><xsl:attribute name="checked">checked</xsl:attribute></xsl:otherwise></xsl:choose></input> <xsl:call-template name="section-icon"><xsl:with-param name="section-id" select="'17'" /></xsl:call-template>Collections
                            </label>
                            <label>
                                <input type="checkbox" name="sections[]" id="demoCheck" value="demonstrations"><xsl:choose><xsl:when test="/data/search/sections and not(/data/search/sections/section[@id = '46'])"></xsl:when><xsl:otherwise><xsl:attribute name="checked">checked</xsl:attribute></xsl:otherwise></xsl:choose></input> <xsl:call-template name="section-icon"><xsl:with-param name="section-id" select="'46'" /></xsl:call-template>Demonstrations
                            </label>
                            <label>
                                <input type="checkbox" name="sections[]" id="docCheck" value="documents"><xsl:choose><xsl:when test="/data/search/sections and not(/data/search/sections/section[@id = '6'])"></xsl:when><xsl:otherwise><xsl:attribute name="checked">checked</xsl:attribute></xsl:otherwise></xsl:choose></input> <xsl:call-template name="section-icon"><xsl:with-param name="section-id" select="'6'" /></xsl:call-template>Documents
                            </label>
                            <label>
                                <input type="checkbox" name="sections[]" id="intCheck" value="international"><xsl:choose><xsl:when test="/data/search/sections and not(/data/search/sections/section[@id = '24'])"></xsl:when><xsl:otherwise><xsl:attribute name="checked">checked</xsl:attribute></xsl:otherwise></xsl:choose></input> <xsl:call-template name="section-icon"><xsl:with-param name="section-id" select="'24'" /></xsl:call-template>International
                            </label>
                            <label>
                                <input type="checkbox" name="sections[]" id="peopleCheck" value="people"><xsl:choose><xsl:when test="/data/search/sections and not(/data/search/sections/section[@id = '19'])"></xsl:when><xsl:otherwise><xsl:attribute name="checked">checked</xsl:attribute></xsl:otherwise></xsl:choose></input> <xsl:call-template name="section-icon"><xsl:with-param name="section-id" select="'19'" /></xsl:call-template>People
                            </label>
                            <label>
                                <input type="checkbox" name="sections[]" id="pubCheck" value="publications"><xsl:choose><xsl:when test="/data/search/sections and not(/data/search/sections/section[@id = '5'])"></xsl:when><xsl:otherwise><xsl:attribute name="checked">checked</xsl:attribute></xsl:otherwise></xsl:choose></input> <xsl:call-template name="section-icon"><xsl:with-param name="section-id" select="'5'" /></xsl:call-template>Publications
                            </label>
                            <label>
                                <input type="checkbox" name="sections[]" id="orgCheck" value="organisations"><xsl:choose><xsl:when test="/data/search/sections and not(/data/search/sections/section[@id = '4'])"></xsl:when><xsl:otherwise><xsl:attribute name="checked">checked</xsl:attribute></xsl:otherwise></xsl:choose></input> <xsl:call-template name="section-icon"><xsl:with-param name="section-id" select="'4'" /></xsl:call-template>Organisations
                            </label>
                            <label>
                                <input type="checkbox" name="sections[]" id="subCheck" value="subjects"><xsl:choose><xsl:when test="/data/search/sections and not(/data/search/sections/section[@id = '31'])"></xsl:when><xsl:otherwise><xsl:attribute name="checked">checked</xsl:attribute></xsl:otherwise></xsl:choose></input> <xsl:call-template name="section-icon"><xsl:with-param name="section-id" select="'31'" /></xsl:call-template>Subjects
                            </label>
                        </div>
                        <button type="button" id="selectAll" class="btn btn-link">Select All</button>
                        <button type="button" id="selectNone" class="btn btn-link">Deselect All</button>
                    </fieldset>
                </div>
            
                <div class="form-group">
                    <!--slider-->
                    <p><span class="legend">Years: </span> <span id="years"></span></p>
                    <div class="col-xs-12">
                        <input id="year-slider" />
                    </div>
                    
                    <!--Fallback to simple inputs-->
                    <div class="row" id="slider-fallback">
                        <div class="col-md-2 col-sm-3 col-xs-4">
                        <label for="year1" class="sr-only">From</label><input type="text" id="year1" name="year1" placeholder="From" class="form-control"><xsl:attribute name="value"><xsl:value-of select="/data/params/url-year1" /></xsl:attribute></input>
                    </div>
                    <div class="col-md-2 col-sm-3 col-xs-4">
                        <label for="year2" class="sr-only">to</label><input type="text" id="year2" name="year2" placeholder="To" class="form-control"><xsl:attribute name="value"><xsl:value-of select="/data/params/url-year2" /></xsl:attribute></input>
                    </div>
                </div>
            </div>
            </form>
    </div>
    </div>
    <div id="tips-head" class="hide">Search Tips</div>
    <div id="tips-content" class="hide">
    <p>For more precise searches, try the following:</p>
    <ul><li><strong>"Exact Phrase"</strong> - use quotes to search for an exact phrase.<br />
    <span class="text-muted">Example: <a href="/search/?keywords=%22red+action%22&amp;sections=documents&amp;year1=&amp;year2=" rel="nofollow">"red action"</a></span>
    </li>
    <li><strong>+keyword</strong> - only results that include this keyword.<br />
    <span class="text-muted">Example: <a href="/search/?keywords=%22red+action%22+%2Blockout&amp;sections=documents&amp;year1=&amp;year2=" rel="nofollow">"red action" +lockout</a></span>
    </li>
    <li><strong>-keyword</strong> - exclude results that match this keyword.<br />
    <span class="text-muted">Example: <a href="/search/?keywords=%22red+action%22+-lockout&amp;sections=documents&amp;year1=&amp;year2=" rel="nofollow">"red action" -lockout</a></span>
    </li>
    </ul>
    </div>
</xsl:template>

<!-- For xs and sm search form, below menu-->
<xsl:template name="search-small">
    <form role="search" action="/search/" method="get">
        <label class="sr-only" for="s2-keywords">Search</label>
        <div class="input-group">
            <input id="s2-keywords" name="keywords" placeholder="Search" class="form-control" type="search" />
            <span class="input-group-btn"><button type="submit" class="btn btn-primary"><span class="fas fa-search"> </span></button></span>
        </div>
    </form>
    <p></p>
</xsl:template>

</xsl:stylesheet>
