module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def check_to_display_post(logged_in_user, post_creator)
    logged_in_user.friends?(post_creator) or post_creator.friends?(logged_in_user) or post_creator == logged_in_user
  end
end
