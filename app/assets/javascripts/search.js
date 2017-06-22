$(document).ready(function(){
  var typingTimer;
  var doneTypingInterval = 500;
  var $input = $('.search_box');
  $('.search-area').hide();

  $input.on('keyup', function () {
    clearTimeout(typingTimer);
    typingTimer = setTimeout(doneTyping, doneTypingInterval);
  });

  $input.on('keydown', function () {
    clearTimeout(typingTimer);
  });

  function doneTyping () {
    $.ajax({
      type: 'GET',
      dateType: 'json',
      url: '/users',
      data: {name: $('.search_box').val(), search:true},
      success: function(data){
        if($('.search_box').val()===''){
          $('.search-area').hide();
          $('.search-area').html('');
        }
        else{
          $('.search-area').show();
          $('.search-area').html(data.html_search);
        }
      }
    })
  }
})
