class InstanceStartJob < InstanceStateJob
  def change_state(instance)
    # Do something later
    instance.run!
  end
end
