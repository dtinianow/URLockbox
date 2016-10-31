$(document).ready(function() {
  onClickChangeReadStatus();
});

function onClickChangeReadStatus() {
  $('#links-table').on('click', '.read-status', function() {
    var $link = $(this).closest('tr');
    var link_id = $link.data('link-id');
    var user_id = $link.data('user-id');
    var $linkStatus = $link.find('.link-read-status')
    var $linkButton = $link.find('.read-status')
    var status = $linkStatus.text().toString();
    var newStatus = !status;
    changeReadStatus(newStatus, link_id, user_id, $linkStatus, $linkButton);
  })
};

function changeReadStatus(newStatus, link_id, user_id, $linkStatus, $linkButton) {
  $.ajax({
    url: "/api/v1/users/" + user_id + "/links/" + link_id,
    type: 'put',
    data: { link: { read: newStatus } }
  }).fail(handleError)
  $linkStatus.text(newStatus);
  if ($linkButton.text() == 'Mark as Read') {
    $linkButton.text('Mark as Unread');
  } else {
      $linkButton.text('Mark as Read');
    };
    // console.log($linkButton.text())
  };

  function handleError(error) { console.log(error) };
