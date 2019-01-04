module UsersHelper
  def gravatar_for(user, size=50)
    id = Digest::MD5::hexdigest(user.email.downcase)
    url = "https://secure.gravatar.com/avatar/#{id}?s=#{size}"
    image_tag(url, alt: "#{user.name} gravatar", class: "gravatar")
  end
end
