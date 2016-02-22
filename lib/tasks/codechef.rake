task :check_users=> :environment do
	users = User.all
	users.each do |user|
		user.codechef_ids.each do |codechef_id|
			url = "https://www.codechef.com/users/#{codechef_id.username}"
			status=1
			until status == 200 do
				begin
					r = HTTParty.get(url,:verify => false,timeout: 10)
					if r.code == 200
						status = 200
					end
				rescue HTTParty::Error,Net::OpenTimeout, Net::ReadTimeout
					puts "Error"
				end
			end
			response = Nokogiri::HTML(r.body)
			response = response.css('.profile a')
			userSolvedLinks=Array.new
			userSolvedProblems=codechef_id.solved_problems.split(';')
			len=0;
			response.each do |link|
				link["href"] = "https://www.codechef.com#{link["href"]}"
				userSolvedLinks.push(link.to_s)
			end
			diff = userSolvedLinks-userSolvedProblems
			if diff.empty?
				puts "No new submission for #{codechef_id.username}"
			else
				puts "New submission for #{codechef_id.username}"
				codechef_id.solved_problems = userSolvedLinks.join(';')
				codechef_id.save
				UserMailer.new_submission(user,diff,codechef_id.username).deliver_now
			end
		end
	end
end