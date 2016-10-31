module ApplicationHelper
  def check_link_status(link_status)
    if link_status
      '<button class="read-link">Mark as Unread</button>'.html_safe
    else
      '<button class="unread-link">Mark as Read</button>'.html_safe
    end
  end
end
