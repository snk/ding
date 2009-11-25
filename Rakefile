require "rake"
require "spec/rake/spectask"
 
desc "default"
Spec::Rake::SpecTask.new("default") do |task|
  task.spec_files = FileList["*_spec.rb"]
  task.rcov = true
  task.rcov_opts = ['-i', 'client.rb,manager.rb,shopping_report.rb,spy_shopper.rb,shopping_summary.rb,user.rb']
end