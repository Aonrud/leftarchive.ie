<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="no" />

<xsl:template name="head-insert">
	<script src="{$workspace}/assets/js/datatables.min.js"></script>
    <script type="text/javascript">
        
        $(document).ready(function() {
            $('#docTable').DataTable( {
                serverSide: true,
                stateSave: true,
                ajax: {
                    "url": '/dynamic/documents/',
                    "data": function( d ) {
                        d.page = 1 + (d.start / d.length);
                    }
                },
                "columnDefs": [
                    { "targets": [0,1,2,3], "orderable": false }
                ],
                "pagingType": "full_numbers",
                "pageLength": 30,
                "dom": '&lt;"row"fp&gt;irt',
                "lengthchange": false,
                "language": {
                    "search": "Filter Documents: ",
                    paginate: {
                        first:    '«',
                        previous: '‹',
                        next:     '›',
                        last:     '»'
                    },
                    aria: {
                        paginate: {
                            first:    'First',
                            previous: 'Previous',
                            next:     'Next',
                            last:     'Last'
                        }
                    }
                },
            });
            $('div.dataTables_filter').addClass('col-sm-6');
            $('div.dataTables_paginate').addClass('col-sm-6');
        });
            
    </script>
</xsl:template>

<xsl:template match="data">
	<div class="page-header">
		<h1>Documents</h1>
	</div>
	<div class="row">
		<section class="col-md-12">
			<p class="lead">Use the filter box below to quickly search for documents.</p>
			<p>If you are looking for a particular <a href="/browse/organisations/" title="Browse all organisations">organisation</a>, <a href="/browse/publications/" title="Browse all publications">publication</a>, or <a href="/browse/people/" title="Browse all people">person</a> you can browse them alphabetically in the <a href="/browse/" title="Browse the full index">full index</a> or use the <a href="/search/">site search</a>.</p>
			<table id="docTable" class="table table-responsive">
				<thead>
					<tr><th scope="col">Name</th><th scope="col">Year</th><th scope="col">Organisation</th><th scope="col">Publication</th></tr>
				</thead>
				<tbody>
				<!--Datatables will insert contents here-->
				</tbody>
			</table>
		</section>
	</div>
</xsl:template>

<xsl:template name="page-title">
Political Documents | <xsl:value-of select="/data/params/website-name" />
</xsl:template>

<xsl:template name="metadata-general">
	<xsl:variable name="description">Index of all documents in the Irish Left Archive.</xsl:variable>

	<meta name="description" content="{$description}" />

	<meta property="og:type" content="article" />
	<meta property="og:title" content="Documents in the Irish Left Archive" />
	<meta property="og:url" content="http://www.leftarchive.ie/documents/" />
	<meta property="og:description" content="{$description}" />
</xsl:template>

<xsl:template name="breadcrumb-contents">
	<xsl:call-template name="breadcrumb-list-item">
		<xsl:with-param name="name" select="'Documents'" />
		<xsl:with-param name="link" select="'/documents/'" />
		<xsl:with-param name="position" select="'2'" />
		<xsl:with-param name="active" select="'Yes'" />
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
