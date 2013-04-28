$(document).ready(function(){

	$('.rr').hover(
		function(){
			$(this).fadeTo("slow", 0.1);
		},
		function(){
			$(this).fadeTo("slow", 1);
		}
	)

	removeLoggedDiv();
});

function removeLoggedDiv(){
  setTimeout(function(){
    $('.notice').fadeOut('slow');
  }, 5000);
}

