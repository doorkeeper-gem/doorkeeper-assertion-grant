# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "appraisal"

desc "Default: run specs."
task :default => :spec

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec)

namespace :doorkeeper do
  desc "Install doorkeeper in dummy app"
  task :install do
    cd "spec/dummy"
    system "bundle exec rails g doorkeeper:install --force"
  end
end

Bundler::GemHelper.install_tasks
