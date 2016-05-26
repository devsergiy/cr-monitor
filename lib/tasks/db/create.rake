namespace :db do
  desc "Create db tables"
  task :create => :environment do
    [
      User,
      ::Agent::Instance,
      ::Agent::Process,
      ::Agent::Token
    ].each do |klass|
      klass.create_table
    end
  end
end
