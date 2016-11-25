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

function myFunction() {
  // Declare variables
  var input, filter, table, tr, td, i;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("DetailTable");
  tr = table.getElementsByTagName("tr");

  // Loop through all table rows, and hide those who don't match the search query
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[0];
    td2 = tr[i].getElementsByTagName("td")[1];
    td3 = tr[i].getElementsByTagName("td")[2];
    if (td || td2 || td3) {
      if (td.innerHTML.toUpperCase().indexOf(filter) > -1 || td2.innerHTML.toUpperCase().indexOf(filter) > -1 || td3.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }
}
