var changed    = require('gulp-changed');
var gulp       = require('gulp');
var imagemin   = require('gulp-imagemin');
var livereload = require('gulp-livereload');

gulp.task('images', function() {
	var dest = './build/images';

	return gulp.src('./src/images/**/*{.ico,.svg,.gif,_NS.png}')
		.pipe(changed(dest))
		.pipe(imagemin())
		.pipe(gulp.dest(dest));
});

gulp.task('IMAGES_DEV', function() {
    var dest = './build/images';

    return gulp.src('./src/images/**/*{.ico,.svg,.gif,_NS.png}')
        .pipe(changed(dest))
        .pipe(gulp.dest(dest));
});
