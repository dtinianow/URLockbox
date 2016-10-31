$(document).ready(function() {
  checkListStatus();
});


// function getIdeas() {
//   $.ajax({
//     type: 'get',
//     url: '/api/v1/links'
//   }).then(collectLinks)
//   .then(renderLink)
//   .fail(handleError)
// };
//
// function collectLinks( linksData ) {
//   return linksData.map(createLinkHTML);
// };
//
// function createLinkHTML( link ) {
//   return $(
//     "<tr class=link data-id='"
//     + idea.id
//     + "'><td class=link-title contenteditable='true'>"
//     + link.title
//     + "</td><td class=link-body contenteditable='true'>"
//     + truncate(link.body)
//     + "</td><td class=link-quality>"
//     + link.quality
//     + "<td><button type='button' class='btn btn-success upvote-link'>Upvote</button></td>"
//     + "<td><button type='button' class='btn btn-primary downvote-link'>Downvote</button></td>"
//     + "</td><td><button class='btn btn-danger delete-link'>Delete</button></td>"
//     + "</tr>"
//   )
// };
// function renderLink( linkData ) {
//   $('#links-table').prepend(linkData);
// };

//
// function truncate( body ) {
//   return body.split(' ').slice(0, 100).join(" ")
// };

// function handleError( error ) { console.log(error) };
