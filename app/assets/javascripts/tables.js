var Tables = {
  load: function() {
    $('#example').dataTable({
      'order': [],
      'columnDefs': [ {
        'targets': 'no-sort',
        'orderable': false,
      }]
    });

    $('#example').on('click', '.js-tag', function(e) {
      var $target = $(e.target);
      var href = $target.prop('href');
      var pricePerClick = $target.closest('tr').find('[name="price_per_click"]').val();
      $target.prop('href', href + '&price_per_click_in_cents=' + pricePerClick * 100);
      return true;
    })
  }
}

$(document).on('turbolinks:load', Tables.load);
