class ArticlesController < ApplicationController

     
    def index
      articles = Article.all
      render json: articles_response(articles)
    end

    
    def create
      article = Article.new(article_params)
      article.save
      render json: articles_response(article), status: :created
    end
  
   
    def show
      article = Article.find_by(slug: params[:slug])
      if article
        render json: articles_response(article)
      else
        render json: { error: 'Article not found' }, status: :not_found
      end
    end
  
 
    def update
      article = Article.find_by(slug: params[:slug])
      if article
        article.update(article_params)
        render json: articles_response(article)
      else
        render json: { error: 'Article not found' }, status: :not_found
      end
    end
  
    def destroy
      article = Article.find_by(slug: params[:slug])
      if article
        article.destroy
        render json: { message: 'Article deleted' }
      else
        render json: { error: 'Article not found' }, status: :not_found
      end
    end
  
    private
  
    def article_params
      params.require(:article).permit(:title, :description, :body)
    end
    
  
    def articles_response(article)
      {
        article: {
          slug: article.slug,
          title: article.title,
          description: article.description,
          body: article.body,
          createdAt: article.created_at,
          updatedAt: article.updated_at,
        }
      }
    end
  

  end
  