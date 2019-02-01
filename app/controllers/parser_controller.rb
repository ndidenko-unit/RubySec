class ParserController < ApplicationController

  def index
    @posts = Post.all.reverse_order.paginate(page: params[:page], per_page: 30)
    @last_update = Post.last.last_update if @posts.present?
  end
end
