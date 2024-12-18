class PostsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = if user_signed_in? 
      Post.all_user(current_user).paginate(page: params[:page], per_page:10).sorted 
     else
       Post.published.paginate(page: params[:page], per_page:10).sorted
     end  
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    
    @post.user_id = current_user.id

    respond_to do |format|
      flash[:notice] = "Your profile has been updated."
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        flash[:notice] = "Your profile has been updated."
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_post 
      @post = user_signed_in? ? Post.find(params[:id]) : Post.published.find(params[:id]) 
    end

    def post_params
      params.require(:post).permit(:title, :body, :published_at)
    end

    def record_not_found
      redirect_to root_path
    end
end
