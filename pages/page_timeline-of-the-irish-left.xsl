<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="dc">

<xsl:import href="../utilities/master.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:variable name="title">Timeline of the Irish Left</xsl:variable>
<xsl:variable name="description">A timeline of the development of left wing political groups and parties in Ireland from 1900 to the present, from the Irish Left Archive.</xsl:variable>

<xsl:template name="viewport">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
</xsl:template>

<xsl:template match="data">
	<div class="page-container">
		<div id="diagram">
			
			<div class="info timeline-exclude">
				<h3>Timeline of the Irish Left</h3>
				<p>This diagram shows the historical development of left political groups and parties since the beginning of the 20th Century in Ireland.</p>
				<div class="alert-info alert"><p><a href="/information/about-the-timeline/" class="alert-link">About the timeline <span class="fa fa-angle-double-right"></span></a></p>
				<p><em>Last updated 11th February, 2023</em></p>
				</div>
				<button class="btn btn-link" data-toggle-target="legend" data-toggle-text="Hide Legend "><span class="toggle-text">Show Legend </span><span class="caret"></span></button>
				<div id="legend">
					<ul class="media-list">
						<li class="media">
							<img class="pull-right media-object" src="/workspace/assets/images/timeline/legend-dashed.png" alt="Dashed diagram line" />
							<div class="media-body">Dashed lines indicate links between groups, either through membership or cooperation.</div>
						</li>
						<li class="media">
							<img class="pull-right media-object" src="/workspace/assets/images/timeline/legend-estimate.png" alt="Estimated end indicator" />
							<div class="media-body">Where an organisation's dissolution date is estimated, it is marked with a double line.</div>
						</li>
						<li class="media">
							<img class="pull-right media-object" src="/workspace/assets/images/timeline/legend-linknode.png" alt="Linked diagram entry" />
							<div class="media-body">Click on grey entries for more information. (Light entries are not currently in the archive).</div>
						</li>
						<li class="media">
							<img class="pull-right media-object" src="/workspace/assets/images/timeline/legend-hover.png" alt="Diagram entry with truncated name" />
							<div class="media-body">Some names are shortened. Hover over any entry to reveal the full name.</div>
						</li>
						<li class="media">
							<img class="pull-right media-object" src="/workspace/assets/images/timeline/legend-circle.png" alt="Circular diagram entry" />
							<div class="media-body">Circular entries are concealed for space.  Hover over these to show them in full.</div>
						</li>
						<li class="media">
							<img class="pull-right media-object" src="/workspace/assets/images/timeline/legend-colour.png" alt="Coloured diagram entry" />
							<div class="media-body">Colours are for visual clarity, and may not represent the party/group.</div>
						</li>
					</ul>
				</div>
			</div><!--info-->
			
			<div id="WSM" data-ila-id="1445" data-start="1984" data-end="2021" data-row="0">Workers' Solidarity Movement (WSM)</div>
		
			<div id="WSPL" data-start="1930" data-end="1945" data-end-estimate="true" data-row="1">Women's Social and Progressive League</div>
			<div id="BAG" data-ila-id="4848" data-start="1968" data-become="BLG" data-row="1">Belfast Anarchist Group</div>
			<div id="BLG" data-ila-id="4848" data-start="1973" data-end="1974" data-row="1">Belfast Libertarian Group</div>
			<div id="AWA" data-ila-id="32" data-start="1979" data-links="BAC DAG" data-end="1982" data-row="1">Anarchist Workers' Alliance</div>
			<div id="CAWG" data-ila-id="6301" data-start="1984" data-merge="WSM" data-end="1984">Cork Anarchist Workers Group</div>
			<div id="AFA" data-ila-id="35" data-start="1991" data-row="1" data-links="RA">Anti-Fascist Action (Ireland)</div>
			<div id="DAG" data-ila-id="1410" data-start="1978" data-end="1979" data-row="2">Dublin Anarchist Group</div>
			<div id="ABC" data-ila-id="1411" data-start="1980" data-end="1981" data-row="2">Anarchist Bookshop Collective</div>
			<div id="DAC" data-ila-id="1412" data-start="1982" data-row="2" data-end="1985" data-end-estimate="true">Dublin Anarchist Collective</div>
			<div id="RA" data-ila-id="1438" data-start="1990" data-end="1997" data-row="2">Red Action</div>
			<div id="WCA" data-ila-id="1439" data-start="2001" data-end="2005" data-end-estimate="true" data-row="2" data-links="RA">Working Class Action</div>
			<div id="IMTI" data-ila-id="1871" data-start="2009" data-row="2">International Marxist Tendency in Ireland</div>


			<div id="FSR" data-start="1930" data-end="1931" data-row="3">Friends of Soviet Russia</div>
			<div id="BAC" data-ila-id="175" data-start="1978" data-end="1990" data-row="3" data-end-estimate="true">Belfast Anarchist Collective</div>
			<div id="AFI" data-ila-id="1484" data-start="1995" data-row="3" data-merge="SolFed" data-end="2003">Anarchist Federation in Ireland</div>
			<div id="RAG" data-ila-id="1477" data-start="2005" data-row="3" data-end="2014" data-end-estimate="true">Revolutionary Anarcha-Feminist Group (RAG)</div>

			<div id="SWG" data-ila-id="1446" data-start="1975" data-row="4" data-become="BWC">Socialist Women's Group</div>
			<div id="BWC" data-ila-id="628" data-start="1977" data-row="4" data-end="1980">Belfast Women's Collective</div>
			<div id="BAG2" data-ila-id="1768" data-start="1981" data-row="4" data-become="organise">Ballymena Anarchist Group</div>
			<div id="organise" data-ila-id="1486" data-start="1992" data-row="4" data-become="SSN">Organise!</div>
			<div id="SSN" data-ila-id="1486" data-start="1999" data-row="4" data-become="OASF">Syndicalist Solidarity Network</div>
			<div id="OASF" data-ila-id="1486" data-start="2001" data-row="4" data-become="SolFed">Organise! Anarcho-Syndicalist Federation</div>
			<div id="SolFed" data-ila-id="1486" data-start="2003" data-row="4" data-become="organise2">Organise! Ireland (Solidarity Federation)</div>
			<div id="organise2" data-ila-id="1486" data-start="2015" data-row="4">Organise!</div>

			<div id="JCWRC" data-start="1932" data-end="1934" data-row="5">James Connolly Workers' Republican Clubs</div>
			<div id="RSP" data-start="1939" data-row="5" data-end="1949">Revolutionary Socialist Party</div>
			<div id="WAI" data-ila-id="1413" data-start="1978" data-row="5" data-end="1981" data-split="BWC">Women Against Imperialism</div>
			<div id="CW" data-ila-id="180" data-start="1994" data-row="5" data-end="1996" data-end-estimate="true">Class War</div>
			<div id="AAA" data-ila-id="1441" data-start="2014" data-row="5" data-links="SP" data-colour="#FFF580" data-become="Solidarity">Anti-Austerity Alliance (AAA)</div>
			<div id="Solidarity" data-ila-id="1441" data-start="2017" data-row="5">Solidarity</div>

			<div id="BSG" data-ila-id="250" data-start="1949" data-row="6" data-become="SPI49">Belfast Socialist Group</div>
			<div id="SPI49" data-ila-id="250" data-start="1949" data-row="6" data-become="WSP">Socialist Party of Ireland (1949)</div>
			<div id="WSP" data-ila-id="268" data-start="1960" data-row="6" data-end="1991" data-end-estimate="true">World Socialist Party</div>
			<div id="FC" data-ila-id="26" data-start="1995" data-row="6" data-end="1997">Frontline Collective</div>
			<div id="LabAlt" data-ila-id="1922" data-start="2016" data-row="6" data-links="SP">Cross-Community Labour Alternative</div>

			<div id="IAIL" data-start="1930" data-end="1931" data-row="7">International Anti-Imperialist League</div>
			<div id="TV" data-ila-id="5526" data-start="1944" data-end="1945" data-row="7">The Vanguard</div>
			<div id="DG" data-ila-id="192" data-start="1974" data-end="1986" data-row="7" data-end-estimate="true">Dawn Group</div>
			<div id="CWIR" data-ila-id="3519" data-start="2019" data-row="7" data-split="SP" data-become="MilLeft">CWI Ireland</div>
			<div id="MilLeft" data-ila-id="3519" data-start="2020" data-links="LabAlt" data-row="7">Militant Left</div>

			<div id="militant" data-ila-id="583" data-start="1972" data-row="8" data-become="militantLab" data-links="LP" data-colour="#D51A21">Militant</div>
			<div id="militantLab" data-ila-id="583" data-start="1989" data-row="8" data-become="SP" data-links="LP" data-colour="#D51A21">Militant Labour</div>
			<div id="SP" data-ila-id="248" data-start="1997" data-row="8" data-colour="#D51A21">Socialist Party</div>

			<div id="DTC" data-start="1923" data-row="9" data-split="LP" data-merge="LP" data-end="1926">Dublin Trades Council</div>
			<div id="NLP44" data-ila-id="2015" data-start="1944" data-row="9" data-split="LP" data-merge="LP" data-end="1950">National Labour Party</div>
			<div id="LTUCG" data-ila-id="1443" data-start="1974" data-row="9" data-become="LTUG" data-links="militant NILP">Labour &amp; Trade Union Coordinating Group</div>
			<div id="LTUG" data-ila-id="1443" data-start="1979" data-row="9" data-merge="SP" data-end="1997">Labour &amp; Trade Union Group</div>
			<div id="WP-L5I" data-ila-id="2156" data-start="2005" data-row="9" data-end="2006">Workers Power</div>
			<div id="RISE" data-ila-id="3198" data-start="2019" data-row="9" data-split="SP" data-merge="PBP" data-end="2021">RISE</div>

			<div id="LP" data-ila-id="210" data-start="1912" data-row="10" data-colour="#ED1C24">Labour Party</div>

			<div id="CSP" data-ila-id="2419" data-start="1945" data-row="11" data-split="LP" data-end="1947" data-end-estimate="true">Cork Socialist Party</div>
			<div id="NPD" data-ila-id="1422" data-start="1958" data-row="11" data-merge="LP" data-end="1963" >National Progressive Democrats</div>
			<div id="LCLL" data-ila-id="1442" data-start="1971" data-row="11" data-links="LP" data-fork="LP SLP" data-end="1977" data-colour="#adf">Liaison Committee of the Labour Left</div>
			<div id="SLP" data-ila-id="1276" data-start="1977" data-row="11" data-end="1982" data-links="MSR IWG2 SWM LWR" data-colour="#8F432B">Socialist Labour Party (SLP)</div>
			<div id="CUAG" data-ila-id="1722" data-start="1983" data-end="1984" data-end-estimate="true" data-row="11">Cork Unemployed Action Group</div>
			<div id="SA" data-ila-id="246" data-start="2002" data-end="2004" data-split="SWP" data-row="11" data-end-estimate="true">Socialist Alternative</div>
			<div id="PBP" data-ila-id="1454" data-start="2005" data-row="11" data-links="SWP" data-colour="#d62249">People Before Profit (PBP)</div>

			<div id="INUM" data-start="1926" data-become="IUWM" data-row="12">Irish National Unemployed Movement</div>
			<div id="IUWM" data-start="1930" data-end="1935" data-row="12">Irish Unemployed Workers' Movement</div>
			<div id="SRP" data-ila-id="2397" data-start="1944" data-row="12" data-merge="LP" data-end="1949">Socialist Republican Party</div>
			<div id="IWG2" data-ila-id="219" data-start="1976" data-row="12" data-split="SWM" data-end="2013" data-end-estimate="true">Irish Workers' Group</div>
			
			<div id="YS" data-ila-id="5094" data-start="1967" data-row="13" data-fork="SWM RMG" data-links="LP">Young Socialists</div>
			<div id="SWM" data-ila-id="253" data-start="1971" data-row="13" data-become="SWP" data-colour="#990000">Socialist Workers' Movement (SWM)</div>
			<div id="SWP" data-ila-id="254" data-start="1995" data-row="13" data-colour="#990000" data-become="SWN">Socialist Workers' Party (SWP)</div>
			<div id="SWN" data-ila-id="2531" data-start="2018" data-row="13" data-colour="#990000" data-links="PBP">Socialist Workers' Network (SWN)</div>

			<div id="ILP" data-ila-id="204" data-start="1900" data-end="1932" data-row="14">Independent Labour Party (UK)</div>
			<div id="YSA" data-ila-id="1452" data-start="1968" data-row="14" data-end="1969" data-links="PD YS">Young Socialists Alliance</div>
			<div id="RMG" data-ila-id="239" data-start="1971" data-row="14" data-become="MSR">Revolutionary Marxist Group (RMG)</div>
			<div id="MSR" data-ila-id="2155" data-start="1976" data-row="14" data-merge="PD" data-end="1978" >Movement for a Socialist Republic</div>

			<div id="CWAG" data-ila-id="1851" data-start="2004" data-row="14" data-merge="PBP" data-end="2007">Community and Workers Action Group</div>
			<div id="UL" data-ila-id="1428" data-start="2013" data-end="2015" data-row="14" data-links="ULA">United Left</div>

			<div id="SPNI" data-ila-id="5334" data-start="1932" data-end="1940" data-split="ILP" data-row="15" data-links="NILP">Socialist Party of Northern Ireland</div>
			<div id="SLAG" data-ila-id="1407" data-start="1970" data-row="15" data-become="SLA" data-colour="#faa">Socialist Labour Action Group</div>
			<div id="SLA" data-ila-id="1407" data-start="1971" data-row="15" data-end="1972" data-links="SWM PD LWR RMG SE"  data-colour="#faa">Socialist Labour Alliance</div>
			<div id="ULP" data-ila-id="1424" data-start="1978" data-row="15" data-merge="L87" data-end="1987">United Labour Party</div>
			<div id="IS" data-ila-id="1453" data-start="2000" data-row="15" data-split="SWP" data-merge="SD" data-end="2004">International Socialists</div>
			<div id="CIL" data-ila-id="1852" data-start="2005" data-end="2007" data-row="15" data-end-estimate="true" data-links="CWAG WUAG ISN">Campaign for an Independent Left</div>
			<div id="ULA" data-ila-id="1415" data-start="2010" data-row="15" data-links="PBP SWP SP WUAG" data-end="2014">United Left Alliance (ULA)</div>
			<div id="AAAPBP" data-ila-id="1824" data-start="2015" data-row="15" data-links="AAA PBP" data-become="S-PBP">Anti-Austerity Alliance - People Before Profit</div>
			<div id="S-PBP" data-ila-id="1824" data-start="2017" data-row="15" data-links="Solidarity PBP" data-become="PBPS">Solidarity - People Before Profit</div>
			<div id="PBPS" data-ila-id="4954" data-start="2020" data-row="15" data-links="PBP Solidarity">People Before Profit/Solidarity</div>

			<div id="PD" data-ila-id="232" data-start="1968" data-become="SD" data-row="16" data-links="NICRA">People's Democracy</div>
			<div id="SD" data-ila-id="1425" data-start="1996" data-row="16">Socialist Democracy</div>

			<div id="BSS" data-start="1905" data-end="1912" data-row="17">Belfast Socialist Society</div>
			<div id="CsnaP" data-start="1940" data-end="1943" data-row="17" data-end-estimate="true">Córas na Poblachta</div>
			<div id="CnaP" data-start="1946" data-end="1965" data-row="17">Clann na Poblachta</div>
			<div id="LRG" data-ila-id="1426" data-start="1976" data-split="PD" data-row="17" data-become="RRP">Left Revolutionary Group</div>
			<div id="RRP" data-ila-id="1426" data-start="1976" data-end="1978" data-row="17">Red Republican Party</div>
			<div id="LPNI" data-ila-id="1141" data-start="1985" data-merge="L87" data-end="1987" data-row="17">Labour Party of Northern Ireland (LPNI)</div>
			<div id="LPNI2" data-ila-id="2136" data-start="1998" data-row="17" data-split="LC" data-end="2007" data-end-estimate="true">Labour Party of Northern Ireland (LPNI)</div>
			<div id="IL" data-ila-id="3183" data-start="2019" data-row="17">Independent Left</div>

			<div id="FL" data-start="1944" data-merge="LP" data-end="1949" data-row="18" data-split="NILP">Federation of Labour</div>
			<div id="FU" data-start="1953" data-end="1960" data-end-estimate="true" data-row="18" data-links="CnaP">Fianna Uladh</div> 
			<div id="NICRA" data-ila-id="229" data-start="1967" data-end="1972" data-row="18" data-links="NILP CPNI SF">Northern Ireland Civil RIghts Association (NICRA)</div>
			<div id="L87" data-ila-id="1423" data-start="1987" data-end="1989" data-row="18" data-links="NLP">Labour '87</div>
			<div id="LC" data-ila-id="1447" data-start="1996" data-end="1998" data-row="18" data-links="militantLab BICO NLP" data-colour="#ff654e">Labour Coalition</div>
			<div id="SEA" data-ila-id="1440" data-start="2001" data-end="2008" data-links="SWP NLP" data-row="18">Socialist Environmental Alliance (SEA)</div>
			<div id="LF" data-ila-id="1421" data-start="2013" data-row="18">Left Forum</div>

			<div id="BLP" data-start="1900" data-merge="NILP" data-end="1924" data-row="19" data-links="ILP">Belfast Labour Party</div>
			<div id="NILP" data-ila-id="1409" data-start="1924" data-merge="L87" data-end="1987" data-row="19" data-links="ILP">Northern Ireland Labour Party (NILP)</div>
			<div id="LPiNI" data-ila-id="179" data-start="2008" data-row="19" data-colour="#e4003b">Labour Party in Northern Ireland</div>

			<div id="ILP-IRE" data-start="1912" data-end="1914" data-links="ILP SPI09" data-row="20">Independent Labour Party (Ireland)</div>
			<div id="CLP" data-start="1942" data-end="1947" data-split="NILP" data-row="20">Commonwealth Labour Party</div>
			<div id="NLP" data-ila-id="1417" data-start="1974" data-end="2004" data-split="NILP" data-end-estimate="true" data-row="20">Newtownabbey Labour Party</div>
			<div id="Coop" data-start="2009" data-links="LPiNI" data-row="20" data-colour="#3f1d70">Co-operative Party in Northern Ireland</div>

			<div id="ICWPA" data-row="21" data-start="1926" data-end="1930" data-end-estimate="true">International Class War Prisoners Aid (ICWPA)</div>
			<div id="UFL" data-ila-id="5333" data-row="21" data-start="1936" data-end="1936" data-links="NILP SPNI CPI1">United Front Labour</div>
			<div id="ILG" data-row="21" data-start="1958" data-end="1965" data-end-estimate="true">Independent Labour Group</div>
			<div id="SLISO" data-ila-id="1429" data-start="1974" data-merge="LP" data-end="1991" data-row="21">Sligo/Leitrim Independent Socialist Organisation</div>
			<div id="ARG-GL" data-ila-id="4343" data-start="2021" data-split="GP" data-row="21" data-colour="#68b2a0">An Rabharta Glas - Green Left</div>

			<div id="WUAG" data-ila-id="1414" data-start="1985" data-row="22">Workers' and Unemployed Action Group (WUAG)</div>

			<div id="ISRP" data-ila-id="1613" data-start="1900" data-row="23" data-end="1904">Irish Socialist Republican Party</div>
			<div id="SPI09" data-ila-id="1612" data-start="1909" data-row="23" data-end="1921" data-become="CPI21" data-links="ISRP">Socialist Party of Ireland (1909)</div>
			<div id="CPI21" data-ila-id="1612" data-start="1921" data-row="23" data-end="1924">Communist Party of Ireland (1921)</div>
			<div id="LWR" data-ila-id="222" data-start="1968" data-end="1988" data-split="IWG1" data-row="23">League for a Workers' Republic (LWR)</div>
			<div id="SGI" data-ila-id="257" data-start="1990" data-row="23">Spartacist Group of Ireland</div>

			<div id="LWV" data-ila-id="264" data-start="1970" data-split="LWR" data-become="WL" data-row="24">League for a Workers' Vanguard</div>
			<div id="WL" data-ila-id="264" data-start="1972" data-end="1978" data-row="24">Workers' League</div>
			<div id="EP" data-ila-id="203" data-start="1981" data-row="24" data-become="GA" data-colour="#00755B">Ecology Party</div>
			<div id="GA" data-ila-id="203" data-start="1983" data-row="24" data-become="GP" data-colour="#00755B">Green Alliance</div>
			<div id="GP" data-ila-id="203" data-start="1987" data-row="24" data-colour="#00755B">Green Party</div>

			<div id="IWL23" data-ila-id="1614" data-start="1923" data-row="25" data-end="1932" data-end-estimate="true">Irish Worker League</div>
			<div id="CPNI" data-ila-id="187" data-start="1941" data-row="25" data-split="CPI1" data-merge="CPI2" data-end="1970">Communist Party of Northern Ireland (CPNI)</div>
			<div id="IMS" data-ila-id="211" data-start="1976" data-end="1978" data-row="25" data-split="CPI2" data-end-estimate="true">Irish Marxist Society</div>
			<div id="NIEP" data-start="1983" data-row="25" data-become="GPNI" data-colour="#00755B">Northern Ireland Ecology Party</div>
			<div id="GPNI" data-start="1985" data-row="25" data-merge="GP" data-end="2006" data-colour="#00755B">Green Party in Northern Ireland</div>
			<div id="FN" data-ila-id="1430" data-start="2010" data-row="25" data-split="GP" data-colour="#4b7a00">Fís Nua</div>

			<div id="RWP" data-ila-id="5943" data-start="1930" data-end="1930" data-row="26" data-become="RWG">Revolutionary Workers' Party</div>
			<div id="RWG" data-ila-id="2147" data-start="1930" data-row="26" data-become="CPI1">Revolutionary Workers' Groups</div>
			<div id="CPI1" data-ila-id="186" data-start="1933" data-row="26" data-end="1941">Communist Party of Ireland</div>
			<div id="IWL" data-ila-id="1195" data-start="1948" data-row="26" data-become="IWP" data-links="CPI1">Irish Workers' League</div>
			<div id="IWP" data-ila-id="1195" data-start="1962" data-row="26" data-become="CPI2">Irish Workers' Party</div>
			<div id="CPI2" data-ila-id="186" data-start="1970" data-row="26">Communist Party of Ireland (CPI)</div>

			<div id="CYM1" data-ila-id="189" data-start="1963" data-end="1991" data-links="IWP" data-row="27">Connolly Youth Movement</div>
			<div id="CYM2" data-ila-id="189" data-start="2002" data-links="CPI2 CYM1" data-row="27">Connolly Youth Movement</div>
			
			<div id="WPI" data-ila-id="5898" data-start="1926" data-row="28" data-end="1927">Workers' Party of Ireland</div>
			<div id="IWG1" data-ila-id="1364" data-start="1966" data-end="1968" data-row="28">Irish Workers' Group</div>
			<div id="CCO" data-ila-id="190" data-start="1971" data-row="28" data-split="ICO" data-become="CWC">Cork Communist Organisation</div>
			<div id="CWC" data-ila-id="191" data-start="1972" data-row="28" data-end="1989" data-end-estimate="true">Cork Workers' Club</div>
			<div id="PC" data-start="1994" data-row="28" data-end="1995" data-links="DL GPNI">Peace Coalition</div>
			<div id="SD2015" data-ila-id="1737" data-start="2015" data-row="28" data-colour="#752f8b">Social Democrats</div>

			<div id="IWU" data-ila-id="1433" data-start="1960" data-row="29" data-become="ICG">Irish Workers' Union</div>
			<div id="ICG" data-ila-id="1433" data-start="1964" data-row="29" data-fork="IWG1 ICO">Irish Communist Group</div>
			<div id="LA" data-ila-id="1448" data-start="1975" data-row="29" data-end="1976" data-links="OSF LCLL CPI2" data-colour="#caa">Left Alliance</div>
			<div id="CLR" data-ila-id="1435" data-start="1978" data-row="29" data-end="1993" data-links="BICO">Campaign for Labour Representation</div>
			<div id="IFEM" data-ila-id="2269" data-start="2014" data-row="29" data-become="I4C">Independents for Equality Movement</div>
			<div id="I4C" data-ila-id="2269" data-start="2015" data-row="29">Independents 4 Change</div>

			<div id="ICO" data-ila-id="209" data-start="1965" data-row="30" data-become="BICO">Irish Communist Organisation (ICO)</div>
			<div id="BICO" data-ila-id="44" data-start="1971" data-row="30" data-end="1998" data-end-estimate="true">British &amp; Irish Communist Organisation (BICO)</div>
			<div id="OnePercentNetwork" data-ila-id="5788" data-start="2010" data-end="2011" data-end-estimate="true" data-row="30" data-links="ISN WSM EIR" data-colour="#c8211d">The 1% Network</div>
			<div id="RTOC" data-ila-id="3505" data-start="2020" data-row="30" data-colour="#ea3f3c">Right To Change</div>

			
			<div id="SE31" data-ila-id="5944" data-start="1931" data-row="31" data-end="1932" data-links="RWG IWFC">Saor Éire (1931)</div>
			<div id="RC" data-ila-id="4090" data-start="1934" data-row="31" data-end="1936">Republican Congress</div>
			<div id="COBI" data-ila-id="182" data-start="1974" data-row="31" data-split="BICO" data-become="CF">Communist Organisation in the British Isles (COBI)</div>
			<div id="CF" data-ila-id="182" data-start="1977" data-row="31" data-end="1980" data-end-estimate="true">Communist Formation</div>
			<div id="AHS" data-ila-id="38" data-start="1987" data-row="31" data-links="BICO">Aubane Historical Society</div>

			<div id="IRF" data-ila-id="214" data-start="1965" data-row="32" data-become="SECork">Irish Revolutionary Forces (IRF)</div>
			<div id="SECork" data-ila-id="242" data-start="1968" data-row="32" data-merge="ICO" data-end="1971">Saor Éire (Cork)</div>
			<div id="LSO" data-ila-id="1416" data-start="1972" data-row="32" data-merge="DSP" data-end="1982">Limerick Socialist Organisation</div>
			<div id="PANA" data-ila-id="1552" data-start="1996" data-row="32">Peace and Neutrality Alliance (PANA)</div>

			<div id="ATL" data-start="1929" data-end="1929" data-row="33">Anti-Tribute League</div>
			<div id="IWFC" data-start="1930" data-end="1932" data-row="33" data-links="ATL">Irish Working Farmers' Congress</div>
			<div id="RLP" data-ila-id="1418" data-start="1963" data-row="33" data-end="1973">Republican Labour Party (RLP)</div>
			<div id="SAN" data-ila-id="256" data-start="1979"  data-end="1982" data-row="33" data-links="LSO BICO SPI">Socialists Against Nationalism</div>
			<div id="DSP" data-ila-id="194" data-start="1982" data-row="33" data-merge="LP" data-end="1990" data-links="BICO">Democratic Socialist Party (DSP)</div>
			<div id="NA" data-ila-id="193" data-start="1992" data-row="33" data-split="WP" data-become="DL" data-colour="red">New Agenda</div>
			<div id="DL" data-ila-id="193" data-start="1992" data-row="33" data-merge="LP" data-end="1999" data-colour="red">Democratic Left</div>
			<div id="ISN" data-ila-id="215" data-start="2001" data-end="2017" data-end-estimate="true" data-row="33" data-links="WP ORM">Irish Socialist Network (ISN)</div>
			<div id="LD" data-ila-id="3310" data-start="2018" data-row="33" data-colour="#ed1a11">Lasair Dhearg</div>

			<div id="SPI" data-ila-id="251" data-start="1971" data-row="34" data-split="OSF" data-merge="DSP" data-end="1982">Socialist Party of Ireland (SPI)</div>
			<div id="SRC" data-ila-id="252" data-start="1986" data-row="34" data-end="1992" data-links="IRSP">Socialist Republican Collective (SRC)</div>
			<div id="Saoradh" data-ila-id="2249" data-start="2016" data-row="34">Saoradh</div>

			<div id="NPF" data-ila-id="1449" data-start="1964" data-become="NP" data-row="35" data-links="RLP">National Political Front</div>
			<div id="NP" data-ila-id="1449" data-start="1965" data-become="NDP" data-row="35">National Party</div>
			<div id="NDP" data-ila-id="1449" data-start="1965" data-end="1970" data-row="35">National Democratic Party</div>
			<div id="IRSP" data-ila-id="212" data-start="1974" data-row="35" data-split="OSF" data-colour="#8AA3FF">Irish Republican Socialist Party (IRSP)</div>

			<div id="CrleNaP" data-start="1929" data-end="1930" data-row="36">Comhairle na Poblachta</div>
			<div id="ICSP" data-ila-id="205" data-start="1976" data-row="36" data-split="IRSP" data-become="ISP">Irish Committee for a Socialist Programme</div>
			<div id="ISP" data-ila-id="205" data-start="1977" data-end="1978" data-row="36">Independent Socialist Party (ISP)</div>
			<div id="WPP" data-ila-id="1420" data-start="1985" data-row="36" data-split="WP" data-merge="WP" data-end="1987">Waterford People's Party</div>
			<div id="ORM" data-ila-id="230" data-start="1998" data-row="36" data-split="WP">Official Republican Movement (ORM)</div>

			<div id="OSF" data-ila-id="231" data-start="1969" data-row="37" data-become="SFWP" data-colour="red">Sinn Féin (Official)</div>
			<div id="SFWP" data-ila-id="267" data-start="1977" data-row="37" data-become="WP" data-colour="red">Sinn Féin The Workers' Party</div>
			<div id="WP" data-ila-id="267" data-start="1982" data-row="37" data-colour="red">The Workers' Party</div>

			<div id="SF" data-ila-id="245" data-start="1905" data-fork="OSF PSF" data-row="38" data-colour="#040">Sinn Féin (Pre 1970)</div>
			<div id="NE" data-ila-id="1419" data-start="1973" data-row="38" data-end="1975" data-split="OSF">New Earth</div>
			<div id="LCR" data-ila-id="223" data-start="1986" data-row="38" data-end="1991" data-split="PSF">League of Communist Republicans (LCR)</div>
			<div id="EIR" data-ila-id="635" data-start="2006" data-row="38" data-split="PSF" data-colour="#0faf4d">Éirígí</div>

			<div id="PSF" data-ila-id="244" data-start="1969" data-row="39" data-colour="#080">Sinn Féin (Provisional)</div>

			<div id="SE" data-ila-id="1436" data-start="1967" data-row="40" data-split="SF" data-end="1973">Saor Éire</div>
			<div id="Aontu" data-start="2019" data-row="40" data-split="PSF">Aontú</div>

			<div id="RTC" data-ila-id="241" data-start="1976" data-row="41" data-end="1982" data-links="RS">Ripening of Time Collective</div>
			<div id="RNU" data-ila-id="3195" data-start="2007" data-row="41" data-split="PSF">Republican Network for Unity</div>

			<div id="CSM32" data-ila-id="1465" data-start="1997" data-split="PSF" data-row="42">32 County Sovereignty Movement</div>

			<div id="RS" data-ila-id="240" data-start="1975" data-row="43" data-end="1985">Revolutionary Struggle</div>
			<div id="RSF" data-ila-id="1437" data-start="1986" data-row="43" data-split="PSF">Republican Sinn Féin</div>

			<div id="SDLP" data-ila-id="243" data-start="1970" data-row="44" data-colour="#006E51" data-links="NDP">Social Democratic &amp; Labour Party (SDLP)</div>

			<div id="WTS" data-ila-id="199" data-start="1964" data-row="45" data-links="SF">Wolfe Tone Society</div>

			<div id="Int" data-ila-id="67" data-start="1965" data-row="46" data-become="ICM-ML">The Internationalists</div>
			<div id="ICM-ML" data-ila-id="67" data-start="1969" data-row="46" data-become="CPI-ML">Irish Communist Movement (Marxist-Leninist)</div>
			<div id="CPI-ML" data-ila-id="67" data-start="1972" data-row="46" data-end="2003">Communist Party of Ireland (Marxist-Leninist) (CPI-ML)</div>
			<div id="AIAI" data-ila-id="3777" data-start="2017" data-row="46" data-colour="#1c882c">Anti-Imperialist Action Ireland</div>

			<div id="PUP" data-ila-id="233" data-start="1979" data-row="47" data-colour="#022a68">Progressive Unionist Party</div>
		</div><!--diagram-->
			
		<div class="controls">
			<form id="timeline-find">
				<label for="finder" class="sr-only">Find an organisation</label>
				<input type="text" name="finder" class="form-control" placeholder="Type to search for organisations" aria-label="Type to search for organisations" />
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
			panzoom: true
			});
		tl.create();
		
		const diagram = document.getElementById("diagram");
		new PopoverWrapper(diagram.querySelectorAll("div[data-ila-id]"), "organisation");

		diagram.addEventListener('timelineFind', (e) => {
			e.target.querySelector(`#${e.detail.id}`)._tippy.show();
			_paq.push(['trackEvent', 'Timeline', 'Search', e.detail.name]);
		});
		
		document.querySelectorAll("[data-toggle-target]").forEach( (el) => new ila.Toggler(el) );
	</script>
</xsl:template>

<xsl:template name="metadata-image">
	<meta property="og:image" content="{/data/params/workspace}/images/timeline.png" />
	<meta property="og:image:width" content="1848" />
	<meta property="og:image:height" content="892" />
	<meta property="og:image:alt" content="A section of the Timeline of the Irish Left diagram" />
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
