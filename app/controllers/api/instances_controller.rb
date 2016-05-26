class Api::InstancesController < ActionController::API
  def create
    # TODO API_KEY

    instance =
      ::Agent::Instance.where(name: 'test').first ||
      ::Agent::Instance.create({
        name: 'test',
        ip_address: '0.0.0.0'
      })

    token =
      ::Agent::Token.where(client_key: instance.client_key).first ||
      ::Agent::Token.new(client_key: instance.client_key)

    render json: { access_token: token.token }
  end

  def update
    authenticate

    agent_token.refresh_token!
    render json: { access_token: agent_token.token }
  end

  protected

  def authenticate
    head :unauthorized and return unless valid_token?
  end

  def valid_token?
    agent_token.client_key == current_instance.client_key
  end

  def current_instance
    @instance ||= ::Agent::Instance.find(params[:id])
  end

  def agent_token
    @token ||= ::Agent::Token.where(token: access_token).first
  end

  def access_token
    @access_token ||= request.headers.fetch(:token)
  end
end
