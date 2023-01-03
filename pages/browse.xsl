<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/layout-sidecolumn.xsl"/>
<xsl:import href="../utilities/page-browse-index.xsl"/>
<xsl:import href="../utilities/master.xsl"/>
<xsl:import href="../utilities/entry-layouts.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template match="data">
    <div class="page-header">
        <h1>
            <xsl:choose>
            <xsl:when test="/data/params/type = 'organisations'">Organisations</xsl:when>
            <xsl:when test="/data/params/type = 'international-organisations'">International Organisations</xsl:when>
            <xsl:when test="/data/params/type = 'publications'">Publications</xsl:when>
            <xsl:when test="/data/params/type = 'people'">People</xsl:when>
            <xsl:otherwise>Full Index</xsl:otherwise>
            </xsl:choose>
        </h1>
    </div>
    
    <p class="lead">
        <xsl:choose>
        <xsl:when test="/data/params/type = 'organisations'">
        All organisations, parties and groups in the archive are listed here alphabetically.
        </xsl:when>
        <xsl:when test="/data/params/type = 'international-organisations'">
        All political internationals and multi-national parties in the archive are listed here alphabetically.
        </xsl:when>
        <xsl:when test="/data/params/type = 'publications'">
        All publications, magazines and periodicals in the archive are listed here alphabetically.
        </xsl:when>
        <xsl:when test="/data/params/type = 'people'">
        All people and authors in the archive are listed here alphabetically.
        </xsl:when>
        <xsl:otherwise>
        Alphabetical index of all organisations, international groups, publications and people in the archive.
        </xsl:otherwise>
        </xsl:choose>
    </p>
    <p>Use the tabs below to show <xsl:if test="/data/params/type != ''">the full index or </xsl:if> the index for each entry type.</p>

    <ul class="nav nav-tabs">
        <li>
			<xsl:if test="not($type)"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
			<a href="/browse/" title="Full Index"><span class="fas fa-bars fa-fw"></span><span class="hidden-xs"> Full Index</span></a>
		</li>
        <li>
			<xsl:if test="$type = 'organisations'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
			<a title="Organisations">
				<xsl:attribute name="href">
					<xsl:text>/browse/organisations/</xsl:text>
					<xsl:if test="/data/params/mode = 'grid'">grid/</xsl:if>
				</xsl:attribute>
				<span class="fas fa-users fa-fw"> </span><span class="hidden-xs"> Organisations</span>
			</a>
		</li>
        <li>
			<xsl:if test="$type = 'international-organisations'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
			<a title="International Organisations">
				<xsl:attribute name="href">
					<xsl:text>/browse/international-organisations/</xsl:text>
					<xsl:if test="/data/params/mode = 'grid'">grid/</xsl:if>
				</xsl:attribute>
				<span class="fas fa-globe-europe fa-fw"> </span><span class="hidden-xs"> International</span>
			</a>
		</li>
        <li>
			<xsl:if test="$type = 'publications'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
			<a title="Publications">
				<xsl:attribute name="href">
					<xsl:text>/browse/publications/</xsl:text>
					<xsl:if test="/data/params/mode = 'grid'">grid/</xsl:if>
				</xsl:attribute>
				<span class="fas fa-newspaper fa-fw"></span><span class="hidden-xs"> Publications</span>
			</a>
		</li>
        <li>
			<xsl:if test="$type = 'people'"><xsl:attribute name="class">active</xsl:attribute></xsl:if>
			<a title="People">
				<xsl:attribute name="href">
					<xsl:text>/browse/people/</xsl:text>
					<xsl:if test="/data/params/mode = 'grid'">grid/</xsl:if>
				</xsl:attribute>
				<span class="fas fa-user fa-fw"></span><span class="hidden-xs"> People</span>
			</a>
		</li>
        <li>
			<a href="/browse/subjects/" title="Subjects"><span class="fas fa-bookmark fa-fw"></span><span class="hidden-xs"> Subjects</span></a>
		</li>
    </ul>
    
    <!--Grid doesn't really work on some sections, so restrict it-->
    <xsl:variable name="grid-allowed">
		<xsl:choose>
			<xsl:when test="/data/params/type = 'organisations' or /data/params/type = 'international-organisations' or /data/params/type = 'people' or /data/params/type = 'publications'">Yes</xsl:when>
			<xsl:otherwise>No</xsl:otherwise>
		</xsl:choose>
    </xsl:variable>
    
    <!--Check which layout mode we are in. Ignore grid mode unless the section accepts it-->
    <xsl:variable name="index-mode">
		<xsl:choose>
			<xsl:when test="/data/params/mode = 'grid' and $grid-allowed = 'Yes'">grid</xsl:when>
			<xsl:otherwise>list</xsl:otherwise>
		</xsl:choose>
    </xsl:variable>
        
    <xsl:if test="/data/params/type = '' or /data/params/type = 'organisations'">
		<p class="alert alert-info segmented"><span class="fas fa-info-circle fa-lg"></span> You can also browse organisations in our <a href="/page/timeline-of-the-irish-left/" class="alert-link">timeline of the Irish left</a>.</p>
    </xsl:if>
        
    <div id="entry-list">
		<xsl:if test="$grid-allowed = 'Yes'">
			<div class="segmented form-inline text-right">
				<xsl:if test="$index-mode = 'grid'">
					<label>
						Filter:
						<input type="search" class="search form-control" />
					</label>
				</xsl:if>
				<div class="btn-group" role="group" aria-label="Page layout">
					<a title="Show entries as a list" href="/browse/{/data/params/type}/">
						<xsl:attribute name="class">
							<xsl:text>btn btn-default</xsl:text>
							<xsl:if test="$index-mode = 'list'"> active</xsl:if>
						</xsl:attribute>
						<span class="fas fa-list"></span>
					</a>
					<a title="Show entries as a grid" href="/browse/{/data/params/type}/grid/">
						<xsl:attribute name="class">
							<xsl:text>btn btn-default</xsl:text>
							<xsl:if test="$index-mode = 'grid'"> active</xsl:if>
						</xsl:attribute>
						<span class="fas fa-th"></span>
					</a>
				</div>
			</div>
		</xsl:if>
		
		<section>
			<xsl:attribute name="class">
				<xsl:text>list segmented</xsl:text>
				<xsl:choose>
					<xsl:when test="$index-mode = 'grid'"> flex-row</xsl:when>
					<xsl:otherwise> text-cols-md</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			
			<!--Decide what index we're on and call the layout-->
			<xsl:choose>
				<xsl:when test="/data/params/type = 'organisations'">
					<xsl:apply-templates select="organisations-list/entry" mode="index-layout">
						<xsl:with-param name="mode" select="$index-mode" />
						<xsl:with-param name="index-key" select="'key-org'" />
						<xsl:sort select="sort-name/@handle" />
					</xsl:apply-templates>
				</xsl:when>
				<xsl:when test="/data/params/type = 'international-organisations'">
					<xsl:apply-templates select="internationals-list/entry" mode="index-layout">
						<xsl:with-param name="mode" select="$index-mode" />
						<xsl:with-param name="index-key" select="'key-int'" />
						<xsl:sort select="sort-name/@handle" />
					</xsl:apply-templates>
				</xsl:when>
				<xsl:when test="/data/params/type = 'publications'">
					<xsl:apply-templates select="publications-list/entry" mode="index-layout">
						<xsl:with-param name="mode" select="$index-mode" />
						<xsl:with-param name="index-key" select="'key-pub'" />
						<xsl:sort select="sort-name/@handle" />
					</xsl:apply-templates>
				</xsl:when>
				<xsl:when test="/data/params/type = 'people'">
					<xsl:apply-templates select="people-list/entry" mode="index-layout">
						<xsl:with-param name="mode" select="$index-mode" />
						<xsl:with-param name="index-key" select="'key-people'" />
						<xsl:sort select="sort-name/@handle" />
					</xsl:apply-templates>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="organisations-list/entry|people-list/entry|publications-list/entry|internationals-list/entry|subjects-list-index/entry" mode="index-layout">
						<xsl:with-param name="mode" select="$index-mode" />
						<xsl:with-param name="index-key" select="'key-all'" />
						<xsl:sort select="sort-name/@handle" />
					</xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>
		</section>
	</div>
