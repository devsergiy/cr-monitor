module ::Agent
  class Instance
    include Dynamoid::Document
    include AASM

    field :name
    field :ip_address
    field :cpu_usage, :integer
    field :disk_usage, :number
    field :aasm_state

    aasm do
      state :running, :initial => true
      state :off, :highload, :shutting_down, :starting

      event :start do
        transitions from: :off, to: :starting
      end

      event :run do
        transitions from: :starting, to: :running
      end

      event :overload do
        transitions from: :running, to: :highload
      end

      event :shutdown do
        transitions from: :running, to: :shutting_down
      end

      event :stop do
        transitions from: :shutting_down, to: :off
      end
    end

    has_many :processes, class: ::Agent::Process
  end
end
