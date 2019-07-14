class UsersController < ApplicationController

  before_action :authenticate_user , {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  require 'net/http'
  require 'uri'

  API_KEY = 'YOUR_API_KEY'


  def sample

    endpoint = URI.parse('https://api.apigw.smt.docomo.ne.jp/voiceText/v1/textToSpeech')
    endpoint.query = 'APIKEY=' + API_KEY

    request_body = {
      'text'=>'こんにちは。本日の天気をお知らせします。',
      'speaker'=>'takeru'
    }

    res = Net::HTTP.post_form(endpoint, request_body)

    case res
    when Net::HTTPSuccess
      file_name = "docomo.wav"
      File.binwrite(file_name, res.body)
      `afplay docomo.wav` # Linuxならaplayやmpg123を使う
      File.delete(file_name)
    else
      # res.value
      puts "a"
    end
  end

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_user.jpg",
      password: params[:password]
    )
    if @user.save
      # 変数flash[:notice]に、指定されたメッセージを代入してください
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @userhistory = Userhistory.new
    @userhistory.name = params[:name]
    @userhistory.user_id = params[:id]
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      @userhistory.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:notice] = "ユーザー情報を削除しました"
    redirect_to("/users/index")
  end

  def login_form

  end

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      # 変数sessionに、ログインに成功したユーザーのidを代入してください
      session[:user_id] = @user.id

      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def list
    @user = User.all
    @post = Post.all
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  def likes
    # 変数@userを定義してください
    @user = User.find_by(id: params[:id])

    # 変数@likesを定義してください
    @likes = Like.where(user_id: @user.id)
  end

end
