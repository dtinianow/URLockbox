$(document).ready(function() {
  filterLinksByStatus('#show-only-unread', 'false');
  filterLinksByStatus('#show-only-read', 'true');
  showAllLinks();
});

function filterLinksByStatus(statusClass, condition) {
  $(statusClass).on('click', function() {
    var $links = $('#links-table').find('.link')
    $.each($links, function(index, link) {
      applyFilterBasedOnStatus(link, condition);
    });
  });
};

function applyFilterBasedOnStatus(link, condition) {
  var status = $(link).find('.link-read-status').text()
  if (status === condition) {
    $(link).show();
  } else {
    $(link).hide();
  };
};

function showAllLinks() {
  $('#show-all').on('click', function() {
    var $links = $('#links-table').find('.link');
    $.each($links, function(index, link) {
      $(link).show();
    });
  });
};
