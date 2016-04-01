
function getAuctionData(){
	$.ajax({
	    type: "GET",
	    url: window.location.pathname,
	    data: '',
	    success: displayData,
	    error: handleError,
	    dataType: "json"
	});
}

window.setInterval(getAuctionData, 5000);

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