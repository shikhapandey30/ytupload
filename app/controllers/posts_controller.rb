class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    video_title = params[:post][:title]
    video_url =  params[:post][:v_upload].path
    Yt.configure do |config|

      config.log_level = :debug
      

      config.api_key = "AIzaSyAshHkICxdRwVGlymaEPn60BuuoTNW5mLo"
      config.client_id = "244615150400-05thnta81fhg631up71t8v7e167i8pta.apps.googleusercontent.com"
      config.client_secret = "XW9LFZYGtLjruVh9kOpmCaRY"

      # config.api_key = "AIzaSyCSA_Cvcx4RlWXw6PryaVFz-zlgqUBs8yo"
      # config.client_id = "833205051824-d671rg92184srjelrtro077sf5elvl82.apps.googleusercontent.com"
      # config.client_secret = "ytA90VQIETx3LtN_IjjOeNJD"
      
    end
    account = Yt::Account.new access_token: current_user.authentications.first.token
          puts "account =========================> #{account}"
    uploaded_video = account.upload_video video_url, title: video_title
          puts "upload videos =========================> #{uploaded_video}"
            # video.update(uploaded_at: Time.now, youtube_video_link: "https://www.youtube.com/watch?v=#{uploaded_video.id}")


    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
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

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :v_upload, :category)
    end
end
