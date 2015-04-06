module.exports = function (grunt) {

    // load all grunt tasks
    require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

    // configurable paths
    var paths = {
        src: {
            bower: './bower_components',
            javascripts: './assets/javascripts',
            stylesheets: './assets/stylesheets',
            images: './assets/images',
            bootstrap: './bower_components/bootstrap-sass-official/assets'
        },
        dest: './public'
    };

    grunt.initConfig({
        paths: paths,

        /*jqueryCheck: 'if (typeof jQuery === \'undefined\') { throw new Error(\'Bootstrap\\\'s JavaScript requires jQuery\') }\n\n',*/
        // get package meta data
        //pkg: grunt.file.readJSON('package.json'),

        // task configuration
        sass: {
            options: {
                style: 'compressed',
                sourceMap: true,
                loadPath: ['<%= paths.src.bower %>/fontawesome/scss']
            },
            dist: {
                files: [{
                    expand: true,
                    flatten: true,
                    src: ['<%= paths.src.stylesheets %>/**/*.scss'],
                    dest: '<%= paths.dest %>/stylesheets/',
                    ext: '.css'
                }]
            }
        },
        cssmin: {
            minify: {
                files: {
                    '<%= paths.dest %>/stylesheets/application.css': '<%= paths.dest %>/stylesheets/application.css'
                }
            }
        },
        copy: {
            fonts: {
                expand: true,
                flatten: true,
                /*src: ['<%= paths.src.bootstrap %>/fonts/**'],
                dest: '<%= paths.dest %>/fonts/bootstrap/',*/
                src: ['<%= paths.src.bower %>/fontawesome/fonts/**'],
                dest: '<%= paths.dest %>/fonts/',
                filter: 'isFile'
            },
            images: {
                expand: true,
                flatten: true,
                src: ['<%= paths.src.images %>/**'],
                dest: '<%= paths.dest %>/images/',
                filter: 'isFile'
            },
            scripts: {
                expand: true,
                flatten: true,
                src: ['<%= paths.src.bower %>/scrollReveal.js/dist/scrollReveal.min.js'],
                dest: '<%= paths.dest %>/javascripts/',
                filter: 'isFile'
            }, /* copy whole directory, see: http://stackoverflow.com/questions/18966485/copy-all-files-from-directory-to-another-with-grunt-js-copy/23670172#23670172 */
            tinymce: {
                cwd: '<%= paths.src.bower %>/tinymce',
                src: '**/*',
                dest: '<%= paths.dest %>/javascripts/tinymce',
                expand: true
            }
        },
        concat: {
            options: {
                separator: ';',
                /*banner: '<%= jqueryCheck %>',*/
                stripBanners: false
            },
            script_src: {
                src: [
                    '<%= paths.src.bower %>/jquery/dist/jquery.js',
                    '<%= paths.src.bower %>/jquery-ujs/src/rails.js',
                    //'<%= paths.src.bower %>/bootstrap/dist/js/bootstrap.js',
                    // SELECTIVELY INCLUDE BOOTSTRAP COMPONENTS:
                    '<%= paths.src.bootstrap %>/javascripts/bootstrap/transition.js',
                    '<%= paths.src.bootstrap %>/javascripts/bootstrap/alert.js',
                    '<%= paths.src.bootstrap %>/javascripts/bootstrap/button.js',
                    //'<%= paths.src.bootstrap %>/javascripts/bootstrap/carousel.js',
                    '<%= paths.src.bootstrap %>/javascripts/bootstrap/collapse.js',
                    '<%= paths.src.bootstrap %>/javascripts/bootstrap/dropdown.js',
                    '<%= paths.src.bootstrap %>/javascripts/bootstrap/modal.js',
                    '<%= paths.src.bootstrap %>/javascripts/bootstrap/tooltip.js',
                    '<%= paths.src.bootstrap %>/javascripts/bootstrap/popover.js',
                    //'<%= paths.src.bootstrap %>/javascripts/bootstrap/scrollspy.js',
                    '<%= paths.src.bootstrap %>/javascripts/bootstrap/tab.js',
                    //'<%= paths.src.bootstrap %>/javascripts/bootstrap/affix.js',
                    '<%= paths.src.bower %>/bootstrap-hover-dropdown/bootstrap-hover-dropdown.js',
                    '<%= paths.src.bower %>/enquire/dist/enquire.js',
                    '<%= paths.src.javascripts %>/application.js'
                ],
                dest: '<%= paths.dest %>/javascripts/application.js'
            }
        },
        uglify: {
            options: {
                //mangle: false  // Use if you want the names of your functions and variables unchanged
                mangle: true,  // SET TO TRUE TO MAKE JAVASCRIPT 30% SMALLER !
                report: 'min' // Reports actual minified size
            },
            script_dest: {
                files: {
                    '<%= paths.dest %>/javascripts/application.js': '<%= paths.dest %>/javascripts/application.js'
                }
            }
        },
        watch: {
            livereload: {
                files: [
                    '<%= paths.dest %>/stylesheets/*.css',
                    '<%= paths.dest %>/javascripts/application.js',
                    '<%= paths.dest %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
                ],
                options: {
                    livereload: true
                }
            },
            script_src: {
                files: [
                    '<%= paths.src.javascripts %>/application.js'
                ],
                tasks: ['concat:script_src']
            },
            copy: {
                files: ['<%= paths.src.bootstrap %>/fonts/**', '<%= paths.src.images %>/**'],  //watched files
                tasks: ['copy']                          //tasks to run
            },
            sass: {
                files: ['<%= paths.src.stylesheets %>/**'],
                tasks: ['sass:dist']
            }
        }
    });

    grunt.registerTask('build-dev', ['sass', 'copy', 'concat']);                // dev build
    grunt.registerTask('build-prod', ['sass', 'copy', 'concat', 'uglify', 'cssmin']);     // full dist build
    grunt.registerTask('default', ['watch']);
};
