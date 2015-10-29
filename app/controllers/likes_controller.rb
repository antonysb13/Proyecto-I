class LikesController < ApplicationController
  def AddLike
    
  end

  def create

    @product = Product.find(params[:product_id])
    @like = @product.likes.create(likes_params)
    redirect_to product_path(@product)
  end

  def show
    @user = User.find(params[:user_id])
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @product = @like.product
    @like.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    def set_likes
      @like = Like.find(params[:id])
    end
    def likes_params
      params.require(:like).permit(:id,:product_id,:user_id)
    end


end
