class BooksController < ApplicationController
 before_action :authenticate_user!

	def new
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		@books = Book.all
		@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book.id),notice:"You have creatad book successfully."
		else
			@books = Book.all
			render :index
		end
	end

	def index
		@books = Book.all
		@book = Book.new
		#@user = current_user
	end

	def show
		@books = Book.new
		@book = Book.find(params[:id])
		@user = @book.user
		@book_comment = BookComment.new
		@book_comments = 
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	def edit
			@user = current_user
			@book = Book.find(params[:id])
			if @book.user == current_user
            render "edit"
          else
            redirect_to books_path
          end
  	end

  	def update
		@book = Book.find(params[:id])
		@book.update(book_params)
	if	@book.update(book_params)
  		redirect_to book_path(@book.id),notice:"You have updated book successfully.."
  	else
    	render :edit
	end
	end


private
    def book_params
        params.require(:book).permit(:title, :body, :user_id)
    end
    def user_params
	params.require(:user).permit(:name, :profile_image, :introduction)
	end
	 def correct_user
    @book = Book.find(params[:id])
	end
end
