<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="dc">

<xsl:import href="../utilities/master.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:variable name="title">Timeline of Left Periodicals</xsl:variable>
<xsl:variable name="description">A timeline of periodicals, papers and journals published by Irish Left parties and organisations.</xsl:variable>

<xsl:template name="viewport">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
</xsl:template>

<xsl:template match="data">
	<div class="page-container">
		<div id="diagram">
			
			<div class="info timeline-exclude">
				<h3>Timeline of Left Periodicals</h3>
				<p>A timeline of periodicals, papers and journals published by Irish Left parties and organisations.</p>
				<p><em>Last updated 9th April, 2022</em></p>
			</div><!--info-->
			
			<div id="DN" data-start="1944" data-colour="#00F">David Norris</div>
			
			<div id="LAB" data-ila-id="122" data-start="1967" data-end="1970" data-end-estimate="true" data-row="1" data-colour="#b22410">Labour</div>
			<div id="TILT" data-ila-id="163" data-start="1994" data-end="1999" data-end-estimate="true" data-row="1" data-colour="#b22410">TILT: The Irish Labour Tribune</div>
			
			<div id="SPECTRE" data-ila-id="1317" data-start="1967" data-end="1968" data-end-estimate="true" data-row="2" data-colour="#b22410">Spectre</div>
			<div id="LNB" data-ila-id="123" data-start="1970" data-end="1972" data-end-estimate="true" data-row="2" data-colour="#b22410">Labour News Bulletin</div>
			<div id="LL" data-ila-id="2924" data-start="1983" data-end="1985" data-end-estimate="true" data-row="2" data-colour="#b22410">Labour Left</div>
			
			<div id="LT" data-ila-id="3347" data-start="1986" data-row="3" data-colour="#b22410">Left Tribune</div>
			
			<div id="TC" data-ila-id="164" data-start="1994" data-end="2000" data-end-estimate="true" data-row="4" data-colour="#f00">Times Change</div>
		
			<div id="MIL" data-ila-id="129" data-start="1972" data-end="1989" data-row="5" data-colour="#ec3206">Militant</div>
			<div id="TSOL" data-start="1990" data-row="5" data-colour="#ec3206">The Socialist</div>
			
			<div id="DWILN" data-ila-id="2380" data-start="1992" data-end="1993" data-end-estimate="true" data-row="6" data-colour="#ec3206">Dublin West Independent Labour News</div>
			<div id="S2000" data-ila-id="2273" data-start="1998" data-become="SVIEW" data-row="6" data-colour="#ec3206">Socialism 2000</div>
			<div id="SVIEW" data-start="2000" data-become="SOC-ALT" data-row="6" data-colour="#ec3206">Socialist View</div>
			<div id="SOC-ALT" data-start="2018" data-row="6" data-colour="#ec3206">Socialist Alternative</div>
			
			<div id="UI" data-ila-id="166" data-start="1948" data-end="1980" data-row="6" data-colour="#040">The United Irishman</div>
			
			<div id="AT" data-ila-id="106" data-start="1967" data-end="1970" data-end-estimate="true" data-row="7" data-colour="#040">An tÓglách</div>
			<div id="CAORTHANN" data-ila-id="3100" data-start="1994" data-end="1998" data-row="7" data-colour="#00755B">An Caorthann</div>
			
			<div id="IP" data-ila-id="151" data-start="1973" data-end="1991" data-row="8" data-colour="#f00">The Irish People</div>
			<div id="RUPTURE" data-start="2020" data-row="8">Rupture</div>
			
			<div id="TEOIRIC" data-ila-id="149" data-start="1971" data-end="1980" data-end-estimate="true" data-row="9" data-colour="#f00">Teoiric</div>
			<div id="IRELAND" data-ila-id="1130" data-start="1981" data-end="1987" data-end-estimate="true" data-row="9" data-colour="#f00">Ireland</div>
			
			<div id="RC" data-ila-id="1864" data-start="1972" data-end="1975" data-end-estimate="true" data-row="10" data-colour="#f00">Rosc Catha</div>
			<div id="WV" data-ila-id="1559" data-start="1980" data-end="1989" data-end-estimate="true" data-row="10" data-colour="#f00">Women's View</div>
			<div id="SD" data-ila-id="142" data-start="1991" data-end="1992" data-end-estimate="true" data-row="10" data-colour="#f00">Socialist Digest</div>
			<div id="LL" data-ila-id="4744" data-start="2006" data-row="10" data-colour="#f00">Look Left</div>
			
			<div id="MS" data-ila-id="124" data-start="1988" data-end="1992" data-row="11" data-colour="#f00">Making Sense</div>
						
			<div id="AE" data-ila-id="2841" data-start="1973" data-end="1977" data-end-estimate="true" data-row="12" data-colour="#f00">An Eochair</div>
			
			<div id="TP" data-ila-id="155" data-start="1973" data-end="1978" data-end-estimate="true" data-row="13" data-colour="#f00">The Plough</div>
			
			<div id="RESISTANCE-TCD" data-ila-id="140" data-start="1970" data-end="1973" data-end-estimate="true" data-row="14" data-colour="#f00">Resistance [TCD Republican Clubs]</div>
			<div id="RW" data-ila-id="138" data-start="1974" data-end="1976" data-end-estimate="true" data-row="14" data-colour="#f00">Republican Worker</div>
			
			<div id="TSP-OSFD" data-ila-id="160" data-start="1972" data-end="1974" data-end-estimate="true" data-row="15" data-colour="#f00">The Starry Plough [OSF Derry]</div>
						
			<div id="TSP-IRSP" data-ila-id="161" data-start="1975" data-row="16" data-colour="#8AA3FF">The Starry Plough</div>
			
			<div id="V" data-ila-id="167" data-start="1981" data-end="1982" data-end-estimate="true" data-row="17" data-colour="#8AA3FF">Venceremos</div>
			<div id="FS" data-ila-id="4982" data-start="1985" data-end="1985" data-row="17" data-colour="#8AA3FF">Freedom Struggle</div>
			
			<div id="HSB" data-ila-id="121" data-start="1980" data-end="1981" data-end-estimate="true" data-row="18" data-colour="#8AA3FF">Hunger Strike Bulletin</div>
			<div id="FN" data-ila-id="113" data-start="1985" data-end="1986" data-end-estimate="true" data-row="18" data-colour="#8AA3FF">Freedom News</div>
			
			<div id="RN" data-ila-id="137" data-start="1970" data-end="1979" data-row="19" data-merge="AP" data-colour="#080">Republican News</div>
			<div id="IRIS" data-ila-id="118" data-start="1981" data-end="1993" data-row="19" data-colour="#080">Iris</div>
			<div id="IRIS2" data-ila-id="118" data-start="2005" data-row="19" data-links="IRIS" data-colour="#080">Iris</div>
			
			<div id="AP" data-ila-id="102" data-start="1970" data-end="2017" data-row="20" data-colour="#080">An Phoblacht</div>
			
			<div id="TSP-SF" data-ila-id="101" data-start="1991" data-end="1994" data-end-estimate="true" data-row="21" data-colour="#080">The Starry Plough [SF]</div>
			
			<div id="RB" data-ila-id="1590" data-start="1986" data-end="1987" data-become="SAOIRSE" data-row="22">Republican Bulletin</div>
			<div id="SAOIRSE" data-ila-id="1591" data-start="1987" data-row="22">Saoirse: Irish Freedom</div>
			
			<div id="YR" data-ila-id="4313" data-start="2003" data-end="2004" data-end-estimate="true" data-row="23">Young Republican</div>
			<div id="APA" data-ila-id="4461" data-start="2019" data-row="23" data-colour="#1c882c">An Phoblacht Abú</div>
			
			<div id="FORUM" data-ila-id="4207" data-start="2003" data-end="2006" data-row="24" data-colour="#333">Forum</div>
			<div id="PnanO" data-ila-id="634" data-start="2012" data-end="2014" data-end-estimate="true" data-row="24" data-colour="#0faf4d">Poblacht na nOibrithe</div>
		
			<div id="IS" data-ila-id="120" data-start="1965" data-end="1989" data-end-estimate="true" data-row="25" data-colour="#c00">Irish Socialist</div>
			<div id="SV" data-start="1991" data-row="25" data-colour="#c00">Socialist Voice</div>
			
			<div id="ISR" data-ila-id="2467" data-start="1970" data-end="1991" data-end-estimate="true" data-row="26" data-irregular="true" data-colour="#c00">Irish Socialist Review</div>
			
			<div id="U" data-ila-id="4235" data-start="1961" data-row="27" data-colour="#c00">Unity</div>
			
			<div id="MR" data-ila-id="126" data-start="1972" data-end="1974" data-end-estimate="true" data-row="28">Marxist Review</div>
			<div id="TBD" data-ila-id="42" data-start="1975" data-end="1981" data-end-estimate="true" data-row="28">The Bottom Dog</div>
			
			<div id="PLOUGH" data-start="1971" data-end="1974" data-row="29">The Plough</div>
			<div id="SR" data-ila-id="143" data-start="1975" data-end="1983" data-end-estimate="true" data-links="PLOUGH" data-row="29">Socialist Republic</div>
			
			<div id="FC" data-start="1969" data-end="1971" data-become="UC" data-row="30">Free Citizen</div>
			<div id="UC" data-ila-id="165" data-start="1971" data-end="1978" data-end-estimate="true" data-row="30">Unfree Citizen</div>
			<div id="AR" data-ila-id="104" data-start="1986" data-end="1992" data-end-estimate="true" data-row="30">An Reabhloid</div>
			
			<div id="TW" data-ila-id="162" data-start="1971" data-become="SW" data-row="31" data-colour="#fe052d">The Worker</div>
			<div id="SW" data-ila-id="1313" data-start="1984" data-end="2018" data-row="31" data-colour="#fe052d">Socialist Worker</div>
			
			<div id="RESISTANCE-SWP" data-ila-id="4811" data-start="2001" data-end="2005" data-end-estimate="true" data-row="32" data-colour="#fe052d">Resistance [SWP]</div>
			<div id="NLJ" data-ila-id="2773" data-start="2006" data-end="2007" data-end-estimate="true" data-row="32" data-colour="#fe052d">New Left Journal</div>
			
			<div id="CS" data-ila-id="1183" data-start="1977" data-end="1995" data-row="32" data-colour="#ccc">Class Struggle</div>
			
			<div id="FIGHTBACK" data-ila-id="1828" data-start="1992" data-end="1993" data-end-estimate="true" data-row="33" data-colour="#ccc">Fightback</div>
			
			<div id="ADVANCE" data-ila-id="99" data-start="1971" data-end="1976" data-row="33">Advance</div>
			<div id="SUPERSPI" data-ila-id="148" data-start="1977" data-end="1978" data-end-estimate="true" data-row="33">SuperSpi</div>
			
			<div id="LS" data-ila-id="4176" data-start="1972" data-end="1981" data-row="34">Limerick Socialist</div>
			
			<div id="TCOM" data-ila-id="150" data-start="1967" data-end="1986" data-row="35" data-colour="#555">The Communist</div>
			
			<div id="TIC" data-ila-id="68" data-start="1965" data-end="1986" data-become="IPR" data-row="36" data-colour="#555">The Irish Communist</div>
			<div id="IPR" data-ila-id="39" data-start="1986" data-row="36" data-colour="#555">Irish Political Review</div>
			
			<div id="ComCom" data-ila-id="2499" data-start="1969" data-end="1973" data-become="COMMENT" data-row="37" data-colour="#555">Communist Comment</div>
			<div id="COMMENT" data-ila-id="2321" data-start="1973" data-end="1983" data-end-estimate="true" data-row="37" data-colour="#555">Comment</div>
			
			<div id="WW" data-ila-id="171" data-start="1972" data-end="1988" data-become="TNS" data-row="38" data-colour="#555">Workers' Weekly</div>
			<div id="TNS" data-ila-id="2523" data-start="1988" data-end="2010" data-end-estimate="true" data-row="38" data-colour="#555">The Northern Star</div>
			
			<div id="PROL" data-ila-id="156" data-start="1974" data-end="1977" data-end-estimate="true" data-row="39">Proletarian</div>
			
			<div id="WaC" data-ila-id="1271" data-start="1967" data-end="1968" data-end-estimate="true" data-row="39" data-colour="#955">Words and Comment</div>
			<div id="SOF" data-ila-id="159" data-start="1982" data-end="1990" data-end-estimate="true" data-row="39" data-colour="#955">Spirit of Freedom</div>
			
			<div id="TIS" data-ila-id="152" data-start="1967" data-end="1973" data-end-estimate="true" data-row="40" data-colour="#955">The Irish Student</div>
			<div id="WaUN" data-ila-id="168" data-start="1987" data-end="1988" data-end-estimate="true" data-row="40" data-colour="#955">Workers' &amp; Unemployed News</div>
			
			<div id="RP" data-ila-id="71" data-start="1969" data-end="1984" data-become="VOR" data-row="41" data-colour="#955">Red Patriot</div>
			<div id="VOR" data-ila-id="128" data-start="1984" data-end="1985" data-become="MLW" data-row="41" data-colour="#955">Voice of Revolution</div>
			<div id="MLW" data-ila-id="128" data-start="1985" data-end="1991" data-end-estimate="true" data-row="41" data-colour="#955">Marxist-Leninist Weekly</div>
			
			<div id="MLJ" data-ila-id="127" data-start="1988" data-end="1989" data-end-estimate="true" data-row="42" data-colour="#955">Marxist-Leninist Journal</div>
			<div id="NQ" data-ila-id="36" data-start="2002" data-end="2013" data-irregular="true" data-row="42">No Quarter</div>
			
			<div id="OC" data-start="1980" data-end="1984" data-row="43">Outta Control</div>
			<div id="AINRIAIL" data-ila-id="100" data-start="1985" data-end="1987" data-row="43">Ainriail [Belfast]</div>
			<div id="AINRIAIL2" data-ila-id="27" data-start="1995" data-end="1996" data-end-estimate="true" data-row="43">Ainriail [Galway]</div>
			
			<div id="ORGANISE" data-start="1986" data-end="1997" data-end-estimate="true" data-row="44">Organise!</div>
			<div id="SOLIDARITY" data-start="2002" data-end="2007" data-end-estimate="true" data-row="44">Solidarity</div>
			
			<div id="ANTRIM" data-start="1985" data-end="1985" data-end-estimate="true" data-row="45">Antrim Alternative</div>
			<div id="RW" data-start="1998" data-end="1999" data-end-estimate="true" data-row="45">Rebel Worker</div>
			<div id="WCR" data-ila-id="3538" data-start="2007" data-end="2008" data-end-estimate="true" data-row="45">Working Class Resistance</div>
			<div id="LEVELLER" data-ila-id="2889" data-start="2009" data-row="45">The Leveller</div>
			
			<div id="BS" data-ila-id="5095" data-start="1981" data-end="1984" data-irregular="true" data-row="46">Black Star</div>
			<div id="BS2" data-ila-id="5095" data-start="2021" data-links="BS" data-row="46">Black Star</div>
			
			<div id="WS" data-ila-id="2344" data-start="1984" data-end="2013" data-end-estimate="true" data-row="47">Workers Solidarity</div>
			
			<!--Resistance - Anarchist Bookshop Collective-->
			<div id="RESISTANCE-ABC" data-ila-id="5097" data-start="1980" data-end="1980" data-row="48">Resistance</div>
			<div id="RESISTANCE-DAC" data-ila-id="5098" data-start="1983" data-end="1983" data-row="48">Resistance</div>
			<div id="RaBR" data-ila-id="3850" data-start="1994" data-end="2009" data-row="48">Red and Black Revolution</div>
			<div id="IAR" data-start="2010" data-end="2015" data-links="RaBR" data-row="48">Irish Anarchist Review</div>
			
			<div id="AW" data-ila-id="33" data-start="1978" data-end="1981" data-row="49">Anarchist Worker</div>
			<div id="AN" data-ila-id="2987" data-start="1994" data-end="2005" data-end-estimate="true" data-row="49">Anarchist News</div>
			
			<div id="WA" data-ila-id="627" data-start="1976" data-end="1979" data-end-estimate="true" data-row="50">Women's Action</div>
			
			<div id="SB" data-ila-id="5096" data-start="1978" data-end="1980" data-row="51">Saorbhean: Free Woman</div>
			
			<div id="FSJ" data-ila-id="2460" data-start="1972" data-end="1974" data-row="52">Fownes Street Journal</div>
			<div id="BANSHEE" data-ila-id="1893" data-start="1975" data-end="1977" data-row="52">Banshee</div>
			
			<div id="YB" data-ila-id="5093" data-start="1970" data-end="1972" data-row="53">Youth Bulletin</div>
		</div><!--diagram-->
			
		<div class="controls">
			<form id="timeline-find">
				<label for="finder" class="sr-only">Find a publication</label>
				<input type="text" name="finder" class="form-control" placeholder="Type to search for publications" aria-label="Type to search for publications" />
			</form>
			<div class="btn-group" role="group" aria-label="Diagram Zoom Controls">
				<button id="timeline-zoom-out" type="button" class="btn btn-default btn-sm" title="Zoom out" aria-label="Zoom out"><span class="fas fa-search-minus"></span></button>
				<button id="timeline-zoom-reset" type="button" class="btn btn-default btn-sm" title="Reset zoom" aria-label="Reset zoom"><span class="fas fa-times-circle"></span></button>
				<button id="timeline-zoom-in" type="button" class="btn btn-default btn-sm" title="Zoom in" aria-label="Zoom in"><span class="fas fa-search-plus"></span></button>
			</div>
		</div><!--controls-->
	</div><!--page-container-->
