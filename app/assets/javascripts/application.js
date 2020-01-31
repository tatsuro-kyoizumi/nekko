// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require bulma
//= require_tree .
//= require cocoon




// マイページのタブ切り替え
    $(document).on('turbolinks:load',function(){


      $('body').css("display", "none");
      $(window).on("load", function(){
      $('body').delay(600).fadeIn("slow");
      });



      $('#tabs li').click(function(){

        var index = $('#tabs li').index(this);

        $('#tabs li').removeClass('is-active');

        $(this).addClass('is-active');

        $('.tab-content .tab-pane').removeClass('is-block').eq(index).addClass('is-block')
      });




// function newFunction() {
//   $(document).on("turbolinks:load", function () {
//     $(window).fadeThis();
//   });
// }
// ここまで

// $(function(){
//   $(window).scroll(function(){
//     $('.fadeIn').each(function(){
//       var targetElement = $(this).offset().top;
//       var scroll = $(window).scrollTop();
//       var windowHeight = $(window).height();
//       if(scroll > targetElement - windowHeight + 200){
//         $(this).css('opacity', '1');
//         $(this).css('transform', 'translateY(0)');
//       }
//     });

//   });
// });

(function(){
  $(document).on('click', '.toggle-window', function(event){
    event.preventDefault();
    var panel = $(this).parent().parent();
    var messages_list = panel.find('.messages-list');

    panel.find('.panel-block').toggle();
    panel.attr('class', 'panel');

    if (panel.find('.panel-block').is(':visible')){
      var height = messages_list[0].scrollHeight;
      messages_list.scrollTop(height);
    }
  });
})();
});