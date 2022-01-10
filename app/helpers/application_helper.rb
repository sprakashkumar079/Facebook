module ApplicationHelper
# Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Connect to World With Facebook"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
   # Checks whether a post or comment has already been liked by the
  # current user returning either true or false
  def liked?(subject, type)
    result = false
    result = Like.where(user_id: current_user.id, post_id:
                        subject.id).exists? if type == 'post'
    result = Like.where(user_id: current_user.id, comment_id:
                        subject.id).exists? if type == 'comment'
    result
  end
end