class SignalevensController < ApplicationController
	before_filter :authenticate, :only => [:create, :update, :destroy]
	before_filter :authorized_user, :only => [:destroy, :update]

	def create
		@signaleven = Signaleven.new
		@signaleven = $evenement.signalevens.build(params[:signaleven])
		@signaleven.init(current_user.id, $even_id)
		if current_user.admin?
			@signaleven.validation = true
		end
		if @signaleven.save
            $even_signal = User.find_by_id($even)
			flash[:success] = "Signaleven created!"
			redirect_to signalevens_path
		else
			render 'new'
		end
	end
  
	def new
		@signaleven = Signaleven.new
		$signaleven_id = @signaleven.id
		if !current_user.admin? 
			@feed_item_signalevens = Signaleven.all.where('even_id = ? && id_signaleur  = ?', $even_id,current_user.id)
	    elsif current_user.admin? && $index_even == 0
			@feed_item_signalevens = Signaleven.all.where('even_id = ? ', $even_id)
		elsif current_user.admin? && $index_even == 1
			@feed_item_signalevens = Signaleven.all
		end
		if !@feed_item_signalevens.nil?
			@feed_item_signalevens = @feed_item_signalevens.paginate(:page => params[:page])
		end
           $even = Evenement.find_by_id($even_id)
	end
	
	def update
		@signaleven = Signaleven.find(params[:id])
		if @signaleven.update(params[:signaleven])
			flash[:success] = "Signaleven modifie! "
			if !current_user.admin? 
				@feed_item_signalevens = Signaleven.all.where('even_id = ? && id_signaleur  = ?', $even_id,current_user.id)
			elsif current_user.admin? && $index_even == 0
				@feed_item_signalevens = Signaleven.all.where('even_id = ? ', $even_id)
			elsif current_user.admin? && $index_even == 1
				@feed_item_signalevens = Signaleven.all
			end
			if !@feed_item_signalevens.nil?
				@feed_item_signalevens = @feed_item_signalevens.paginate(:page => params[:page])
			end
            if current_user.admin? && $index_even == 1
				redirect_to signalevenindex_path
            else
				redirect_to signalevens_path
            end
		else
			render 'edit'
		end
	end
	
	def index
		@titre = "Tous les signalevens"
		@signalevens = Signaleven.paginate(:page => params[:page])
	end
	
	def edit
		@signaleven = Signaleven.find(params[:id])
		if !current_user.admin? 
			@feed_item_signalevens = Signaleven.all.where('even_id = ? && id_signaleur  = ?', $even_id,current_user.id)
		elsif current_user.admin? && $index_even == 0
			@feed_item_signalevens = Signaleven.all.where('even_id = ? ', $even_id)
		elsif current_user.admin? && $index_even == 1
			@feed_item_signalevens = Signaleven.all
		end
		if !@feed_item_signalevens.nil?
			@feed_item_signalevens = @feed_item_signalevens.paginate(:page => params[:page])
		end
	end


  def destroy
     @signaleven.destroy
     flash[:success] = "Signaleven supprime!"
     if current_user.admin? && $index_even == 1
		redirect_to signalevenindex_path
     else
		redirect_to signalevens_path
     end
  end

  private

    def authorized_user
      @signaleven = Signaleven.find(params[:id])
      redirect_to root_path if !(current_user.id == @signaleven.id_signaleur) && !current_user.admin?
    end
      
end