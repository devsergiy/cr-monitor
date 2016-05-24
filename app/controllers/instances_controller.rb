class InstancesController < ApplicationController
  before_action :set_instance, except: :index

  def index
    @instances = ::Agent::Instance.all
  end

  def show
  end

  def shutdown
    @instance.shutdown!

    redirect_to @instance
  end

  def start
    @instance.start!

    redirect_to @instance
  end

  private

  def set_instance
    @instance = ::Agent::Instance.find(params[:id])
  end
end
