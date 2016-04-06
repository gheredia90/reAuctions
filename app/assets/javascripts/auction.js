
var lastSegment = window.location.pathname.split('/').pop();
var matches = lastSegment.match(/\d+/g);

window.setInterval(getAuctionData, 1000);
window.setInterval(checkAuctionTime, 1000);
window.setInterval(updateBuyerColors, 1000);

function checkAuctionTime(){
  if (window.location.pathname.includes("auctions/") && (matches != null)){
    currentTime = new Date().getTime();
    msLeft = gon.end_date - currentTime;
    if (msLeft > 0){
      updateTime(msLeft);
    } else {
      closeAuction();
    }
  }
}

function updateTime(msLeft){
  minLeft = Math.floor((msLeft / 1000)/60);
  segLeft = Math.floor((msLeft / 1000)%60);
  $("#countdown").html("<h3>"+ minLeft + " minutes and " + segLeft + " seconds</h3>");
}

function closeAuction(){
  $.ajax({
    type: "POST",
    url: "/auctions/" + lastSegment
  });
  $("#countdown").html('<div class="alert alert-success" role="alert">Auction finished!</div>');
  $("#bid-options").empty();
}

function getAuctionData(){  
  if (window.location.pathname.includes("auctions/") && (matches != null)){
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

function handleError (error) {
    console.log(error);
}

function displayData (response) {
    var dataset =  response.bids;
    $('.jumbotron.all-bids').empty();
    $('#results').html(
      '<button class="btn btn-default btn-lg" type="button"> Lowest bid:  <span class="badge">' + response.lowest_bid + '</span></button>' +
       '<button class="btn btn-default btn-lg" type="button"> Supplier:   <span class="badge">' + response.supplier + '</span></button>'
    );
    $('#info').html(
      'Lowest bid:  <span class="badge">' + response.lowest_bid + '</span></button>'
    );     
    
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

function updateBuyerColors(){  
  if (gon.role === "Supplier"){    
    $(".change-element").css("background-color", "#149c82");
    $("a.change-element").css("height", "-2px")
    $(".change-element").css("color", "#F8F8F8");
  } else {
    $(".navbar-fixed-top").addClass("back");
    $("#footer").addClass("back");
  }
}

$(window).bind('page:change', function() {
  updateBuyerColors();
});

$(window).bind('page:change', function() {
  getAuctionData();
});

$(function() {
    updateBuyerColors();
});