$(function() {
  $(document).on('click', 'body .editSlot', function(event){
    var slotId = $(this).data('slot-id');
    var startTime = $(this).data('slot-start-time');
    var endTime = $(this).data('slot-end-time');
    var price = $(this).data('slot-start-price');

    $('#advSpaceId').prop( "disabled", true );
    $('#myModalLabel').text('Edit Slot')
    $('#slotForm').attr('action',`/slots/${slotId}`)
    $('#slotForm').prepend('<input id="change-post-to-put" type="hidden" name="_method" value="patch" />');
    $('#slotStartTime').val(startTime)
    $('#slotEndTime').val(endTime)
    $('#slotPrice').val(price)
    $('#slotButton').val('Save Changes')
  });

  $(document).on('click', 'body #createSlot', function(event){
    $('#myModalLabel').text('New Slot')
    $('#slotForm').attr('action','/slots')
    $('#change-post-to-put').remove();
    $('#slotStartTime').val('')
    $('#slotEndTime').val('')
    $('#slotPrice').val('')
    $('#advSpaceId').prop( "disabled", false );
    $('#slotButton').val('Create Slot')
  });
});


