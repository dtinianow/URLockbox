$(document).ready(function() {
  getIdeas();
});

function getIdeas() {
  $.ajax({
    type: 'get',
    url: '/api/v1/links'
  }).then(collectLinks)
  .then(renderLink)
  .fail(handleError)
};

// function collectLinks( linksData ) {
//   return linksData.map(createLinkHTML);
// };
//
// function renderLink( linkData ) {
//   $('#links-table').prepend(linkData);
// };
