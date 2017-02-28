var $newLinkTitle, $newLinkUrl;

$(document).ready(function(){

  $('#links-list').on('click', 'button.mark-read', function(){

    var linkId = $(this).parents('.link').data('link-id')
    var linkTitle = $(this).parents('.link').data('link-title')

    $.ajax({
      type: "POST",
      url: "http://localhost:3000/reads",
      data: {url: linkTitle},
    }).then(makeCall)

    $.ajax({
      url: '/api/v1/links/' + linkId,
      method: 'PATCH',
      data: {read: true}
    }).then(markRead)
  });

  function makeCall(data) {
    $.ajax({
      type: "GET",
      url: "http://localhost:3000/api/v1/reads"
    }).then(prepareHotness)
  }

  function prepareHotness(data) {
    var linkArray = $('#links-list .link').toArray();
    $('#links-list').html('');
    var dataUrls = data.map(function(data) { return data.url; })
    var topLinks = linkArray.filter(function(link) {
      return dataUrls.includes(link.getAttribute('data-link-title'));
    });
    var theRest = linkArray.filter(function(link) {
      return !dataUrls.includes(link.getAttribute('data-link-title'));
    });
    for(var i = 0; i < topLinks.length; i++) {
      if(i == 0) {
        $(topLinks[i]).css('background-color', 'red');
      } else {
        $(topLinks[i]).css('background-color', 'pink');
      }
      $('#links-list').append(topLinks[i]);
    };
    theRest.forEach(function(link) {
      $('#links-list').append(link);
    });
  }

  function markRead(link) {
    $('#links-list .link[data-link-id=' + link.id + ']').removeData();
    $('#links-list .link[data-link-id=' + link.id + '] .read-status').html(
      "Read Status: True"
    );
    $('#links-list .link[data-link-id=' + link.id + ']').css('background-color', 'lightgrey');
    // $('#links-list .link[data-link-id=' + link.id + '] .button').remove();
    $('#links-list .link[data-link-id=' + link.id + '] .link-buttons').html(
      '<button type=button class="mark-unread">Mark as Unread</button>'
    );
  }
})
