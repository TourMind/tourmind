class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  helper_method :star_rating

  def index
    @comments = if params[:content].present?
                  Comment.by_content(params[:keyword])
                else
                  Comment.all
                end
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(commemt_params)
    if @comment.save
      redirect_to comments_path, notice: '新增成功'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @comment.update(commemt_params)
      redirect_to comments_path, notice: '編輯成功'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to comments_path
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def commemt_params
    params.require(:comment).permit(:content, :title, :author, :rating, :image, images: [])
  end

  def star_rating(rating)
    stars = ''
    rating.to_i.times { stars += '<i class="fas fa-star"></i>' }
    (5 - rating.to_i).times { stars += '<i class="far fa-star"></i>' }
    stars.html_safe
  end
end
