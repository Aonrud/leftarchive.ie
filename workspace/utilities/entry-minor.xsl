<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="section.xsl"/>
<xsl:import href="meta-redirect.xsl"/>

<!--
##The default template for a minor entry on a redirect page.
#The DS-specific list of 'or' choices is to avoid having a generic 'entry' template that could interfere in other contexts.
#Could alternatively use mode here?
-->
<xsl:template match="organisation-single/entry[minor = 'Yes']|publication-single/entry[minor = 'Yes']|international-single/entry[minor = 'Yes']|person-single/entry[minor = 'Yes']">
	<article>
		<header class="page-header">
			<h1><xsl:value-of select="name" /></h1>
		</header>
		<div class="row">
			<div>
				<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="logo">col-sm-9</xsl:when>
						<xsl:otherwise>col-xs-12</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<h2><span class="fas fa-level-up-alt fa-rotate-90 fa-sm"></span>&#160;
					<a title="For information on {name}, see the {parent/item} page.">
						<xsl:attribute name="href">
							<xsl:call-template name="get-url">
								<xsl:with-param name="id" select="parent/item/@id" />
								<xsl:with-param name="section" select="../section/@handle" />
							</xsl:call-template>
						</xsl:attribute>
						<xsl:value-of select="parent/item" />
					</a>
				</h2>
				<p class="lead text-muted">This is a redirect page. If you are not redirected automatically, please follow the link above.</p>
				<table class="table">
					<tr><th scope="row">Name</th><td><xsl:value-of select="name" /></td></tr>
					
					<!--There is no relationship on some sections.-->
					<xsl:if test="minor-type/item">
						<tr><th scope="row">Relationship</th><td><xsl:value-of select="minor-type/item" /></td></tr>
					</xsl:if>
					<tr><th scope="row">Parent entry</th><td><xsl:value-of select="parent/item" /></td></tr>
				</table>
			</div>
			<xsl:if test="logo">
				<div class="col-sm-3">
				<img src="/image/1/400/0{logo/@path}/{logo/filename}" alt="{name}" about="#org" property="schema:logo" class="img-responsive" />
				</div>
			</xsl:if>
		</div>
	</article>
</xsl:template>

</xsl:stylesheet>
