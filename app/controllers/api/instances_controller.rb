class Api::InstancesController < ActionController::API
  before_action :authenticate_with_api_key
  before_action :authenticate_with_token, only: :update

  def create
    # TODO API_KEY

    instance =
      ::Agent::Instance.where(instance_id: params[:instance_id]).first ||
      ::Agent::Instance.create({
        instance_id: params[:instance_id]
      })

    token =
      if instance.token.nil?
        ::Agent::Token.create(instance: instance)
      else
        instance.token.refresh_token!
      end

    render json: { access_token: token.token }
  end

  def update
    processes_data = instance_params.delete(:processes)
    instance.update_attributes(instance_params)

    agent_token.refresh_token!
    render json: { access_token: agent_token.token }
  end

  protected

  def instance_params
    @instance_params ||= params.permit(
      :disk_usage, :cpu_usage, :mem_usage,
      processes:[ :pid, :name, :virtual_memory, :cpu_use_percentage, :mem_use_percentage ]
    )
  end

  def authenticate_with_token
    head :unauthorized and return unless agent_token.present?
  end

  def authenticate_with_api_key
   head :unauthorized and return unless api_key.present? && Rails.application.secrets.api_key == api_key
  end

  def instance
    @instance ||= ::Agent::Instance.where(instance_id: params[:id]).first
  end

  def agent_token
    @token ||= ::Agent::Token.where(token: access_token).first
  end

  def access_token
    @access_token ||= request.headers.fetch(:token)
  end

  def api_key
    @api_key ||= request.headers.fetch(:'api-key')
  end
end
