$(document).ready(function(){

	$('.rr').hover(
		function(){
			$(this).fadeTo("slow", 0.1);				
		},
		function(){
			$(this).fadeTo("slow", 1);
		}
	)

	$(document).ready(function(){
		setTimeout(function(){
			$("#tweeting").fadeIn('slow');
		}, 10000);
	});

	removeLoggedDiv();
});


function removeLoggedDiv(){
	setTimeout(function(){
//		$('#logged').fadeOut('slow');
	}, 5000);
}

