require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')

namespace :barcodes do
  desc "Start the console"
  task :console do
    sh("irb -rubygems -I lib -r barcodes.rb")
  end
end