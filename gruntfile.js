module.exports = function(grunt) {
	require('jit-grunt')(grunt);
	
	grunt.initConfig({
		less: {
			development: {
				options: {
					compress: true,
					yuicompress: true,
					optimization: 2
				},
				files: {
					"assets/css/src/styles.css": "assets/css/src/styles.less",
                    "assets/css/src/bootstrap.css": "assets/css/src/bootstrap-local.less",
				    "assets/css/src/timeline.css": "assets/css/src/timeline.less"
				}
			}
		},
		jshint: {
			files: ['gruntfile.js','assets/js/src/**/ila.*.js'],
			options: {
				globals: {
					jQuery: true,
					console: true,
					module: true,
					document: true
				},
				'esversion': 6
			}
		},
		concat: {
			dist: {
				files: {
					'assets/css/leftarchive.css' : [
						'assets/css/src/bootstrap.css',
						'node_modules/ila-ui-elements/dist/ila-ui.min.css',
						'node_modules/easy-autocomplete/dist/easy-autocomplete.min.css',
						'node_modules/bootstrap-slider/dist/css/bootstrap-slider.min.css',
						'assets/css/src/styles.css'
					],
					'assets/css/timeline.min.css' : [
						'node_modules/timeline/dist/timeline.min.css',
						"assets/css/src/timeline.css"
					]
				}
			}
			
		},
		copy: {
			dist: {
				files: [
					{
						nonull: true,
						src: 'node_modules/jquery/dist/jquery.min.js',
						dest: 'assets/js/jquery.min.js'
					},
					{
						nonull: true,
						src: 'node_modules/mediaelement/build/mediaelement-and-player.min.js',
						dest: 'assets/js/mediaelement-and-player.min.js'
					},
					{
						nonull: true,
						src: 'node_modules/mediaelement/build/mediaelementplayer.min.css',
						dest: 'assets/css/mediaelementplayer.min.css'
					},
					{
						expand: true,
						nonull: true,
						flatten: true,
						src: 'node_modules//@fortawesome/fontawesome-free/webfonts/*',
						dest: 'assets/fonts/fa/'
					},
					{
						expand: true,
						nonull: true,
						flatten: true,
						src: 'node_modules/mediaelement/build/*.swf',
						dest: 'assets/plugins/'
					},
					{
						expand: true,
						nonull: true,
						flatten: true,
						src: 'node_modules/mediaelement/build/mejs-controls*',
						dest: 'assets/images/'
					}
				],
			}
		},
		terser: {
			dist: {
				files: {
					'assets/js/leftarchive.min.js': [
						'node_modules/bootstrap/dist/js/bootstrap.min.js',
						'node_modules/easy-autocomplete/dist/jquery.easy-autocomplete.min.js',
						'node_modules/@panzoom/panzoom/dist/panzoom.min.js',
						'node_modules/bootstrap-slider/dist/bootstrap-slider.min.js',
						'node_modules/list.js/dist/list.min.js',
						'node_modules/ila-ui-elements/dist/ila-ui.min.js',
						'assets/js/src/jquery.markdown.js',
						'assets/js/src/ila.subjects.js',
						'assets/js/src/ila.wikipedia.js',
						'assets/js/src/ila.main.js'
  					],
					'assets/js/datatables.min.js': [
						'node_modules/datatables.net/js/jquery.dataTables.min.js',
                        'node_modules/datatables.net-bs/js/dataTables.bootstrap.min.js'					
					],
					'assets/js/cookies.min.js': [
						'node_modules/js-cookie/dist/js.cookie.js',
						'assets/js/src/ila.cookie.js'
					],
					'assets/js/podcast.min.js': [
						'assets/js/src/ila.podcast.js'
					],
					'assets/js/accounts.min.js': [
						'assets/js/src/ila.accounts.js'
					],
					'assets/js/timeline.min.js': [
						'node_modules/@popperjs/core/dist/umd/popper.min.js',
						'node_modules/tippy.js/dist/tippy-bundle.umd.min.js',
						'node_modules/timeline/dist/timeline.min.js',
						'assets/js/src/ila.timeline.js'
					]
				}
			}
		}
	});
	
	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-contrib-jshint');
	grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-terser');
	grunt.loadNpmTasks('grunt-contrib-copy');
	
	grunt.registerTask('default', ['less', 'concat', 'copy', 'terser']);
	grunt.registerTask('css', ['less', 'concat']);
	grunt.registerTask('js', ['copy', 'terser']);
    grunt.registerTask('check', ['jshint']);
};
