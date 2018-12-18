$(document).ready(function() {
  $(function() {
    $(document).on('click', 'body .editAdvSpace', function(event){
      var advSpaceId =  $(this).data('adv-id');
      var advSpaceName =  $(this).data('adv-name');
      $('#myModalLabel').text('Edit Advertisment Space Name')
      $('#advSpaceForm').attr('action',`/adv_spaces/${advSpaceId}`)
      $('#advSpaceForm').prepend('<input id="change-post-to-put" type="hidden" name="_method" value="patch" />');
      $('#advSpaceName').val(advSpaceName)
      $('#advSpaceButton').val('Save Changes')
    });

    $(document).on('click', 'body #createAdvSpace', function(event){
      $('#myModalLabel').text('Create Advertisement Space')
      $('#advSpaceForm').attr('action','/adv_spaces')
      $('#change-post-to-put').remove();
      $('#advSpaceName').val('')
      $('#advSpaceButton').val('Create Adv Space')
    });
  });
});

