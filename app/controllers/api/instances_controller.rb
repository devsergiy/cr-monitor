class Api::InstancesController < ActionController::API
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
    authenticate

    agent_token.refresh_token!
    render json: { access_token: agent_token.token }
  end

  protected

  def authenticate
    head :unauthorized and return unless access_token.present?
  end

  def current_instance
    @instance ||= ::Agent::Instance.where(instance_id: params[:id])
  end

  def agent_token
    @token ||= ::Agent::Token.where(token: access_token).first
  end

  def access_token
    @access_token ||= request.headers.fetch(:token)
  end
end
