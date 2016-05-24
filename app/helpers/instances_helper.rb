module InstancesHelper
  STATE_MAP = {
    'running'       => 'success',
    'off'           => 'default',
    'highload'      => 'off',
    'shutting_down' => 'warning',
    'starting'      => 'info'
  }.freeze

  def state_label(instance)
    content_tag(
      :label,
      instance.aasm_state,
      class: "label label-#{STATE_MAP[instance.aasm_state]}"
    )
  end

  def intermediate_state?(instance)
    instance.shutting_down? || instance.starting?
  end
end
