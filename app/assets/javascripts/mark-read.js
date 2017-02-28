var $newLinkTitle, $newLinkUrl;

$(document).ready(function(){

  $('#links-list').on('click', 'button.mark-read', function(){

    var linkId = $(this).parents('.link').data('link-id')
    var linkTitle = $(this).parents('.link').data('link-title')

    $.ajax({
      type: "POST",
      url: "http://localhost:3000/reads",
      data: {url: linkTitle}
    })

    // $.ajax({
    //   type "GET",
    //   url: "http://localhost:3000/api/v1/reads"
    // })

    $.ajax({
      url: '/api/v1/links/' + linkId,
      method: 'PATCH',
      data: {read: true}
    });

  })
})
