$(document).on('turbolinks:load',function(){

  $('#tabs li').click(function(){

    var index = $('#tabs li').index(this);

    $('#tabs li').removeClass('is-active');

    $(this).addClass('is-active');

    $('.tab-content .tab-pane').removeClass('is-block').eq(index).addClass('is-block')
  });
});