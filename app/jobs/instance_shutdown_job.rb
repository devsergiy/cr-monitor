class InstanceShutdownJob < InstanceStateJob
  def change_state(instance)
    i = ec2.instance(instance.instance_id)

    if Rails.env.production? && i.exists?
      case i.state.code
      when 48  # terminated
        puts "#{id} is terminated, so you cannot stop it"
      when 64  # stopping
        puts "#{id} is stopping, so it will be stopped in a bit"
      when 89  # stopped
        puts "#{id} is already stopped"
      else
        i.stop
      end
    end

    instance.stop!
  end
end
