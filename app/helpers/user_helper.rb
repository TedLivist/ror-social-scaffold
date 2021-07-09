module UserHelper
  def user_show_add_friend(logged_in_user, other_user)
    logged_in_user != other_user and !logged_in_user.check_friendship?(other_user)
  end

  def users_index_add_friend(user, other_user)
    user != other_user and !user.check_friendship?(other_user) and !other_user.check_friendship?(user)
  end
end
