module Payloads
  class GithubHooksController < ApplicationController

    skip_before_filter :verify_authenticity_token
    skip_before_filter :authentication_check

    expose(:parser) { GithubHookParser::Main.new params[:payload] }

    def create
      ProjectFromRepositoryParser.new(parser.repository).find_or_create
      commits = Commit.add_batch_remote(parser.commits)
      render :text => 'ok'
    end
  end
end
