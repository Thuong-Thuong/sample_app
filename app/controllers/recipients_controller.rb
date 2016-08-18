class RecipientsController < ApplicationController
	def destroy
		@recipient = Recipient.find(params[:id])
	    @recipient.destroy
		flash[:success] = "Message supprime !"
		redirect_to(:back)
	end
end