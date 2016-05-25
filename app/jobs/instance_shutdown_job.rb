class InstanceShutdownJob < InstanceStateJob
  def change_state(instance)
    # Do something later
    instance.stop!
  end
end
