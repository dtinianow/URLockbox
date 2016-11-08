$(document).ready(function() {
  changeReadStatus();
});

function changeReadStatus() {
  $('#links-table').on('click', '.read-status', function(e) {
    var $link = $(this).closest('tr');
    var link_id = $link.data('link-id');
    var user_id = $link.data('user-id');
    var status = $link.find('.link-read-status').text();
    var newStatus = checkStatus(status);
    updateStatus(newStatus, link_id, user_id);
    changeButtonText(newStatus, $link);
  });
};

function checkStatus(status) {
  return status === 'false' ? true : false;
};

function updateStatus(newStatus, link_id, user_id) {
  $.ajax({
    url: "/api/v1/users/" + user_id + "/links/" + link_id,
    type: 'put',
    data: { link: { read: newStatus } }
  }).fail(handleError);
};

function changeButtonText(newStatus, $link) {
  var $linkStatus = $link.find('.link-read-status');
  var $linkButton = $link.find('.read-status');
  var $linkUrl = $link.find('.link-url');

  $linkStatus.text(newStatus);
  if ($linkButton.text() == 'Mark as Read') {
    $linkUrl.addClass('read-link');
    $linkButton.text('Mark as Unread');
  } else {
    $linkUrl.removeClass('read-link');
    $linkButton.text('Mark as Read');
  };
};

function handleError(error) { console.log(error) };
