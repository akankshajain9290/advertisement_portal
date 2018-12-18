$(function() {
  $(document).on('click', 'body .createBid', function(event){
    var slotId = $(this).data('slot-id');
    $('#bid-slot-id').val(slotId)
  });
});


