require 'coffee-script/register'

gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
sourcemaps = require 'gulp-sourcemaps'

# https://github.com/jsdf/coffee-react-transform
# https://www.npmjs.org/package/gulp-cjsx
cjsx = require 'gulp-cjsx'

paths =
  src: ['js/src/**/*.coffee']

gulp.task 'build', (cb) ->
  gulp.src(paths.src)
  .pipe(sourcemaps.init())
  .pipe(cjsx())
  .pipe(concat('index.js'))
  .pipe(sourcemaps.write())
  .pipe(gulp.dest('js/build'))

gulp.task 'watch', ->
  gulp.watch(paths.src, ['build'])

gulp.task 'default', ['watch', 'build']
