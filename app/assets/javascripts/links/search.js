$(document).ready(function() {
  searchLinks();
});

function searchLinks() {
  $('#linkFilter').on('keyup', function(){
    var $searchQuery = $('#linkFilter').val().toLowerCase();
    checkMatches($searchQuery);
  });
};

function checkMatches(searchQuery) {
  var $links = $('#links-table').find('.link');
  $.each($links, function(index, link){
    var title = $(link).find('.link-title').text().toLowerCase();
    var url = $(link).find('.link-url').text().toLowerCase();
    if (title.indexOf(searchQuery) >= 0 || url.indexOf(searchQuery) >= 0) {
      $(link).show();
    } else {
      $(link).hide();
    };
  });
};
