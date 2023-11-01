<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/layout-search.xsl"/>
<xsl:import href="../utilities/general-datetime.xsl"/>
<xsl:import href="../utilities/master.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />


<xsl:template match="/">
	<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!DOCTYPE html<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
	<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>404 Page Not Found | <xsl:value-of select="$website-name" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="{$workspace}/assets/css/leftarchive.css?v=20180426" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="text-center">
<h1><xsl:value-of select="$page-title"/></h1>
<p>Sorry, the page you were looking for could not be found.</p>
<p><a href="/">Return to the home page &#187;</a></p>
</div>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
