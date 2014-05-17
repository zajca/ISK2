var gulp         = require('gulp');
var livereload   = require('gulp-livereload');
var notify       = require('gulp-notify');
var handleErrors = require('../util/handleErrors');
var plumber      = require('gulp-plumber');
var less         = require('gulp-less');
var autoprefixer = require('gulp-autoprefixer');
var rev          = require('gulp-rev');
var minifycss    = require("gulp-minify-css");
var rename       = require("gulp-rename");
var debug        = require('gulp-debug');

var confAutoPrefix = [
    "last 2 version",
    "safari 5", "ie 9",
    "opera 12.1",
    "ios 6",
    "android 4"
]

gulp.task('LESS', ["SPRITES"], function() {
    return gulp.src("./src/less/main.less")
        .pipe(less())
        .pipe(autoprefixer(confAutoPrefix))
        .pipe(minifycss())
        .pipe(rename({suffix: ".min"}))
        .pipe(rev())
        .pipe(gulp.dest("./assets/css"))
});

gulp.task('LESS_DEV', ["SPRITES_DEV"], function() {
    return gulp.src("./src/less/main.less")
        // .pipe(debug({verbose: true}))
        .pipe(plumber())
        .pipe(less())
        .pipe(autoprefixer(confAutoPrefix))
        .pipe(gulp.dest("./build/css"))
        .pipe(livereload())
});