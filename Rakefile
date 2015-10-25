begin
  require 'puppetlabs_spec_helper/rake_tasks'
  require 'puppet-syntax/tasks/puppet-syntax'
  require 'puppet-lint/tasks/puppet-lint'
rescue LoadError
  puts 'Missing gems (hint: bundle install)'
end

repo_dir = File.dirname(__FILE__)

ignore_paths = [
  'pkg/**/*.pp',
  'spec/**/*.pp',
  'tests/**/*.pp',
]

#Rake::Task[:spec].clear
#task :spec do
#  Rake::Task[:spec_prep].invoke
#  Rake::Task[:spec_standalone].invoke
#end

if defined?(PuppetLint)
  Rake::Task[:lint].clear
  PuppetLint::RakeTask.new :lint do |config|
    # Pattern of files to ignore
    config.ignore_paths = ignore_paths

    # List of checks to disable
    config.disable_checks = [
      '80chars',
      'class_inherits_from_params_class',
      'documentation',
    ]

    # Should the task fail if there were any warnings, defaults to false
    config.fail_on_warnings = true

    # Print out the context for the problem, defaults to false
    config.with_context = true

    # Format string for puppet-lint's output (see the puppet-lint help output
    # for details
    config.log_format = "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}"

    # Compare module layout relative to the module root
    # config.relative = true
  end
else
  puts 'PuppetLint not available (hint: bundle install)'
end

if defined?(PuppetSyntax)
  PuppetSyntax.exclude_paths = ignore_paths

  task :default => [
    :syntax,
    :lint,
    :spec,
  ]
else
  puts 'PuppetSyntax not available (hint: bundle install)'
end

desc "Populate CONTRIBUTORS file"
task :contributors do
    system("git log --format='%aN, %aE' | sort -u > CONTRIBUTORS")
end

desc "Initialize module (bundle install, git init)"
namespace :init do
  desc "Run a bundle install"
  task :bundler do
    puts "=> Running 'bundle install'"
    sh("bundle", "install")
  end

  desc "Initialize as a git repo if it isn't already"
  task :git do
    unless File.exists?("#{repo_dir}/.git")
      puts "=> Initializing git repo"
      sh("git init")
    end
  end
end

task :init do
  Rake::Task['init:bundler'].invoke
  Rake::Task['init:git'].invoke

  puts
  puts "======================================================================"
  puts "Repo initialized"
end
