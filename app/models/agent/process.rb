module ::Agent
  class Process
    include Dynamoid::Document

    field :name
    field :pid, :integer
    field :cpu_usage, :number
    field :mem_usage, :number
    field :virtual_memory, :integer

    belongs_to :instance, class: ::Agent::Instance
  end
end