</xsl:template>

<xsl:template match="entry" mode="index-layout">
	<xsl:param name="mode" select="'list'" />
	<xsl:param name="index-key" />
	
	<!--Mode attribute can't be dynamically calculated, therefore we explicitly check the value in a <choose>.
		(It stills saves repeating the choose on each call above to have this template)-->
	<xsl:choose>
		<xsl:when test="$mode = 'grid'">
			<xsl:apply-templates select="." mode="grid" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="." mode="index">
				<xsl:with-param name="key" select="$index-key" />
			</xsl:apply-templates>	
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="entry" mode="grid">
	<xsl:apply-templates select="." mode="thumbnail">
		<xsl:with-param name="section-icons" select="'Yes'" />
	</xsl:apply-templates>
</xsl:template>

<xsl:template name="page-title">
	<xsl:text>Browse </xsl:text>
	<xsl:choose>
		<xsl:when test="/data/params/type = 'organisations'"> All Organisations</xsl:when>
		<xsl:when test="/data/params/type = 'international-organisations'"> All International Organisations</xsl:when>
		<xsl:when test="/data/params/type = 'publications'"> All Publications</xsl:when>
		<xsl:when test="/data/params/type = 'people'"> All Authors and People</xsl:when>
		<xsl:otherwise>All Organisations, Internationals, Publications, People and Subjects</xsl:otherwise>
	</xsl:choose>
	<xsl:text> | </xsl:text><xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">
		<xsl:choose>
			<xsl:when test="/data/params/type = 'organisations'">All organisations, parties and groups in the archive are listed here alphabetically.</xsl:when>
			<xsl:when test="/data/params/type = 'international-organisations'">All political internationals and multi-national parties in the archive are listed here alphabetically.</xsl:when>
			<xsl:when test="/data/params/type = 'publications'">All publications, magazines and periodicals in the archive are listed here alphabetically.</xsl:when>
			<xsl:when test="/data/params/type = 'people'">All people and authors in the archive are listed here alphabetically.</xsl:when>
			<xsl:otherwise>Alphabetical index of all organisations, international groups, publications, people and subjects in the archive.</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<meta name="description" content="{$description}" />

	<meta property="og:type" content="article" />
	<meta property="og:title">
		<xsl:attribute name="content">
			<xsl:choose>
				<xsl:when test="/data/params/type = 'organisations'">Index of Organisations in the Irish Left Archive</xsl:when>
				<xsl:when test="/data/params/type = 'international-organisations'">Index of International Organisations in the Irish Left Archive</xsl:when>
				<xsl:when test="/data/params/type = 'publications'">Index of Publications in the Irish Left Archive</xsl:when>
				<xsl:when test="/data/params/type = 'people'">Index of People in the Irish Left Archive</xsl:when>
				<xsl:otherwise>Full Index of the Irish Left Archive</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</meta>
	<meta property="og:url">
		<xsl:attribute name="content"><xsl:value-of select="/data/params/root" />/browse/<xsl:if test="/data/params/type != ''"><xsl:value-of select="/data/params/type" />/</xsl:if></xsl:attribute>
	</meta>
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name">
			<xsl:choose>
				<xsl:when test="/data/params/type = 'organisations'">Browse: Organisations</xsl:when>
				<xsl:when test="/data/params/type = 'international-organisations'">Browse: International Organisations</xsl:when>
				<xsl:when test="/data/params/type = 'publications'">Browse: Publications</xsl:when>
				<xsl:when test="/data/params/type = 'people'">Browse: People</xsl:when>
				<xsl:otherwise>Browse</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="link">
			<xsl:text>/browse/</xsl:text>
			<xsl:if test="/data/params/type != ''"><xsl:value-of select="/data/params/type" />/</xsl:if>
		</xsl:with-param>
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="end-insert">
    <script type="text/javascript">
		var indexList = new List('entry-list', { 
				valueNames: ['name', 'organisations', 'publications'],
			});
	</script>
</xsl:template>
	
</xsl:stylesheet>
