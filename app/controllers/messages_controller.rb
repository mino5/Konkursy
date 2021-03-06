class MessagesController < ApplicationController

def new
  require_user
  @message = Message.new
  @articles_mostoften = Article.all(:order => "comments_count DESC")
  @newest_comments = Comment.all(:order => "created_at DESC")
end

def create
   require_admin
   params[:message][:user_id] = current_user.id
   @message = Message.create(params[:message])
   flash[:notice] = 'Wiadomość została wysłana.' if @message.save
   redirect_to new_user_message_path(current_user)
end

end
