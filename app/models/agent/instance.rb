module ::Agent
  class Instance
    include Dynamoid::Document

    field :name
    field :ip_address
    field :cpu_usage, :integer
    field :disk_usage, :number

    has_many :processes, class: ::Agent::Process
  end
end
