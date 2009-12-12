require 'rake'
require 'spec/rake/spectask'

namespace :spec do
  desc "Run specs with RCov"
  Spec::Rake::SpecTask.new('rcov') do |t|
    t.spec_files = FileList['*_spec.rb']
    t.rcov = true
    t.rcov_opts = ['--no-rcovrt']
  end
end