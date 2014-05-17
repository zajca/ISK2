var clean, gulp;

gulp = require('gulp');

clean = require("gulp-clean");

gulp.task('clean', function() {
return gulp.src(["./build/**/*", "./tmp/**/*"], {
      read: false
    }).pipe(clean());
});
