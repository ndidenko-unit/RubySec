class ParserController < ApplicationController

  def index
    @posts = Post.all.reverse_order.paginate(page: params[:page], per_page: 30)
    @last_update = (Post.last.updated_at + 60*60*2).
        strftime("Updated at %m/%d/%Y %H:%M") + " (Kyiv)" if @posts.present?
  end
end
