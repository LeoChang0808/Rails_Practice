class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_article, only: [:create]
    
    def create
        # @comment = Comment.new(params_comment)
        # @comment.user = current_user
        # @comment.article = @article

        @comment = @article.comments.new(params_comment)

        if @comment.save
            redirect_to article_path(@article), notice: '留言成功'
        else
            render "articles/show"    
        end
    end

    def find_article
        @article = Article.find(params[:article_id])
    end
    
    def params_comment
        params.require(:comment).permit(:content).merge(user:current_user)
    end
end
