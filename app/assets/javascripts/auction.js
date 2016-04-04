
window.setInterval(getAuctionData, 3000);

$(window).bind('page:change', function() {
  updateBarsColors();
});


function updateBarsColors(){  
  if (gon.role === "Supplier"){    
    $(".change-element").css("background-color", "#149c82");
    $("a.change-element").css("height", "-2px")
    $(".change-element").css("color", "#F8F8F8");
  } else {
    $(".navbar-fixed-top").addClass("back");
    $("#footer").addClass("back");
  }
}

function getAuctionData(){	
  var url = window.location.pathname;
  var lastSegment = url.split('/').pop();
  var matches = lastSegment.match(/\d+/g);
  if (url.includes("auctions/") && matches != null){
		$.ajax({
		    type: "GET",
		    url: window.location.pathname,
		    data: '',
		    success: displayData,
		    error: handleError,
		    dataType: "json"
		});
	}	
}

function displayData (response) {
    var dataset =  response;
    $('.jumbotron').empty();
    var sel = d3.select(".jumbotron.all-bids").
  		selectAll("div").
  		data(dataset);
	  sel.enter().
  		append("div").
  		attr("class", "bar").
  		style("height", function(d) {
  				return d*5 + "px";
   		});    
}

function handleError (error) {
    console.log(error);
}