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
<title>Site Under Maintenance | <xsl:value-of select="$website-name" /></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="{$workspace}/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
				<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700,400italic,700italic|Open+Sans+Condensed:300,700,300italic' rel='stylesheet' type='text/css' />

    <link href="/less/assets/css/styles.less" rel="stylesheet" />
</head>
<body>
<div class="text-center">
<h1><xsl:value-of select="$page-title"/></h1>
<p>Sorry, the Irish Left Archive is temporarily unavailable while we carry out a software upgrade.</p>
<p>It will be available again within an hour.</p>
</div>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
