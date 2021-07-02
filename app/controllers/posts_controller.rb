class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :login_required, only: [:new]


  def index
    @posts = Post.all
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find params[:id]
    unless session[:user_id] == @post.user_id
      flash[:notice] = "Sorry this is not your post so you cannot edit it."
      redirect_to posts_path(session[:user_id])
      return
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        PostMailer.post_mail(@post).deliver 
        # ContactMailer.contact_mail(@post).deliver
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  def confirm
    @post = Post.new(post_params)
    @post.user_id = current_user.id
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :content, :user_id, :image_cache)
  end
end































# class PicturesController < ApplicationController
#   before_action :set_picture, only: [:show, :edit, :update, :destroy]
#   before_action :user_login_check, only: [:new]
#
#   def index
#     @posts = Post.all
#   end
#
#   def show
#     @favorite = current_user.favorites.find_by(post_id: @post.id)
#   end
#
#   def new
#
#       @post = Post.new
#    end
#
#    def edit
#        if @post.user != current_user
#          flash.now[:error] = 'unauthorized access!'
#          redirect_to posts_path
#        else
#      end
#    end
#
#    def create
#    @post = Post.new(post_params)
#    @post.user_id = current_user.id
#     if params[:back]
#       render :new
#     else
#     if @post.save
#       PictureMailer.picture_mail(@post).deliver
#     redirect_to post_path, notice: 'Picture was posted'
#     else
#     render :new
#   end
#  end
# end
#
#   def confirm
#     @post = current_user.posts.build(ost_params)
#     render :new if @post.invalid?
#   end
#   # PATCH/PUT /pictures/1
#   # PATCH/PUT /pictures/1.json
#   def update
#     respond_to do |format|
#       if @post.update(post_params)
#         format.html { redirect_to @post, notice: 'Picture was updated' }
#       else
#         format.html { render :edit }
#       end
#     end
#   end
#
#   def destroy
#     @post.destroy
#     respond_to do |format|
#       format.html {redirect_to posts_url, notice: 'Picture was deleted'}
#     end
#   end
#
#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_post
#       @post = Post.find(params[:id])
#     end
#
#     # Only allow a list of trusted parameters through.
#     def post_params
#       params.require(:post).permit(:image, :content, :image_cache, :user_id, :email)
#     end
#
#     def user_login_check
#    unless logged_in?
#      redirect_to root_path
#    end
#  end
# end
