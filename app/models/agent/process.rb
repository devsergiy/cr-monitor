module ::Agent
  class Process
    include Dynamoid::Document

    field :name
    field :cpu_usage, :integer

    belongs_to :instance, class: ::Agent::Instance
  end
end
