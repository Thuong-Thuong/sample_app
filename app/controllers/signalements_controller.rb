class SignalementsController < ApplicationController
	before_filter :authenticate, :only => [:create, :update, :destroy]
	before_filter :authorized_user, :only => [:destroy, :update]

	def create
		@signalement = Signalement.new
		@signalement = current_user.signalements.build(params[:signalement])
		@signalement.init(current_user.id, $user)
		if current_user.admin?
			@signalement.validation = true
		end
		if @signalement.save
                $user_pro_signal = User.find_by_id($user)
			flash[:success] = "Signalement created!"
			redirect_to signalements_path
		else
			render 'new'
		end
	end
  
	def new
		@signalement = Signalement.new
		$signalement_id = @signalement.id
		if !current_user.admin? 
			@feed_item_signals = Signalement.all.where('id_signaleur  = ? && pro_id = ? ', current_user.id, $user )
           elsif current_user.admin?  && $index_pro == 0 
			@feed_item_signals = Signalement.all.where('pro_id  = ? || id_signaleur = ? ', $user ,current_user.id)
	     elsif current_user.admin?  && $index_pro == 1 
			@feed_item_signals = Signalement.all
	     end


		if !@feed_item_signals.nil?
			@feed_item_signals = @feed_item_signals.paginate(:page => params[:page])
		end
	end
	
	def update
		@signalement = Signalement.find(params[:id])
		if @signalement.update(params[:signalement])
			flash[:success] = "Signalement modifie! "
			if !current_user.admin? 
			@feed_item_signals = Signalement.all.where('id_signaleur  = ? && pro_id = ? ', current_user.id, $user )
           elsif current_user.admin?  && $index_pro == 0 
			@feed_item_signals = Signalement.all.where('pro_id  = ? || id_signaleur = ? ', $user ,current_user.id)
	     elsif current_user.admin?  && $index_pro == 1 
			@feed_item_signals = Signalement.all
	     end


		if !@feed_item_signals.nil?
			@feed_item_signals = @feed_item_signals.paginate(:page => params[:page])
		end

            if current_user.admin? && $index_pro == 1
				redirect_to signalindex_path
            else
				redirect_to signalements_path
            end
		else
			render 'edit'
		end
	end
	
	def index
		@titre = "Tous les signalements"
		@signalements = Signalement.paginate(:page => params[:page])
	end
	
	def edit
		@signalement = Signalement.find(params[:id])
		if !current_user.admin? 
			@feed_item_signals = Signalement.all.where('id_signaleur  = ? && pro_id = ? ', current_user.id, $user )
           elsif current_user.admin?  && $index_pro == 0 
			@feed_item_signals = Signalement.all.where('pro_id  = ? || id_signaleur = ? ', $user ,current_user.id)
	     elsif current_user.admin?  && $index_pro == 1 
			@feed_item_signals = Signalement.all
	     end

		if !@feed_item_signals.nil?
			@feed_item_signals = @feed_item_signals.paginate(:page => params[:page])
		end
	end


  def destroy
     @signalement.destroy
     flash[:success] = "Signalement supprime!"
     if current_user.admin? && $index_pro == 1
		redirect_to signalindex_path
     else
		redirect_to signalements_path
     end
  end

  private

    def authorized_user
      @signalement = Signalement.find(params[:id])
      redirect_to root_path if !(current_user.id == @signalement.id_signaleur) && !current_user.admin?
    end
    
    
end