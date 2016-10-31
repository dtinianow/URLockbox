$(document).ready(function() {
  onClickChangeReadStatus();
  searchLinks();
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
