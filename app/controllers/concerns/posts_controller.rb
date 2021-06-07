class PostsController < ApplicationController
    def index
      # @posts = Post.all.ordered.with_categories
      # if params[:category_id]
      #   @posts = @posts.where(category_id: params[:category_id])
      # end
      if params[:category_id]
        @category = Category.find(params[:category_id])
        @posts = @category.posts.ordered.with_categories
      end
      @posts ||= Post.all.ordered.with_categories

      if params[:query].present?
        @posts = @posts.where('title LIKE ?',"%#{params[:query]}%")
      end
    end
  
    def show
      load_post
    end
  
    def new
      @post = Post.new
    end
  
    def create
      @post = Post.new(post_params)
      @post.save
      redirect_to @post
    end
  
    def edit
      load_post
    end
  
    def update
      load_post
      @post.update(post_params)
      redirect_to :post
    end
  
    def delete
      load_post
      @post.destroy
      redirect_to :posts
    end
  
    private
  
    def post_params
      params.require(:post).permit(:title, :text, :category_id)
    end
  
    def load_post
      @post = Post.find(params[:id])
    end
  end