// Generated on 2015-01-23 using generator-angular 0.10.0
'use strict';

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {

	// Load grunt tasks automatically
	require('load-grunt-tasks')(grunt);

	// Time how long tasks take. Can help when optimizing build times
	require('time-grunt')(grunt);

	var serveStatic = require('serve-static')

	// Configurable paths for the application
	var appConfig = {
		app: 'app',
		dist: 'dist',
		release: 'G:\\Source\\coaching\\yo\\app\\plugins\\windrunner/'
	};

	// Define the configuration for all the tasks
	grunt.initConfig({

		// Project settings
		yeoman: appConfig,

		coffee: {
			compile: {
				expand: true,
				cwd: '<%= yeoman.app %>/scripts',
				src: ['**/*.coffee'],
				dest: '<%= yeoman.app %>/scripts/js',
				ext: '.js'
			}
		},

		cjsx: {
			compile: {
				expand: true,
				cwd: '<%= yeoman.app %>/scripts',
				src: ['**/*.cjsx'],
				dest: '<%= yeoman.app %>/scripts/js',
				ext: '.js'
			}
		},

		removelogging: {
			dist: {
				src: "<%= yeoman.app %>/scripts/js/**/*.js",
				options: {
					methods: ['log', 'debug']
				}
			}
		},

		browserify: {
			options: {
				browserifyOptions: {
					standalone: 'windrunner'
				},
				plugin: [
					[ "browserify-derequire" ]
				]
			},
			'<%= yeoman.app %>/scripts/out/windrunner.js': ['<%= yeoman.app %>/scripts/windrunner.src.js', '<%= yeoman.app %>/scripts/js/**/*.js']
		},

		less: {
			development: {
				files: {
					"<%= yeoman.app %>/scripts/out/windrunner.css": '<%= yeoman.app %>/scripts/src/less/styles.less'
				}
			}
		},

		uglify: {
			dist: {
				files: {
					'<%= yeoman.app %>/scripts/out/dist/windrunner.js': ['<%= yeoman.app %>/scripts/out/windrunner.js']
				}
			}
		},

		cssmin: {
			options: {
				shorthandCompacting: false,
				roundingPrecision: -1
			},
			dist: {
				files: {
					'<%= yeoman.app %>/scripts/out/dist/windrunner.css': ['<%= yeoman.app %>/scripts/out/windrunner.css']
				}
			}
		},

		copy: {
			static: {
				expand: true,
				cwd: '<%= yeoman.app %>/scripts/static/',
				src: '**/*',
				dest: '<%= yeoman.app %>/scripts/out'
			},
			staticRelease: {
				expand: true,
				cwd: '<%= yeoman.app %>/scripts/out/',
				src: ['images/**/*', 'fonts/**/*'],
				dest: '<%= yeoman.release %>'
			},
			mainRelease: {
				expand: true,
				cwd: '<%= yeoman.app %>/scripts/out/dist',
				src: '*',
				filter: 'isFile',
				dest: '<%= yeoman.release %>'
			},
			devRelease: {
				expand: true,
				cwd: '<%= yeoman.app %>/scripts/out/',
				src: '*',
				filter: 'isFile',
				dest: '<%= yeoman.release %>'
			}
		},

		watch: {
		  	js: {
				files: ['<%= yeoman.app %>/**/windrunner.js'],
				options: {
			  		livereload: '<%= connect.options.livereload %>'
				}
		  	},
		  	livereload: {
				options: {
			  		livereload: '<%= connect.options.livereload %>'
				},
				files: [
			  		'<%= yeoman.app %>/**/*.html'
				]
		  	}
		},

		// The actual grunt server settings
		connect: {
		  	options: {
				port: 9001,
				base: '<%= yeoman.app %>',
				// Change this to '0.0.0.0' to access the server from outside.
				hostname: '0.0.0.0',
				livereload: 35735
		  	},
		  	livereload: {
				options: {
				  	open: true,
					base: '<%= yeoman.app %>'
				}
		  	}
		}
	});


	grunt.registerTask('default', [
		'less',
		'coffee',
		'cjsx',
		'removelogging',
		'browserify',
		'uglify',
		'cssmin',
		'copy:static',
		'copy:staticRelease',
		'copy:mainRelease'
	]);


	grunt.registerTask('build-dev', [
		'less',
		'coffee',
		'cjsx',
		'browserify',
		'copy:static'
	]);

	grunt.registerTask('dev', [
		'build-dev',
		'copy:staticRelease',
		'copy:devRelease'
	]);

	grunt.registerTask('serve', [
		'build-dev',
		'connect:livereload',
		'watch'
	]);
};
