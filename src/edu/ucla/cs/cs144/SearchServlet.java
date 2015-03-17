package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.io.PrintWriter; 
import java.lang.*;

public class SearchServlet extends HttpServlet implements Servlet {
       
    public SearchServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // response.setContentType("text/html");
     //    PrintWriter out = response.getWriter();
     //    out.println("<html>");
     //    out.println("<head><title>Servlet Example</title></head>");
     //    out.println("<body>Hello from a Java Servlet</body>");
     //    out.println("</html>");
     //    out.close();

        PrintWriter out = response.getWriter();
        String query = request.getParameter("q");

        String skip = request.getParameter("numResultsToSkip");
        String ret = request.getParameter("numResultsToReturn");

        if (skip == null || ret == null || query == null)
            out.println("Invalid input");
        else {
            int numResultsToSkip = Integer.parseInt(request.getParameter("numResultsToSkip"));
            int numResultsToReturn = Integer.parseInt(request.getParameter("numResultsToReturn"));

            response.setContentType("text/html");
            //do we need to create a search client??

            SearchResult[] results = AuctionSearchClient.basicSearch(query, numResultsToSkip, numResultsToReturn);

            out.println(results.length);

            //check if we have got the correct results back
            // for(int i = 0; i < 2; i++)
            // {
            //     out.println(results[i].getName());
            // }
            //set request and send them to jsp

            request.setAttribute("results", results);

            request.setAttribute("q", query);
            request.setAttribute("numResultsToSkip", numResultsToSkip);
            request.setAttribute("numResultsToReturn", numResultsToReturn);

            request.getRequestDispatcher("/searchResult.jsp").forward(request, response);
        }
    }
}
