var browserify   = require('browserify');
var gulp         = require('gulp');
var handleErrors = require('../util/handleErrors');
var livereload   = require('gulp-livereload');
var source       = require('vinyl-source-stream');
var coffeelint   = require('gulp-coffeelint')
var plumber   = require('gulp-plumber')

var _enviroments = ["editor","store"]

gulp.task('browserify_dev', function(){
  gulp.src('./src/**/*.coffee}').pipe(coffeelint())

  _enviroments.forEach(function (element, index, array) {
    console.log(element);
    return browserify({
        entries: ['./src/app/'+element+'.coffee'],
        extensions: ['.coffee'],
        transform: ["coffeeify","brfs","envify","browserify-shim","debowerify"]
    })
    .bundle({debug: true})
    .on('error', handleErrors)
    .pipe(source(''+element+'.js'))
    .pipe(gulp.dest('./build/js/'))
    .pipe(livereload());
  });
});

gulp.task('browserify', function(){
  _enviroments.forEach(function (element, index, array) {
    return browserify({
      entries: ['./src/ng-app/app.coffee'],
      extensions: ['.coffee']
    })
    .bundle({debug: true})
    .on('error', handleErrors)
    .pipe(source('app.js'))
    .pipe(rev())
    .pipe(streamify(uglify()))
    .pipe(gulp.dest('./build/js/'))
  });
});
