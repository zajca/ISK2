var gulp    = require("gulp");
var config  = require('../config');
var nodemon = require('gulp-nodemon');
var notify = require("gulp-notify");
var plumber      = require('gulp-plumber');
var coffeelint   = require('gulp-coffeelint')

gulp.task("devServer",["serverLint"], function() {
  return nodemon({
    script: "index.coffee",
    ext: "jade coffee",
    env: {
      "ENV": "dev"
    },
    ignore: ["./src/**/*", "./build/**/*"]
  })
  .on("change", ["serverLint"])
  .on("change",[])
  .on("restart", function() {
    notify("NODEMON RESTART");
    return console.log("restarted!");
  });
});

gulp.task('serverLint', function() {
  return gulp.src(
    [
      "./config/**/*.coffee",
      "./database/**/*.coffee",
      "./middleware/**/*.coffee",
      "./routes/**/*.coffee",
      "./config.coffee",
      "./index.coffee"
    ])
  .pipe(plumber())
  .pipe(coffeelint())
  .pipe(coffeelint.reporter());
});
