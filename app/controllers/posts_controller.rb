class PostsController < ApplicationController
  before_action :authenticate_user , {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:dummy]}

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
# 変数@likes_countを定義してください
    @user = @post.user

    @likes_count = Like.where(post_id: @post.id).count
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      content: params[:content],
      # user_idの値をログインしているユーザーのidにしてください
      user_id: @current_user.id
    )

    if @post.save
      # 変数flash[:notice]に、指定されたメッセージを代入してください
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      # 変数flash[:notice]に指定されたメッセージを代入してください
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    # 変数flash[:notice]に、指定されたメッセージを代入してください
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

end
