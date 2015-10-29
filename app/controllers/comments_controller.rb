class CommentsController < ApplicationController




  def new
  end
  def create

    @product = Product.find(params[:product_id])
    @comment = @product.comments.create(comments_params)
    redirect_to product_path(@product)
  end
  def show
    @user = User.find(params[:user_id])
  end

  private
    def comments_params
      params.require(:comment).permit(:comment,:product_id,:user_id)
    end



end
