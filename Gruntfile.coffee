module.exports = (grunt) =>
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'
        exec:
            sample:
                cmd: 'ls'
            build:
                cmd: 'sh cli/build'
            buildquiet:
                cmd: 'sh cli/build'
                stdout: false
        regarde:
            src:
                files: ['src/**/*.*']
                tasks: ['buildquiet']
        jshint:
            files: [
                'src/js/definitions/**/*.*',
                'src/js/pages/**/*.*'
            ]

        typescript:
            only_view:
                src: [
                    '_src/pages/view/**/*.ts'
                ]
                dest: 'src/js/pages/view/all.js'

        concat:
            view:
                src: [
                    'bower_components/handlebars/handlebars.js'
                    'bower_components/showv/build/showv.js'
                    'src/js/pages/view/all.js'
                ]
                dest: 'src/js/pages/view/all.js'

    grunt.loadNpmTasks 'grunt-typescript'
    grunt.loadNpmTasks 'grunt-contrib-concat'

    grunt.loadNpmTasks 'grunt-exec'
    grunt.loadNpmTasks 'grunt-regarde'
    grunt.loadNpmTasks 'grunt-contrib-jshint'
    grunt.registerTask 'build', ['exec:build']
    grunt.registerTask 'buildquiet', ['exec:buildquiet']
    grunt.registerTask 'watch', ['buildquiet','regarde']
    grunt.registerTask 'check', ['jshint:files']
    grunt.registerTask 'default', ['exec:sample']

    grunt.registerTask 'tsview', ['typescript:only_view', 'concat:view']
