$(document).ready(function() {
  onClickChangeReadStatus();
});

function onClickChangeReadStatus() {
  $('#links-table').on('click', '.read-status', function() {
    var $link = $(this).closest('tr');
    var link_id = $link.data('link-id');
    var user_id = $link.data('user-id');
    var $linkStatus = $link.find('.link-read-status')
    var status = $linkStatus.text();
    var newStatus = !status;
    changeReadStatus(newStatus, link_id, user_id, $linkStatus);
  })
};

function changeReadStatus(newStatus, link_id, user_id, $linkStatus) {
  $.ajax({
    url: "/api/v1/users/" + user_id + "/links/" + link_id,
    type: 'put',
    data: { link: { read: newStatus } }
  }).fail(handleError)
  $linkStatus.text(newStatus);
}

function handleError(error) { console.log(error) };
