$(document).ready(function() {
  onClickChangeReadStatus();
  searchLinks();
  filterLinksByStatus('#show-only-unread', 'false');
  filterLinksByStatus('#show-only-read', 'true');
  showAllLinks();
  alphabeticSort();
});

function onClickChangeReadStatus() {
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

function alphabeticSort() {
  $('#alphabetic-sort-button').on('click', function() {
    var $links = $('#links-table').find('.link');
    var $sortedLinks = _.sortBy($links, function(link) {
      return $(link).find('.link-title').text().toLowerCase();
    });
    addSortedLinksToTable($sortedLinks)
  });
};

function addSortedLinksToTable($sortedLinks) {
  if ($('#alphabetic-sort').hasClass('ascending-order')) {
    $.each($sortedLinks, function(index, link) {
      $('#links-table').prepend(link);
    });
    $('#alphabetic-sort').removeClass('ascending-order');
    $('#alphabetic-sort').addClass('descending-order');
  } else {
    $.each($sortedLinks, function(index, link) {
      $('#links-table').append(link);
    });
    $('#alphabetic-sort').removeClass('descending-order');
    $('#alphabetic-sort').addClass('ascending-order');
  };
};
