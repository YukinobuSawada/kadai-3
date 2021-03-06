class FavoritesController < ApplicationController
	def create
		
		favorite = current_user.favorites.create(book_id: params[:book_id])
		favorite.save
		redirect_back(fallback_location: root_path)
	end

	def destroy
		@book = Book.find(params[:book_id])
		favorite = current_user.favorites.find_by(book_id: params[:book_id])
		favorite.destroy
		redirect_back(fallback_location: root_path)
	end


private

    def book_params
        params.require(:book).permit(:title, :body, :user_id)
    end
end