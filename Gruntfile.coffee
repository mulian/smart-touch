module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    requirejs:
      compile:
        options:
          baseUrl: "lib",
          mainConfigFile: "lib/require-config.js"
          name: "require-config.js"
          # out: "webroot/optimized.js"
    coffeelint:
      app: ['src/*.coffee','./Gruntfile.coffee']
      options:
        'max_line_length':
          'value': 120,
          'level': 'error'
    connect:
      server:
        options:
          port: 9001
          protocol: 'http'
          base: ['./webroot/','lib']
          keepalive: true
    coffee:
      app:
        expand: true
        cwd: 'src'
        src: ['*.coffee']
        dest: 'lib'
        ext: '.js'
    watch:
      app:
        files: ['src/*.coffee','./Gruntfile.coffee']
        tasks: ['coffeelint','coffee']


  # These plugins provide necessary tasks.
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'

  # Default task.
  grunt.registerTask 'default', ['coffee']
