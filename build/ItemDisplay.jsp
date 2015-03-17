
<%@ page import="edu.ucla.cs.cs144.*" %>
<%@ page import="edu.ucla.cs.cs144.SearchResult" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="javax.xml.bind.*" %>
<%@ page import="edu.ucla.cs.cs144.Item" %>
<%@ page import="edu.ucla.cs.cs144.Item.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>

<html>
<head>
    <title> Item Page </title>
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
    <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <script language="JavaScript" type="text/javascript" src="autosuggest.js"></script>
    <script language="JavaScript" type="text/javascript" src="suggestprov.js"></script>
    <link rel="stylesheet" type="text/css" href="suggest.css" />
    <script type="text/javascript">
        window.onload = function () {
          var oTextbox = new AutoSuggestControl(document.getElementById("txt1"), new StateSuggestions()); 
        }
    </script>

    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" /> 
    <style type="text/css"> 
          html { height: 100% } 
          body { height: 100%; margin: 0px; padding: 0px } 
          #map_canvas { height: 100% } 
    </style> 
      
    <script type="text/javascript" 
        src="http://maps.google.com/maps/api/js?sensor=false"> 
    </script> 

    <script type="text/javascript"> 
      var geocoder;

      /*function initialize() { 
        //var latt = 41.901849;
        //var longt = -75.10493;
        /*var latlng = new google.maps.LatLng(41.901849, -75.10493); 
        var myOptions = { 
          zoom: 14, // default is 8  
          center: latlng, 
          mapTypeId: google.maps.MapTypeId.ROADMAP 
        }; 
        var map = new google.maps.Map(document.getElementById("map_canvas"), 
            myOptions); 
      geocoder = new google.maps.Geocoder();
      } */

     function codeAddress() {

 
        var latitude = document.getElementById("latitude").value;
        var longitude = document.getElementById("longitude").value;


      if (latitude == "null" || longitude == "null")
      {
        var address = document.getElementById("location").value;
        geocoder = new google.maps.Geocoder();
        geocoder.geocode( { 'address': address}, function(results, status) {
          if (status == google.maps.GeocoderStatus.OK) {
            var myOptions = {
              zoom: 10, // default is 8 
              mapTypeId: google.maps.MapTypeId.ROADMAP 
            };
            var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
            map.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
                map: map,
                position: results[0].geometry.location 
            });
          }
        });
      }
      else
      {

            var latlng = new google.maps.LatLng(latitude, longitude); 
            var myOptions = { 
              zoom: 10, // default is 8  
              center: latlng, 
              mapTypeId: google.maps.MapTypeId.ROADMAP 
            }; 
            var map = new google.maps.Map(document.getElementById("map_canvas"), 
                myOptions); 
          geocoder = new google.maps.Geocoder();
      }
    }

    </script>


</head>
<body onload="codeAddress()">
<nav class="navbar navbar-default">
	<div class="collapse navbar-collapse">
		<ul class="nav nav-pills">
		  <li role="presentation" class="active"><a href="/eBay/keywordSearch.html">Home</a></li>

		  <li> 
      <form action="search" method="GET" class="navbar-form navbar-left" role="search">
		  <div class="form-group">
		    <input type="text" name="q" id="txt1">
		    <input type="hidden" name="numResultsToSkip" value="0">
		    <input type="hidden" name="numResultsToReturn" value="10">

		  </div>
		  <button type="submit" class="btn btn-default">Search!</button>
		  </form> 
        </li>
        <li> 
            <form action="/eBay/item" method="GET" class="navbar-form navbar-right" role="search">
            <div class="form-group">
            <input type="text" name="id">
            </div>
            <button type="submit" class="btn btn-default">Search Corresponding ID!</button>
          </form>
        </li>
		</ul>

	</div>
</nav>


<div class="container">
<!-- 	<p><%= request.getAttribute("title") %></p>
    <p><%= request.getAttribute("q") %></p>
    <p><%= request.getAttribute("numResultsToSkip") %></p> -->
