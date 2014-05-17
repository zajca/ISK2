var gulp         = require('gulp');
var livereload   = require('gulp-livereload');
var notify       = require('gulp-notify');
var gulpif       = require('gulp-if');
var plumber      = require('gulp-plumber');
var sprite       = require('css-sprite').stream;
var debug        = require('gulp-debug');

var spriteConf={
    base64: true,
    name: 'sprite.png',
    style: 'sprites.less',
    cssPath: 'images/',
    processor: 'less'
};

gulp.task('SPRITES_DEV', function() {
    return gulp.src(["./src/images/**/*.png", "!./src/images/**/*_ns.png"])
    .pipe(plumber())
    .pipe(sprite(spriteConf))
    .pipe(gulpif('*.png', gulp.dest("./build/images")))
    .pipe(gulpif('*.less', gulp.dest("./tmp")))
    .pipe(livereload());
});

gulp.task('SPRITES', function() {
    return gulp.src(["./src/images/**/*.png", "!./src/images/**/*_ns.png"])
    .pipe(plumber())
    .pipe(sprite(spriteConf))
    .pipe(gulpif('*.png', gulp.dest("./build/images")))
    .pipe(gulpif('*.less', gulp.dest("./tmp")));
});
