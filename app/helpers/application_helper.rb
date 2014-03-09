module ApplicationHelper
  #def current_user
  #  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  #end

  # Content_for is better option to yield as the latter
  # cant be used in the application helper methods
  def page_title
    if content_for?(:title)
      "Flix - #{content_for(:title)}"
    else
      "Flix"
    end
  end
end
