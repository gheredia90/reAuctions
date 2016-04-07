
var lastSegment = window.location.pathname.split('/').pop();
var matches = lastSegment.match(/\d+/g);
var supplier, lowest_bid = "";

window.setInterval(getAuctionData, 1000);
window.setInterval(checkAuctionTime, 500);
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
  $('#results-supplier').html(
      '<button class="btn btn-default btn-lg" type="button"> Lowest bid:  <span class="badge">' + lowest_bid + '</span></button>' +
       '<button class="btn btn-default btn-lg" type="button"> Supplier:   <span class="badge">' + supplier + '</span></button>'
  );
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
    var dataset =  response.dataset;
    var names = response.names;
    diplayBidsData(response);  
    displayBarChart(dataset);    
}

function diplayBidsData(response){
  $('.jumbotron.all-bids').empty();
  $('#results').html(
      '<button class="btn btn-default btn-lg" type="button"> Lowest bid:  <span class="badge">' + response.lowest_bid + '</span></button>' +
      '<button class="btn btn-default btn-lg" type="button"> Supplier:   <span class="badge">' + response.supplier + '</span></button>'
  );
  $('#info').html(
    'Lowest bid:  <span class="badge">' + response.lowest_bid + '</span></button>'
  ); 
  lowest_bid = response.lowest_bid;
  supplier = response.supplier;  
}

function displayBarChart(dataset, names){
  d3.select(".jumbotron.all-bids")
    .selectAll("div")
    .data(dataset)
    .enter()
    .append("div")
    .attr("class", "bar")
    .style("background-color", stringToHexNumber)
    .style("height", function(d) {
      return d.value*8 + "px";
    })
}

function stringToHexNumber(d){
  var stringHexNumber = (parseInt(parseInt(d.name, 36)  
      .toExponential()                  
      .slice(2,-5)                      
  , 10) & 0xFFFFFF                          
  ).toString(16).toUpperCase();
  return '#' + ('000000' + stringHexNumber).slice(-6);
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