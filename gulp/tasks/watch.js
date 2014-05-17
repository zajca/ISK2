var gulp       = require('gulp');
var livereload = require('gulp-livereload');

gulp.task('watch', function(){
	gulp.watch('src/**/*.coffee', ['browserify_dev']);
	gulp.watch(['!src/images/**/*_NS.png','src/images/**/*.png','src/**/*.less'], ['LESS_DEV']);
  gulp.watch('src/images/**/*{.ico,.svg,.gif,_NS.png}', ['images_dev']);
  gulp.watch(['src/**/*.html','src/**/*.jade'], ['templates']);
    // gulp.watch('src/index.html', ['INJECT_DEV']);
	livereload();
});
