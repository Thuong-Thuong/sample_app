class TemoignagesController < ApplicationController
	before_filter :authenticate, :only => [:create, :update, :destroy]
	before_filter :authorized_user, :only => [:destroy]

	def create
		@temoignage = Temoignage.new
		@temoignage = current_user.temoignages.build(params[:temoignage])
		@temoignage.init(current_user.id,$user)
		if @temoignage.save
			flash[:success] = "Temoignage created!"
			redirect_to temoignages_path
		else
			@feed_item_temoignages = []            
			render 'new'
		end
	end

	def new
		@temoignage = current_user.temoignages.build(params[:temoignage])
        $temoin = 2
		@temoignage_pro = Temoignage.find_by_pro_id($user)
		@temoignage_aut = Temoignage.find_by_user_id($user)
		if (!@temoignage_pro.nil? && !@temoignage_aut.nil?)
			@feed_item_temoignages = Temoignage.all.where('pro_id IN (?) OR user_id IN (?)', $user , $user)
		elsif (!@temoignage_pro.nil?)
			@feed_item_temoignages = Temoignage.all.where('pro_id IN (?)', $user )
		elsif (!@temoignage_aut.nil?)
			@feed_item_temoignages = Temoignage.all.where('user_id IN (?)',  $user)
		end
		if !@feed_item_temoignages.nil?
			@feed_item_temoignages= @feed_item_temoignages.paginate(:page => params[:page])
		end
	end
	
	def show
		@temoignage = current_user.temoignages.build(params[:temoignage])
		$temoin = 2
		@temoignage_pro = Temoignage.find_by_pro_id($user)
		@temoignage_aut = Temoignage.find_by_user_id($user)
		if (!@temoignage_pro.nil? && !@temoignage_aut.nil?)
			@feed_item_temoignages = Temoignage.all.where('pro_id IN (?) OR user_id IN (?)', $user , $user)
		elsif (!@temoignage_pro.nil?)
			@feed_item_temoignages = Temoignage.all.where('pro_id IN (?)', $user )
		elsif (!@temoignage_aut.nil?)
			@feed_item_temoignages = Temoignage.all.where('user_id IN (?)',  $user)
		end
		if !@feed_item_temoignages.nil?
			@feed_item_temoignages= @feed_item_temoignages.paginate(:page => params[:page])
		end
	end

	def update
		@temoignage = Temoignage.find(params[:id])
		if @temoignage.update_attributes(params[:temoignage])
			flash[:success] = "Temoignage actualise"
			redirect_to temoignages_path
		else
			render 'show'
		end
	end
	
	def destroy
	    @temoignage.destroy
		flash[:success] = "Temoignage supprime!"
		redirect_to temoignages_path
	end

	private

	def authorized_user
		@temoignage = Temoignage.find(params[:id])
		flash[:success] = " #{params[:id]}" 
		# redirect_to root_path unless current_user?(@temoignage.user)
	end
end