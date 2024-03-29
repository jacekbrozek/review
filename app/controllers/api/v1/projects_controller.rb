class Api::V1::ProjectsController < Api::V1::BaseController
  before_filter :auth_token
  expose(:project) { Token.get_tokenable(token) }

  def index
    render json: project, serializer: Api::V1::ProjectSerializer
  end

  private
  def auth_token
    deny_access unless token && project.present? && project.instance_of?(Project)
  end

  def token
    params[:token]
  end
end
