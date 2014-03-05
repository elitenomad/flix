module UsersHelper

	# Helper function to reach the gravator image
	def profile_image_for(user)
		url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}";
		image_tag(url, alt: user.name)
	end
end
