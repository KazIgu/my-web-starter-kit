gulp = require 'gulp'
stylus = require 'gulp-stylus'
nib = require 'nib'
autoPrefixer = require 'gulp-autoprefixer'
path = require('../config').path

gulp.task 'stylus', () ->
  return gulp.src ["#{path.src.stylus}/**/!(_)*.styl"]
    .pipe stylus
      compress: true
      use: nib()
    .pipe autoPrefixer
      browsers: ['last 3 version', 'Android 2.3', 'ie 10']
    .pipe gulp.dest "#{path.dest.css}"

