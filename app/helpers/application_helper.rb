module ApplicationHelper
  def check_link_status(link_status)
    if link_status
      '<button class="read-status">Mark as Unread</button>'.html_safe
    else
      '<button class="read-status">Mark as Read</button>'.html_safe
    end
  end
end
