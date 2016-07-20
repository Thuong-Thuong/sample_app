module ApplicationHelper
	#Retourner un titre basé sur la page.
	def titre
		base_titre = "Neesyu"
		if @titre.nil?
			base_titre
		else
			#"#{base_titre} | #{@titre}"
			"#{@titre}"
		end
	end
	def logo
		image_tag("logo.png", :alt => "Application Neesyu", :class => "round")
	end
 
end