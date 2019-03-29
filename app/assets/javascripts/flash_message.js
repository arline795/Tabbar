$(document).on('turbolinks:load', function(){
  $('.js-flash-message').click(function(){
      $('.js-flash-message').hide();
  });

  setTimeout(function(){
    $('.js-flash-message').fadeOut();
  }, 3000);
})
