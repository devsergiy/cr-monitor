class InstanceStateJob < ActiveJob::Base
  def perform(instance_id)
    change_state ::Agent::Instance.find(instance_id)
  end

  def change_state(instance)
    raise NotImplementedEror
  end

  def ec2
    @ec2 ||= Aws::EC2::Resource.new(region: 'us-east-1b')
  end
end
