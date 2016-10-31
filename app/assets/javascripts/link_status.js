$(document).ready(function() {
  onClickChangeReadStatus();
});

function onClickChangeReadStatus() {
  $('#links-table').on('click', '.read-link', function() {
    var $link = $(this).closest('tr');
    var $linkStatus = $link.find('.link-read-status')
    var status = $linkStatus.text();
    var newStatus = !status;
    console.log(newStatus)
    // changeReadStatus();
  })
};

// function changeReadStatus(newStatus) {
//   $.ajax({
//
//   })
// }

// function editIdeaQuality(newQuality, $idea, $quality){
//   $.ajax({
//     url: '/api/v1/ideas/' + $idea.data('id'),
//     type: 'put',
//     data: { idea: { quality: newQuality } }
//   }).fail(handleError)
//   $quality.text(newQuality);
// }
//
