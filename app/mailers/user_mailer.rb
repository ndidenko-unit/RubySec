class UserMailer < ApplicationMailer
  default from: "5773480@gmail.com"

  def new_data(data)
    @users = User.all
    @data = data
    @users.each do |user|
      mail to: user.email, subject: "New advisories in rubygems!"
    end
  end
end
