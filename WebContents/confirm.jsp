<%@ page import="edu.ucla.cs.cs144.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="edu.ucla.cs.cs144.Item" %>
<%@ page import="edu.ucla.cs.cs144.Item.*" %>

<html>
<head>
    <title> Confirmation Page </title>
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
</head>
<nav class="navbar navbar-default">
	<div class="collapse navbar-collapse">
		<ul class="nav nav-pills">
		  <li role="presentation" class="active"><a href="http://<%=request.getServerName()%>:1448<%=request.getContextPath()%>/keywordSearch.html">Home</a></li>

		  <li> 
      <form action="http://<%=request.getServerName()%>:1448<%=request.getContextPath()%>/search" method="GET" class="navbar-form navbar-left" role="search">
		  <div class="form-group">
		    <input type="text" name="q" id="txt1">
		    <input type="hidden" name="numResultsToSkip" value="0">
		    <input type="hidden" name="numResultsToReturn" value="10">

		  </div>
		  <button type="submit" class="btn btn-default">Search!</button>
	  </form> 
        </li>
        <li> 
            <form action="http://<%=request.getServerName()%>:1448<%=request.getContextPath()%>/item" method="GET" class="navbar-form navbar-right" role="search">
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
   <p> <% 
    	Item result = (Item) request.getAttribute("item_info"); 
    	String card_num = (String) request.getAttribute("card_info");
    	String date = (String) request.getAttribute("date");
    	%>
    <div class="table-responsive panel panel-primary">
    <div class="panel-heading">Payment Confirmation</div>
    	<table class="table">
            <tr>
                <td> ItemID </td>
                <td> <%out.println(result.ItemID); %> </td>
            </tr>

            <tr>
                <td> Name </td>
                <td> <%out.println(result.Name); %> </td>
            </tr>

            <tr> 
        		<td> Buy Price </td>
        		<td> <%out.println(result.Buy_Price); %> </td>
        	</tr>

			<tr> 
        		<td> Credit Card Information </td>		
        		<td> <%out.println(card_num); %> </td>
        	</tr>

        	<tr> 
        		<td> Process Time </td>		
        		<td> <%out.println(date); %> </td>
        	</tr>
        </table>

</div>
</html>
