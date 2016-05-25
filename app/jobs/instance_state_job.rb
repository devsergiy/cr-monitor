class InstanceStateJob < ActiveJob::Base
  def perform(instance_id)
    change_state ::Agent::Instance.find(instance_id)
  end

  def change_state(instance)
    raise NotImplementedEror
  end
end
