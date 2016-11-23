function circleImageClick () {
    $('.deletePhoto').hide();
    $('.photoPreview').click(function() {
        $(this).attr('disabled', 'true');
        $('#uploadAvatar').trigger('click');
    });
    $("#uploadAvatar").change(function(){
        $('.photoPreview').removeAttr('disabled');
        readURL(this);
    });
  }
  function readURL(input) {
      if (input.files && input.files[0]) {
          var reader = new FileReader();

          reader.onload = function (e) {
              $('.photoPreview').css('background', 'url(' + e.target.result + ')');
              $('.photoUpload, #uploadClick').hide();
          }
          $('.deletePhoto').show();

          reader.readAsDataURL(input.files[0]);
      }
  }
  function deletePhoto () {
      $('.deletePhoto').click(function() {
          $('.deletePhoto').hide();
          $('#uploadAvatar').val('');
          $('.photoPreview').css('background', '');
          $('.photoUpload, #uploadClick').show();
      });
  }
