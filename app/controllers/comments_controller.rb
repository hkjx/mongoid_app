class CommentsController < ApplicationController
  load_and_authorize_resource
  before_filter :get_parent
 
  def new
    @comment = @parent.comments.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end


  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = @parent.comments.build(params[:comment])

    respond_to do |format|
      if @comment.save
        current_user.comments << @comment if current_user
        format.html { redirect_to root_url, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to root_url, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
private
  def get_parent
    @parent = Article.find(params[:article_id]) if params[:article_id]
    @parent = Comment.find(params[:comment_id]) if params[:comment_id]
  end
end