<!--    <p> <%= request.getAttribute("xml") %> </p>
 -->    <p> <% 
    		Item result = (Item) request.getAttribute("result");
          String UserID = result.Seller.UserID;
          // out.println(UserID);
            // List<Bid> bid = (List<Bid>) request.getAttribute("sorted_bids");
        	{ %>
          <input type="text" id="location" style="visibility: hidden;" value="<%out.println(result.Location.Loc_Name); %>">
          <input type="text" id="longitude" style="visibility: hidden;" value="<%out.println(result.Location.Longitude); %>">
          <input type="text" id="latitude" style="visibility: hidden;" value="<%out.println(result.Location.Latitude); %>">
          <div class="table-responsive panel panel-primary">
              <!-- Default panel contents -->
          <div class="panel-heading">Search Results</div>
        	<table class="table">
            <tr>
                <td> ItemID </td>
                <td> Name </td>
                <td> Category </td>
                <td> Currently </td>
                <td> Buy Price </td>
                <td> First Bid </td>
                <td> Number Of Bids </td>
                <td> Bids </td>
                <td> Location </td>
                <td> Country </td>
                <td> Started </td>
                <td> Ends </td>
                <td> Seller </td>
            </tr>
        	<tr> 
        		<td> <%out.println(result.ItemID); %> </td>
        		<td> <%out.println(result.Name); %> </td>
                <td> <%out.println(result.Category); %> </td>
                <td> <%out.println(result.Currently); %> </td>
                <td> <%out.println(result.Buy_Price); %> </td>
                <td> <%out.println(result.First_Bid); %> </td>
                <td> <%out.println(result.Number_of_Bids); %> </td>
                <td> <% 
                        List<Bid> bid = result.bids.bid;
                        Collections.sort(bid, new Comparator<Item.Bid>() {
                                @Override
                                public int compare(Item.Bid b1, Item.Bid b2){
                                        int t1 = 0;
                                        int t2 = 0;
                                        try{
                                                SimpleDateFormat form = new SimpleDateFormat("MMM-dd-yy HH:mm:ss");
                                                Date d1 = form.parse(b1.Time);
                                                Date d2 = form.parse(b2.Time);
                                                t1 = (int)d1.getTime();
                                                t2 = (int)d2.getTime();
                                        }
                                        catch(ParseException e){
                                                System.out.println("parsing error");
                                        }
                                        return t2 - t1;
                                }
                        });
                        for (int i = 0; i < bid.size(); i++)
                        {
                            //show bidders
                            out.println("<p>");
                            List<Bidder> bidder = bid.get(i).bidder;
                            out.println("Bidders: ");
                            for (int j = 0; j < bidder.size(); j++)
                            {
                              out.println("ID: " + bidder.get(j).ID);
                              out.println("Rating: "+ bidder.get(j).Rating);
                              out.println("Location: " + bidder.get(j).Location);
                              out.println("Country: " + bidder.get(j).Country);
                            }
                            out.println("Bidding time: " + bid.get(i).Time);
                            out.println("Bidding amount: " + bid.get(i).Amount + "</p>");
                        }
                        //out.println(bid.size());
                        //for(int i = 0; i < bid.size(); i++)
                        //{
                        //    out.println(bid.get(i).Time);
                        //}
                 %> </td>
                <td> <%out.println(result.Location.Loc_Name); %> </td>
                <td> <%out.println(result.Country); %> </td>
                <td> <%out.println(result.Started); %> </td>
                <td> <%out.println(result.Ends); %> </td>
                <td> <%out.println("SellerID:" + result.Seller.UserID); %>
                   <%out.println("Rating:" + result.Seller.Rating); %>  </td>
                


            </tr>
            </table>
          </div>

          <div class="panel panel-primary">
            <div class="panel-heading">Item Description</div>
              <div class="panel-content"> 
              <p> <%out.println(result.Description); %> </p> 
              </div>
            </div>

          <p>
            <% if (result.Buy_Price != null) { %>
              <a class="btn btn-danger btn-lg" href="./buy?id=<%=result.ItemID %>"> BUY BUY </a>
            <% } %>
          </p>

            <%
        	} 
        	%> 

 	</p>

        <div id="map_canvas" style="width:75%; height:75%"></div>


</div> 
</body>
</html>