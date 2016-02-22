class UserMailer < ApplicationMailer

	def new_submission(user,diff,username)
    @user = user
    @diff = diff
    @codechef_id = username
    mail(to: user.email, subject: "New submission from #{username}")
  end
end
