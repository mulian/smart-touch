module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
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
          base: './webroot/'
          keepalive: true
    coffee:
      app:
        expand: true
        cwd: 'src'
        src: ['src/*.coffee','./Gruntfile.coffee']
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

  # Default task.
  grunt.registerTask 'default', ['coffee']
