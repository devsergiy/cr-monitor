class InstanceStartJob < InstanceStateJob
  def change_state(instance)
    i = ec2.instance(instance.instance_id)

    if i.exists?
      case i.state.code
      when 0  # pending
        puts "#{id} is pending, so it will be running in a bit"
      when 16  # started
        puts "#{id} is already started"
      when 48  # terminated
        puts "#{id} is terminated, so you cannot start it"
      else
        i.start
      end
    end

    instance.run!
  end
end
