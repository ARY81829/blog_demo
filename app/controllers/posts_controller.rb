class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]  # Nur eingeloggte User dürfen erstellen/bearbeiten
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_post!, only: %i[edit update destroy] # Schutz: Nur Besitzer darf bearbeiten/löschen

  # GET /posts
  def index
    if params[:search].present?
      search_term = "%#{params[:search].downcase}%"
      @posts = Post.where("LOWER(title) LIKE ?", search_term)
    else
      @posts = Post.all.order(created_at: :desc)
    end
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Beitrag erfolgreich erstellt."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Beitrag erfolgreich aktualisiert."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Beitrag wurde gelöscht.", status: :see_other
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :image)
    end

    def authorize_post!
      unless @post.user == current_user
        redirect_to posts_path, alert: "Du darfst diesen Beitrag nicht bearbeiten."
      end
    end
end
