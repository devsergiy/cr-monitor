namespace :db do
  desc "Populate db with test data"
  task :seed => :environment do
    User.create({
      email: 'admin@example.com',
      password: '123456',
      password_confirmation: '123456'
    })

    create_instances unless Rails.env.production?
  end

  def create_instances
    Agent::Instance.all.each(&:delete)
    Agent::Process.all.each(&:delete)

    3.times do |i|
      instance = Agent::Instance.create({
          instance_id: "west-smpl-#{Time.now.to_i}",
          cpu_usage: 10,
          disk_usage: 2000
      })
      2.times do
        instance.processes << create_process(instance)
      end
      instance.save
    end
  end

  def create_process(instance)
    Agent::Process.create({
      name: "Process #{Time.now}",
      cpu_usage: 10,
      instance: instance
    })
  end
end
