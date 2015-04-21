gulp = require 'gulp'
runSequence = require 'run-sequence'
requireDir = require 'require-dir'
dir = requireDir './gulp/task'

gulp.task 'default', (callback) ->
  return runSequence(
    'clean',
    ['jade', 'coffee', 'stylus', 'image'],
    callback
    )

gulp.task 'develop', ['default', 'watch', 'server']