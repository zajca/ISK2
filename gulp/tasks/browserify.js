var browserify   = require('browserify');
var gulp         = require('gulp');
var handleErrors = require('../util/handleErrors');
var livereload   = require('gulp-livereload');
var source       = require('vinyl-source-stream');
var coffeelint   = require('gulp-coffeelint')
var plumber   = require('gulp-plumber')

var _enviroments = ["editor","store","admin"]

gulp.task('browserify_lint', function(){
  gulp.src('./src/**/*.coffee}').pipe(coffeelint())
});

gulp.task('browserify_dev_admin', ["browserify_lint"], function(){
    browserify({
        entries: ['./src/admin/index.coffee'],
        extensions: ['.coffee']
    })
    .bundle({debug: true})
    .on('error', handleErrors)
    .pipe(source('admin.js'))
    .pipe(gulp.dest('./build/js/'))
    .pipe(livereload());
});

gulp.task('browserify_dev_store', ["browserify_lint"], function(){
    browserify({
        entries: ['./src/store/index.coffee'],
        extensions: ['.coffee']
    })
    .bundle({debug: true})
    .on('error', handleErrors)
    .pipe(source('store.js'))
    .pipe(gulp.dest('./build/js/'))
    .pipe(livereload());
});

gulp.task('browserify_dev_editor', ["browserify_lint"], function(){
    browserify({
        entries: ['./src/editor/index.coffee'],
        extensions: ['.coffee']
    })
    .bundle({debug: true})
    .on('error', handleErrors)
    .pipe(source('editor.js'))
    .pipe(gulp.dest('./build/js/'))
    .pipe(livereload());
});

// gulp.task('browserify', function(){
//   _enviroments.forEach(function (element, index, array) {
//     return browserify({
//       entries: ['./src/ng-app/app.coffee'],
//       extensions: ['.coffee']
//     })
//     .bundle({debug: true})
//     .on('error', handleErrors)
//     .pipe(source('app.js'))
//     .pipe(rev())
//     .pipe(streamify(uglify()))
//     .pipe(gulp.dest('./build/js/'))
//   });
// });
