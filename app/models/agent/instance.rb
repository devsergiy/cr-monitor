require 'token_digest'

module ::Agent
  class Instance
    include Dynamoid::Document
    include AASM

    field :instance_id
    field :cpu_usage, :number
    field :disk_usage, :number
    field :mem_usage, :number
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

      event :calm do
        transitions from: :highload, to: :running
      end

      event :shutdown do
        transitions from: :running, to: :shutting_down
      end

      event :stop do
        transitions from: :shutting_down, to: :off
      end
    end

    has_many :processes, class: ::Agent::Process
    has_one :token, class: ::Agent::Token, inverse_of: :instance

    before_save :check_load

    def check_load
      if cpu_usage.to_f > 95
        overload
      elsif highload?
        calm
      end
    end
  end
end
