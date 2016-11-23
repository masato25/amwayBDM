var gulp = require('gulp'),
  sass = require('gulp-sass')
  watch = require('gulp-watch'),
  runSequence = require('run-sequence'),
  concat     = require('gulp-concat'),
  watchify = require('watchify'),
  browserify = require('browserify'),
  glob = require('glob');

var files = [];
var globFiles = glob.sync("./custom/js/*.js");
for (var i = 0; i < globFiles.length; i++) {
 if (globFiles[i].indexOf("./js/lib") !== 0) {
   files.push(globFiles[i]);
 }
}

var browserifyWatch = watchify(browserify({
  cache: {},
  packageCache: {},
  debug: true,
  entries: files
}));

var bundle = function() {
    return browserifyWatch.bundle()
      .pipe(source('bundle.js'))
      .pipe(gulp.dest('./app/assets/javascripts/apps/'));
  };
gulp.task('js', bundle);

gulp.task('include_css', () => {
  var cssList = [
      "node_modules/select2/dist/css/select2.css",
    ]
  return gulp.src(cssList)
    .pipe(concat('app.css'))
    .pipe(gulp.dest('app/assets/stylesheets/'))
});

gulp.task('watch', () => {
  watch('custom/js', () => {
    browserifyWatch.on('update', bundle)
  })
  watch('node_moules', () => {
    gulp.start('include_css')
  })
})
