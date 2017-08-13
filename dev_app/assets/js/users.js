$(function() {
  console.log("document ready");

  $.getJSON("/api/users", function(data){
    console.log(data);
    var users = data['users'];
    $.each(data['users'], function(index) {
      var user = users[index];
      var str = user['name'] + ' - ' + user['bio'] + ', pets = ' + user['number_of_pets'];
      $('<p>').text(str)
              .appendTo($('#users'));
    });
  })
})
