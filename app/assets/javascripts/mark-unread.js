$(document).ready(function(){

  $('#links-list').on('click', 'button.mark-unread', function(){

    var linkId = $(this).parents('.link').data('link-id')

    $.ajax({
      url: '/api/v1/links/' + linkId,
      method: 'PATCH',
      data: {read: false}
    }).then(markUnread)

  })

  function markUnread(link){
    $('#links-list .link[data-link-id=' + link.id + ']').removeData();
    $('#links-list .link[data-link-id=' + link.id + '] .read-status').html(
      "Read Status: False"
    );
    $('#links-list .link[data-link-id=' + link.id + ']').css('background-color', 'white');
    // $('#links-list .link[data-link-id=' + link.id + '] .button').remove();
    $('#links-list .link[data-link-id=' + link.id + '] .link-buttons').html(
      '<button type=button class="mark-read">Mark as Read</button>'
    );
  }
})
