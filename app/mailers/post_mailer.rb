class PostMailer < ApplicationMailer
  def post_mail(post)
    @post = post
    mail to: "saidediaw2010@yahoo.com", subject: "Inquiry confirmation email"
  end
end
