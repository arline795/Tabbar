var InstagramImages = {
  load: function(){
    var username = location.pathname.substring(1).split('/')[0];
    if ($('#media-count').length) {
      $.ajax({
        url: '/' + username + '/images_count',
        success: function(response) {
          $('#media-count').html(response.count);
        }
      });
    }

    if ($('.js-load-more').length == 0) {
      return;
    }

    var exceptMedias = $('.except-medias').data('except') || [];
    var exceptContainerQuery = $.map(exceptMedias, function(mediaId) {
      return '[data-instagram-media-id="' + mediaId + '"]';
    }).join(',');

    $('#instagram-images-container').on('click', '.js-load-more', function(e) {
      if ($('.loading').length > 0) {
        return false;
      }
      var $target = $(e.target);
      var $container = $target.closest('.load-more-container');
      var maxId = $target.data('max-id');
      $container.after('<div class="loading"></div>');
      $container.hide();
      $.ajax({
        url: '/load_more_instagram_images?max_id=' + maxId + '&username=' + username,
        success: function(response) {
          $container.after(response);
          $container.remove();
          $('.empty-cell').remove();
          $('.loading').remove();
          $(exceptContainerQuery).remove();
          if ($('.cell-item').length % 3 == 2) {
            if ($('.load-more-container').length) {
              $('.load-more-container').before('<div class="c1in3 empty-cell">');
            } else {
              $('.cell-list').append('<div class="c1in3 empty-cell">');
            }
          }
        }
      });
      return false;
    });

    $(window).on('scroll', function() {
      if($(window).scrollTop() == $(document).height() - $(window).height()) {
        $('.js-load-more').trigger('click');
      }
    });

    $('.js-load-more').trigger('click');
  }
}

$(document).on('turbolinks:load', InstagramImages.load);
