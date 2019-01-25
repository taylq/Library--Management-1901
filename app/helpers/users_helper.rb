module UsersHelper
  def role_choice
    User.roles.keys.map{|role| [t("#{role}"), role]}
  end
end
