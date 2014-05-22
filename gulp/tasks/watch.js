var gulp       = require('gulp');
var livereload = require('gulp-livereload');

gulp.task('watch', function(){
	gulp.watch(['src/**/*.coffee','!src/editor/*.coffee','!src/store/*.coffee'], ['browserify_dev_admin']);
  gulp.watch(['src/**/*.coffee','!src/editor/*.coffee','!src/admin/*.coffee'], ['browserify_dev_store']);
  gulp.watch(['src/**/*.coffee','!src/admin/*.coffee','!src/store/*.coffee'], ['browserify_dev_editor']);
	gulp.watch(['!src/images/**/*_NS.png','src/images/**/*.png','src/**/*.less'], ['LESS_DEV']);
  gulp.watch('src/images/**/*{.ico,.svg,.gif,_NS.png}', ['images_dev']);
  gulp.watch(['src/**/*.html','src/**/*.jade'], ['templates']);
    // gulp.watch('src/index.html', ['INJECT_DEV']);
	livereload();
});
