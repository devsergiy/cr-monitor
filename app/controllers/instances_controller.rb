class InstancesController < ApplicationController
  def index
    @instances = ::Agent::Instance.all
  end

  def show
    @instance = ::Agent::Instance.find(params[:id])
  end
end
