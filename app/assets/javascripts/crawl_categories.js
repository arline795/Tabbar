var CrawlCategories = {
  load: function() {
    $('.js-add-category').on('click', function() {
      $('.categories-wrapper').append($('.category-wrapper')[0].outerHTML);
      return false;
    });

    $('.categories-wrapper').on('click', '.js-remove-category', function(e) {
      if ($('.category-wrapper').length > 1) {
        $(e.target).closest('.category-wrapper').remove();
      }
      return false;
    });
  }
}

$(document).on('turbolinks:load', CrawlCategories.load);
