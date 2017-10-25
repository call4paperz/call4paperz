$(document).ready(function(){
	removeLoggedDiv();
});

function removeLoggedDiv(){
  setTimeout(function(){
    $('.notice').fadeOut('slow');
  }, 5000);
}

C4P = function() {}
C4P.Twitter = function() {
  var twitter = {
    loadLast: function(path) {
      $.getJSON(path, function(response) {
        $("#twitter_status").text(response.tweet.text)
        $(".twitter_status_date").text(response.tweet.created_at)
      })
    }
  }

  return twitter
}
