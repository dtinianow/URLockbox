module ApplicationHelper
  def check_link_status(link_status)
    if link_status
      '<td><button class="read-link">Mark as Unread</button></td>'.html_safe
    else
      '<td><button class="unread-link">Mark as Read</button></td>'.html_safe
    end
  end
end
