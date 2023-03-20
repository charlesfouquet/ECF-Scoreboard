$(document).ready(function() {
    $(".messageToUser").slideDown();
    setActiveNav();
});

const timeout = setTimeout(hideMessage, 5000);

function hideMessage() {
	$(".messageToUser").slideUp();
}

function setActiveNav() {
	const url = window.location.href;
	if (url.includes("games")) {
		$("#nav2").addClass("active");
	} else if (url.includes("players")) {
		$("#nav3").addClass("active");
	} else if (url.includes("contests")) {
		$("#nav4").addClass("active");
	} else {
		$("#nav1").addClass("active");		
	}
}