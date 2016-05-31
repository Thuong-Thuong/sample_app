module UsersHelper
	# Returns the Gravatar for the given user.
	def gravatar_pour(user, options = { :size => 50 })
		gravatar_image_tag(user.email.downcase, :alt => user.nom,
                                         :class => 'gravatar',
                                         :gravatar => options)
	end
end
