var gulp = require('gulp');

gulp.task('dev', ['clean','LESS_DEV' ,'IMAGES_DEV','browserify_dev','watch','templates','devServer']);
// gulp.task('dev', ['clean','LESS_DEV' ,'IMAGES_DEV','browserify_dev','watch','devServer','templates']);