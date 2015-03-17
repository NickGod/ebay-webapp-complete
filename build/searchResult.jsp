
<%@ page import="edu.ucla.cs.cs144.*" %>
<%@ page import="edu.ucla.cs.cs144.SearchResult" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>

<html>
<head>
	<title> Search Results </title>
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
<body>
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
		</form> </li>

        <li> 
            <form action="/eBay/item" method="GET" class="navbar-form navbar-right" role="search">
            <div class="form-group">
            <input type="text" name="id">
            </div>
            <button type="submit" class="btn btn-default">Search Corresponding ID!</button>
        </li>
		</ul>

	</div>
</nav>


<div class="container">

    <div class="panel panel-primary">
              <!-- Default panel contents -->
            <div class="panel-heading">Search Results</div>
            
    <table class="table">
    <tr>
    <td> Item ID </td>
    <td> Item Name </td>
    </tr>
    <% 
    		SearchResult[] results = (SearchResult[])request.getAttribute("results");
    		for(int i = 0; i < results.length; i++)
        	{ %>

            

        	    <tr>
        		<td> <a href="item?id=<%out.println(results[i].getItemId()); %>" ><%out.println(results[i].getItemId()); %> </a> </td>
        		<td> <%out.println(results[i].getName()); %> </td>
                </tr>
            
            <%
        	} 
        	%> 
    </table>
    </div>

  	<footer> 
        <nav>
          <ul class="pager">
          	 <%   
          	 	String q = request.getParameter("q");
			    String skipped = request.getParameter("numResultsToSkip");
			    String showed = request.getParameter("numResultsToReturn");
			    Integer skippedNum = Integer.parseInt(skipped);
			    Integer showedNum = Integer.parseInt(showed);
			    Integer next = skippedNum + showedNum;
			    Integer prev = skippedNum - showedNum;
			    if (skippedNum>0) {
			    	out.println("<li class=\"previous\"><a href=\"/eBay/search?q=" + q + "&numResultsToSkip=" + prev + "&numResultsToReturn=" + showedNum + "\">Previous</a></li>");
				}
			    if (results.length == 10)
			    {
			        out.println("<li class=\"next\"><a href=\"/eBay/search?q=" + q + "&numResultsToSkip=" + next + "&numResultsToReturn=" + showedNum + "\">Next</a></li>");
			   	}	
   			%>

          </ul>
        </nav>
    </footer>

</div> 
</body>
</html>