gulp = require 'gulp'
buffer = require 'vinyl-buffer'
uglify = require 'gulp-uglify'
source = require 'vinyl-source-stream'
browserify = require 'browserify'
watchify = require 'watchify'
lodash = require 'lodash'
coffeeify = require 'coffeeify'
gutil = require 'gulp-util'
glob = require 'glob'
notify = require 'gulp-notify'
path = require('../config').path

config =
  srcFiles: glob.sync("#{path.src.coffee}/**/*.coffee")
  build: "#{path.dest.js}"
  buildFile: 'app.js'


buildScript = (files, watch) ->
  rebundle = ->
    stream = bundler.bundle()
    stream.on "error", notify.onError
      title: "Compile Error"
      message: "<%= error.message %>"
    .pipe source config.buildFile
    .pipe buffer()
    .pipe uglify()
    .pipe gulp.dest config.build

  props = watchify.args
  props.entries = files
  props.debug = true

  bundler = (if watch then watchify(browserify(props)) else browserify(props))
  bundler.transform coffeeify
  bundler.on "update", ->
      rebundle()
      gutil.log "Rebundled..."
      gutil.log config.srcFiles
      return

  rebundle()

gulp.task "coffee", ->
    buildScript config.srcFiles, false
