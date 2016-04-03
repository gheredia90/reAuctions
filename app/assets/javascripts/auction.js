
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
  if (window.location.pathname.includes("auctions/")){
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
    console.log(dataset)
    $('.jumbotron').empty();
    var sel = d3.select(".jumbotron").
		selectAll("div").
		data(dataset);
	sel.enter().
		append("div").
		attr("class", "bar").
		style("height", function(d) {
				return d*5 + "px";
 		});	
    
    $("bids-list").append("<li>hola</li>")
}

function handleError (error) {
    console.log(error);
}