</xsl:template>

<xsl:template name="head-insert">
	<link href="/workspace/assets/css/timeline.min.css?v=20210917" rel="stylesheet" type="text/css" />
</xsl:template>

<xsl:template name="end-insert">
	<script src="/workspace/assets/js/timeline.min.js"></script>
	<script>
		const tl = new Timeline("diagram", { 
			entrySelector: "div",
			panzoom: true,
			yearStart: 1935
			});
		tl.create();
		
		const diagram = document.getElementById("diagram");
		new PopoverWrapper(diagram.querySelectorAll("div[data-ila-id]"), "publication");

		diagram.addEventListener('timelineFind', (e) => {
			e.target.querySelector(`#${e.detail.id}`)._tippy.show();
			_paq.push(['trackEvent', 'Timeline', 'Search', e.detail.name]);
		});
		
		document.querySelectorAll("[data-toggle-target]").forEach( (el) => new Toggler(el, el.dataset.toggledText) );
	</script>
</xsl:template>

<xsl:template name="metadata-image">
	<meta property="og:image" content="{/data/params/workspace}/images/timeline.png" />
	<meta property="og:image:width" content="1848" />
	<meta property="og:image:height" content="892" />
</xsl:template>

<xsl:variable name="metadata-twitter-card">summary_large_image</xsl:variable>

<xsl:template name="metadata-general">
	<meta name="description" content="{$description}" />
	<meta property="og:type" content="article" />
	<meta property="og:title" content="{$title}" />
	<meta property="og:url" content="{/data/params/root}/{/data/params/current-path}/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="$title" /> | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

</xsl:stylesheet>
