// Show preview of what is about to be uploaded

window.onload = function () {
  local_files_added();
};

function list_files(){
  var all_files = $('#file_upload_my_files').get(0).files
  $('.content').append('<h3 class=\'image_upload\'>'+all_files.length+' Files to upload to this album:</h3>')
  $.each(all_files, function(index, file){
    $('.content').append('<p class=\'image_upload\'>'+file.name+'</p>');
  });
 };

function local_files_added(){
  $('#file_upload_my_files').change(function() {
    $('.image_upload').remove();
    list_files();
  });
};