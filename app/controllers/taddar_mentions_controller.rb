class TaddarMentionsController < PublicController
  def index
    render plain: params['hub.challenge']
  end

  def create
    params[:entry].each do |entry|
      entry[:changes].each do |change|
        value = change[:value]
        InstagramMentionsService.new(value[:media_id], value[:comment_id]).execute!
      end
    end
  end
end
