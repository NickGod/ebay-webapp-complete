<%@ page import="edu.ucla.cs.cs144.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="edu.ucla.cs.cs144.Item" %>
<%@ page import="edu.ucla.cs.cs144.Item.*" %>

<html>
<html>
<head>
    <title> Payment Page </title>
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
   <p> <% 
    	Item result = (Item) request.getAttribute("item_info"); 
    	%>
    <div class="table-responsive panel panel-primary">
    <div class="panel-heading">Item Payment Information</div>
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
        </table>

</div>
	 <form action="https://<%=request.getServerName()%>:8443<%=request.getContextPath()%>/confirm" method="post">
   		Credit Card: <input type="text" name="cc_info">
    	<input type="hidden" name="id" value="<%=result.ItemID%>">
    	<button type="submit" class="btn btn-danger btn-lg">Pay</button>
	</form>


</html>
