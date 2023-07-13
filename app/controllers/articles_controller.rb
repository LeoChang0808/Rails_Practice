class ArticlesController < ApplicationController
    def index
    end
  
    def new
        # @實體變數
        @article = Article.new
    end

    def create
        @article = Article.new(article_params) 

        if @article.save
            redirect_to "/articles", notice:"文章新增成功囉 ! "
        else
            render :new
            # redirect_to "/articles/new", alert:"文章新增失敗囉 QQ ! "
        end
            

        # flash[:notice] = "文章新增成功囉 ! "
        # redirect_to "/articles", notice:"文章新增成功囉 ! "
        # render html: params
    end
    def article_params
        params.require(:article).permit(:title, :context)
    end
end
