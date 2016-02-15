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

	// Configurable paths for the application
	var appConfig = {
		app: 'app',
		dist: 'dist'
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
					standalone: 'hsarenadraft'
				},
				plugin: [
					[ "browserify-derequire" ]
				]
			},
			'<%= yeoman.app %>/scripts/out/hsarenadraft.js': ['<%= yeoman.app %>/scripts/hsarenadraft.src.js']
		},

		less: {
			development: {
				files: {
					"<%= yeoman.app %>/scripts/out/hsarenadraft.css": '<%= yeoman.app %>/scripts/src/less/styles.less'
				}
			}
		},

		uglify: {
			dist: {
				files: {
					'<%= yeoman.app %>/scripts/out/dist/hsarenadraft.js': ['<%= yeoman.app %>/scripts/out/hsarenadraft.js']
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
					'<%= yeoman.app %>/scripts/out/dist/hsarenadraft.css': ['<%= yeoman.app %>/scripts/out/hsarenadraft.css']
				}
			}
		},

		copy: {
			main: {
				expand: true,
				src: '<%= yeoman.app %>/scripts/out/dist/*',
				dest: 'G:\\Source\\coaching\\yo\\app\\plugins\\hsarenadraft/',
				flatten: true
			},
			dev: {
				expand: true,
				src: '<%= yeoman.app %>/scripts/out/*',
				dest: 'G:\\Source\\coaching\\yo\\app\\plugins\\hsarenadraft/',
				flatten: true
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
		'copy:main'
	]);

	grunt.registerTask('dev', [
		'less',
		'coffee',
		'cjsx',
		'browserify',
		'copy:dev'
	]);
};
