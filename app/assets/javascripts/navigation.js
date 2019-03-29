var Navigation = {
  load: function() {
    $('.js-menu-button').on('click', function() {
      $('#tablet-nav, #mobile-nav').click();
      return false;
    });

    $('.js-collabortion-menu').on('click', function() {
      $('.dropdown-content').toggle();
    });

    $('.fa-times').on('click', function() {
      $('#tablet-nav, #mobile-nav').click();
    });

    $('.mobile-nav-toggle').on('click', function() {
      $('#tablet-nav, #mobile-nav').click();
    });
  }
}

$(document).on('turbolinks:load', Navigation.load);

$(document).mouseup(function(e) {
  var container = $(".tablet-nav");

  if (!container.is(e.target)  && container.is(":visible")) {
   $('#tablet-nav, #mobile-nav').click();
  }
});
