(function() {
  var browserify, buffer, coffee, coffeelint, connect, gulp, rename, source, sourcemaps, streamify, to5ify, uglify;

  gulp = require('gulp');

  coffee = require('gulp-coffee');

  coffeelint = require('gulp-coffeelint');

  connect = require('gulp-connect');

  browserify = require('browserify');

  rename = require('gulp-rename');

  source = require('vinyl-source-stream');

  streamify = require('gulp-streamify');

  uglify = require('gulp-uglify');

  sourcemaps = require('gulp-sourcemaps');

  buffer = require('vinyl-buffer');

  to5ify = require('6to5ify');

  gulp.task('gulpfile', function() {
    return gulp.src('./gulpfile.coffee').pipe(coffeelint()).pipe(coffeelint.reporter()).pipe(coffee()).pipe(gulp.dest('./'));
  });

  gulp.task('server', function() {
    return connect.server({
      root: 'test',
      port: 8877,
      host: 'localhost',
      livereload: true
    });
  });

  gulp.task('watch', function() {
    gulp.watch('./src/*.coffee', ['coffee_browserify']);
    gulp.watch('./gulpfile.coffee', ['gulpfile']);
    return gulp.watch('./test/*', ['html']);
  });

  gulp.task('html', function() {
    return gulp.src('./test/*.html').pipe(connect.reload());
  });

  gulp.task('coffee', function() {
    return gulp.src('./src/*.coffee').pipe(sourcemaps.init({
      loadMaps: true
    })).pipe(coffeelint()).pipe(coffeelint.reporter()).pipe(coffee()).pipe(sourcemaps.write('./')).pipe(gulp.dest('./lib/'));
  });

  gulp.task('browserify', ['coffee'], function() {
    return browserify('./lib/touch.js', {
      debug: true
    }).transform(to5ify).bundle().pipe(source('touch.js')).pipe(buffer()).pipe(sourcemaps.init({
      loadMaps: true
    })).pipe(streamify(uglify())).pipe(rename('bundle.js')).pipe(sourcemaps.write('./')).pipe(connect.reload()).pipe(gulp.dest('./test/'));
  });

  gulp.task('coffee_browserify', function() {
    return browserify(({
      entries: ["./src/touch.coffee"],
      debug: true,
      extensions: [".coffee"],
      transform: ["coffeeify"]
    })).bundle().pipe(source('boundle.js')).pipe(buffer()).pipe(sourcemaps.init({
      loadMaps: true,
      debug: true
    })).pipe(uglify({
      debug: true,
      options: {
        sourceMap: true
      }
    })).pipe(sourcemaps.write("./")).pipe(connect.reload()).pipe(gulp.dest('./test/'));
  });

  gulp.task('default', ['server', 'watch']);

}).call(this);
