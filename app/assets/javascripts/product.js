var Products = {
  load: function() {
    $('.product-forms').on('change', '[name="product[product_images][]"]', function(e) {
      var $holder = $(e.target).closest('.product-images-holder');
      var $siblings = $('.product-images-holder').not($holder);
      $siblings.html('');
      $.each($holder.find('input[type=file]'), function(index, input) {
        $siblings.append($(input).clone());
      });
    });

    $('.drop-zone').dropzone({
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      url: $('.drop-zone').data('url'),
      createImageThumbnails: false,
      success: function(response) {
        eval(response.xhr.response);
      }
    });

    $('#product-images').sortable();
  }
}

$(document).on('turbolinks:load', Products.load);
