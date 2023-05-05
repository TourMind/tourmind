class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  helper_method :star_rating

  def index 
    if params[:content].present?
      @comments = Comment.by_content(params[:keyword])
    else
      @comments = Comment.all
    end
  end

  def new
    @comment = Comment.new
  end
  def create
    if params[:restaurant_id]
      @commentable = Restaurant.find(params[:restaurant_id])
    elsif params[:site_id]
      @commentable = Site.find(params[:site_id])
    elsif params[:hotel_id]
      @commentable = Hotel.find(params[:hotel_id])
    end
  
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
  
    respond_to do |format|
      if @comment.save
        format.json { render json: @comment, status: :created }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  def create
    if params[:restaurant_id]
      @commentable = Restaurant.find(params[:restaurant_id])
    elsif params[:site_id]
      @commentable = Site.find(params[:site_id])
    elsif params[:hotel_id]
      @commentable = Hotel.find(params[:hotel_id])
    end
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.json { render json: @comment, status: :created }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  def show; end

  def edit; end

  def update
    if @comment.update(comment_params)
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
    def comment_params 
      params.require(:comment).permit(:content,:title,:author,:rating, :image,images: [])
    end
    def star_rating(rating)
      stars = ''
      rating.to_i.times { stars += '<i class="fas fa-star" style="color: #ff857;"></i>' }
      (5 - rating.to_i).times { stars += '<i class="fa-solid fa-star" style="color: #effc36;"></i>' }
      stars.html_safe
    end
end
