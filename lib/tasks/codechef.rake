task :check_users=> :environment do
	handles = Handle.all
	handles.each do |handle|
		if handle.team == true
			url = "https://www.codechef.com/teams/view/#{handle.username}"
		else
			url = "https://www.codechef.com/users/#{handle.username}"
		end
		status=1
		success = 1
		until status == 200 do
			begin
				r = HTTParty.get(url,:verify => false,timeout: 10)
				if r.code == 200
					status = 200
				end
			rescue URI::InvalidURIError
					status = 200
					success = 0
			rescue HTTParty::Error,Net::OpenTimeout, Net::ReadTimeout
					puts "Error"
			end
		end
			if success >0
				response = Nokogiri::HTML(r.body)
				response = response.css('.content-wrapper a')
				userSolvedLinks=Array.new
				userSolvedProblems=handle.solved_problems.split(';')
				len=0;
				response.each do |link|
					link["href"] = "https://www.codechef.com#{link["href"]}"
					if link["href"].include?("users") && handle.team == true
					;
					else
					userSolvedLinks.push(link.to_s)
				    end
			end
				diff = userSolvedLinks-userSolvedProblems
			if diff.empty?
				puts "No new submission for #{handle.username}"
			else
				puts "New submission for #{handle.username}"
				handle.solved_problems = userSolvedLinks.join(';')
				handle.save
				handle.users.each do |user|
					UserMailer.new_submission(user,diff,handle.username).deliver_now
					puts "Email sent to #{user.email}"
				end	
			end
		end
		
	end
end