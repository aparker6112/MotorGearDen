task :update_details => :environment do
	@user = User.all
		@user.each do |u|
		@ud = u.user_detail

		@ud.username = u.username
		@ud.email = u.email
		@ud.first_name = u.first_name
		@ud.last_name = u.last_name

		@ud.address_line_one = u.door_name_number
		@ud.address_line_two = u.street
		@ud.address_line_three = u.city
		@ud.address_line_four = u.borough
		@ud.address_line_five = u.postcode

		
		if u.is_brand?
			if @ud.is_brand?
			else
				@ud.toggle :is_brand?
			end
		end
		@ud.brand_name = u.brand.name if u.brand
		@ud.brand_email = u.brand.email if u.brand
		@ud.brand_website = u.brand.website if u.brand
	if u.door_name_number && u.street && u.city && u.borough && u.postcode
		@ud.address = @ud.address_line_one + ' ' + @ud.address_line_two + ' ' + @ud.address_line_three + ' ' + @ud.address_line_four + ' ' + @ud.address_line_five
	end
		@ud.save!
	end

end
