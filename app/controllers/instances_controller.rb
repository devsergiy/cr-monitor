class InstancesController < ApplicationController
  before_action :authenticate
  before_action :set_instance, except: :index

  def index
    @instances = ::Agent::Instance.all
  end

  def show
  end

  def shutdown
    unless @instance.off?
      @instance.shutdown!
      InstanceShutdownJob.perform_later(@instance.id)
    end

    redirect_to @instance
  end

  def start
    unless @instance.running?
      @instance.start!
      InstanceStartJob.perform_later(@instance.id)
    end

    redirect_to @instance
  end

  private

  def set_instance
    @instance = ::Agent::Instance.find(params[:id])
  end
end
