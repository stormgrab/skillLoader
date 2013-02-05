class CommentsController < ApplicationController
  
	before_filter :get_post

	def get_post
		@post = Post.find(params[:post_id])
	end
	

	# GET posts/1/comments
  # GET posts/1/comments.json
  def index
    @comments = @post.comments.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: [@post,@comments] }
    end
  end

  
  def show
    @comment = @post.comments.find(params[:id])
		@user = User.find(@comment.user_id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: [@post,@comments] }
    end
  end


  def new
    @comment = @post.comments.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: [@post,@comments] }
    end
  end

  
  def edit
    @comment = @post.comments.find(params[:id])
  end

 
  def create
    @comment = @post.comments.new(params[:comment])

		if @comment[:user_id]=session[:user_id]
		  respond_to do |format|
		    if @comment.save
		      format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
		      format.json { render json: [@post,@comments], status: :created, location: [@post,@comments] }
		    else
		      format.html { render action: "new" }
		      format.json { render json: @comment.errors, status: :unprocessable_entity }
		    end
		  end
		end
  end

 
  def update
    @comment = @post.comments.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to [@post,@comments], notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to [@post,@comment],notice:'Comment was successfully deleted' }
      format.json { head :no_content }
    end
  end
end
