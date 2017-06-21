$(document).ready(function(){
  $('#micropost_picture').bind('change', function() {
    var size = $('.picture').attr('data-attribute');
    var size_in_megabytes = this.files[0].size/1024/1024;
    debugger
    if (size_in_megabytes > size) {
      alert(I18n.t('microposts.file_size'));
    }
  });
})
