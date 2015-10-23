gulp = require 'gulp'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
# livereload = require 'gulp-livereload'
connect = require 'gulp-connect'

browserify = require 'browserify'
rename = require 'gulp-rename'
source = require 'vinyl-source-stream'
streamify = require 'gulp-streamify'
uglify = require('gulp-uglify')
sourcemaps = require('gulp-sourcemaps');
buffer = require('vinyl-buffer');
to5ify = require('6to5ify');

gulp.task 'gulpfile', ->
  gulp.src './gulpfile.coffee'
    .pipe coffeelint()
    .pipe coffeelint.reporter()
    .pipe coffee()
    .pipe gulp.dest './'

gulp.task 'server', ->
  connect.server {} =
    root: 'test'
    port: 8877
    host: 'localhost'
    livereload: true

gulp.task 'watch', ->
  gulp.watch './src/*.coffee', ['coffee_browserify'] #['browserify']
  gulp.watch './gulpfile.coffee', ['gulpfile']
  gulp.watch './test/*', ['html']

gulp.task 'html', ->
  gulp.src './test/*.html'
    .pipe connect.reload()

gulp.task 'coffee', ->
  gulp.src './src/*.coffee'
    .pipe(sourcemaps.init({loadMaps: true}))
    .pipe coffeelint()
    .pipe coffeelint.reporter()
    .pipe coffee()
    .pipe(sourcemaps.write('./'))
    .pipe gulp.dest './lib/'

gulp.task 'browserify', ['coffee'], ->
  browserify('./lib/touch.js',{debug:true})
    .transform(to5ify)
    .bundle()
    # .on('error', gutil.log.bind(gutil, 'Browserify Error'))
    .pipe source('touch.js')
    .pipe(buffer())
    .pipe(sourcemaps.init({loadMaps: true})) # loads map from browserify file
    .pipe streamify(uglify())
    .pipe rename('bundle.js')
    .pipe(sourcemaps.write('./')) # writes .map file
    .pipe connect.reload()
    .pipe gulp.dest('./test/')

gulp.task 'coffee_browserify', ->
  browserify ( {} =
    entries: ["./src/touch.coffee"],
    debug: true,
    extensions: [".coffee"],
    transform: ["coffeeify"] # npm install --save-dev coffeeify
    )
    .bundle()
    .pipe(source('boundle.js'))
    .pipe(buffer())
    .pipe(sourcemaps.init({loadMaps: true,debug: true}))
    .pipe(uglify
      debug: true,
      options:
        sourceMap: true,
    )
    .pipe(sourcemaps.write("./")) # /* optional second param here */
    .pipe connect.reload()
    .pipe(gulp.dest('./test/'));

gulp.task 'default', ['server','watch']
