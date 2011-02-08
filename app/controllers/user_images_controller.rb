class UserImagesController < ApplicationController
  
#  if ENV['RAILS_ENV'] == 'production'
#    ssl_required :index, :new, :create, :edit, :update, :drop, :assign, :show
#  end

  def new
    #@current_user = self.current_user.id
      @image = UserImage.new
      respond_to do |format|
        format.html
      end
    end

    def create
      # Required for Windows machines. Uncomment if you using Windows
      # sleep(1)
      current_user = self.current_user
      #user_data = {:user => current_user, :primary => current_user.images.empty? }
      user_data = {:user => current_user}

      @image = UserImage.new(params[:image].merge(user_data))

      respond_to do |format|
        if @image.save
          flash[:success] = "image successfully uploaded"
          format.html { redirect_to(edit_user_path(current_user)) }
        else
          format.html { render :action => "new" }
        end
      end
    end
end
