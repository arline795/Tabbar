var Medias = {
  load: function() {
    $('.js-media-likes-fetch').each(function() {
      var $this = $(this);
      var id = $this.data('id');

      $.getJSON('/instagram_medias/' + id, function(data) {
        if (data.likes >= 0) {
          $this.html(data.likes + ' Likes');
        }
      });
    });
  }
}

$(document).on('turbolinks:load', Medias.load);
