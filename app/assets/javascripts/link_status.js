$(document).ready(function() {
  onClickChangeReadStatus();
  searchLinks();
  filterReadLinks();
  filterUnreadLinks();
  filterAllLinks();
});

function onClickChangeReadStatus() {
  $('#links-table').on('click', '.read-status', function() {
    var $link = $(this).closest('tr');
    var link_id = $link.data('link-id');
    var user_id = $link.data('user-id');
    var $linkStatus = $link.find('.link-read-status')
    var $linkButton = $link.find('.read-status')
    var status = $linkStatus.text();
    var newStatus = checkStatus(status);
    changeReadStatus(newStatus, link_id, user_id, $linkButton);
    changeButtonText(newStatus, $linkButton, $linkStatus);
  })
};

function checkStatus(status) {
  if (status === 'false') {
    return true;
  } else {
    return false;
  };
};

function changeReadStatus(newStatus, link_id, user_id, $linkButton) {
  $.ajax({
    url: "/api/v1/users/" + user_id + "/links/" + link_id,
    type: 'put',
    data: { link: { read: newStatus } }
  }).fail(handleError)
};

function changeButtonText(newStatus, $linkButton, $linkStatus) {
  $linkStatus.text(newStatus);
  if ($linkButton.text() == 'Mark as Read') {
    $linkButton.text('Mark as Unread');
  } else {
    $linkButton.text('Mark as Read');
  };
};

function handleError(error) { console.log(error) };

function searchLinks() {
  $('#linkFilter').on('keyup', function(){
    var $searchQuery = $('#linkFilter').val()
    checkMatches($searchQuery)
  })
}

function checkMatches(searchQuery) {
  var $links = $('#links-table').find('.link')
  $.each($links, function(index, link){
    var title = $(link).find('.link-title').text()
    var url = $(link).find('.link-url').text()
    if (title.indexOf(searchQuery) >= 0 || url.indexOf(searchQuery) >= 0) {
      $(link).show();
    } else {
      $(link).hide();
    }
  })
}

function filterReadLinks() {
  $('#show-only-read').on('click', function() {
    var $links = $('#links-table').find('.link')
    $.each($links, function(index, link) {
      var status = $(link).find('.link-read-status').text()
      if (status === true) {
        $(link).show();
      } else {
        $(link).hide();
      }
    })
  })
}

function filterUnreadLinks() {
  $('#show-only-unread').on('click', function() {
    var $links = $('#links-table').find('.link')
    $.each($links, function(index, link) {
      var status = $(link).find('.link-read-status').text()
      if (status === false) {
        $(link).show();
      } else {
        $(link).hide();
      }
    })
  })
}

function filterAllLinks() {
  $('#show-all').on('click', function() {
    var $links = $('#links-table').find('.link')
    $.each($links, function(index, link) {
      var status = $(link).find('.link-read-status').text()
      $(link).show();
    })
  })
}
