$(document).ready(function() {
  alphabeticSort();
});

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
    prependLinks($sortedLinks);
  } else {
    appendLinks($sortedLinks);
  };
};

function appendLinks($sortedLinks) {
  $.each($sortedLinks, function(index, link) {
    $('#links-table').append(link);
  });
  $('#alphabetic-sort').removeClass('descending-order');
  $('#alphabetic-sort').addClass('ascending-order');
};

function prependLinks($sortedLinks) {
  $.each($sortedLinks, function(index, link) {
    $('#links-table').prepend(link);
  });
  $('#alphabetic-sort').removeClass('ascending-order');
  $('#alphabetic-sort').addClass('descending-order');
};
