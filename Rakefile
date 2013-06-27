require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

require 'rake/version_task'
Rake::VersionTask.new do |task|
  task.with_git_tag = true
end

### DOCUMENTATION METRICS ###
# measure coverage
require 'yardstick/rake/measurement'
Yardstick::Rake::Measurement.new(:yardstick_measure) do |measurement|
  measurement.output = 'measurement/report.txt'
  measurement.path = ['lib/**/*.rb', 'app/**/*.rb']
end

# verify coverage
require 'yardstick/rake/verify'
Yardstick::Rake::Verify.new do |verify|
  verify.threshold = 95
  verify.require_exact_threshold = false
  verify.path = ['lib/**/*.rb']
end
