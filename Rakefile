require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false

  # we require spec_helper so we don't get an RSpec warning about
  # examples being defined before configuration.
  t.ruby_opts = "-I./spec -I. -I./lib -rspec_helper"
  t.rspec_opts = %w[--color --format progress]
end

task :default => :spec

def version
  @version_in_file ||= begin
    require '../marqeta-api-client/lib/marqeta/version'
    ::Marqeta::VERSION
  end
end

desc "Update the marqeta_api_client gem to new version."
task :update_api_client do |t, args|
  cd '../marqeta-api-client'
  sh 'git pull'
  sh 'gem build marqeta_api_client.gemspec'
  sh "curl -F p1=@marqeta_api_client-#{version}.gem `heroku config:get GEMFURY_URL --app marqeta-jamba-staging`"
end
