task :check_users=> :environment do
	users = User.all
	users.each do |user|
		url = "https://www.codechef.com/users/#{user.user_id}"
		response = Nokogiri::HTML(HTTParty.get(url,:verify => false).body)
		response = response.css('.profile a')
		userSolvedLinks=Array.new
		userSolvedProblems=user.response.split(';')
		len=0;
		response.each do |link|
			link["href"] = "https://www.codechef.com#{link["href"]}"
			userSolvedLinks.push(link.to_s)
		end
		diff = userSolvedLinks-userSolvedProblems
		if diff.empty?
			puts "No new submission"
		else
			puts "New submission"
			user.response = userSolvedLinks.join(';')
			user.save
			UserMailer.new_submission(user,diff).deliver_now
		end

	end
end