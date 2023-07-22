# frozen_string_literal: true

require 'bundler'
require 'rake/testtask'
require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
end

task :run do
  ruby 'main.rb'
end

task default: %w[rubocop test]
