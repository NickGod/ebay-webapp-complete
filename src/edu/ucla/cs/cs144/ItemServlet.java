package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.PrintWriter; 
import java.io.StringReader;
import java.lang.*;
import java.util.*;

import edu.ucla.cs.cs144.Item;
import edu.ucla.cs.cs144.Item.*;

//xml parsing packages
// import javax.xml.bind.JAXBContext;
// import javax.xml.bind.Marshaller;
import javax.xml.bind.*;


public class ItemServlet extends HttpServlet implements Servlet {
       
    public ItemServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	
    	PrintWriter out = response.getWriter();

    	try {
	        String itemId = request.getParameter("id");
	        String xml = AuctionSearchClient.getXMLDataForItemId(itemId);
	        

	        if(xml != "")
	        {
	        		        // out.println(xml);

		        StringReader sr = new StringReader(xml);
		        JAXBContext jaxb_Context = JAXBContext.newInstance(Item.class);
		        Unmarshaller unmarshaller = jaxb_Context.createUnmarshaller();
				Item result = (Item) unmarshaller.unmarshal(sr);

				// System.out.println("Inside the do get function...");
				// String xml2 = AuctionSearchClient.getXMLDataForItemId(itemId);

				//HTTP Session
				HttpSession session = request.getSession(true);
				session.setAttribute(itemId, result);

				request.setAttribute("xml", xml);
				// request.setAttribute("sorted_bids", bid);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/ItemDisplay.jsp").forward(request, response);
			}
			else
				out.println("No matching result!");

		}
		catch(Exception e)
		{
			out.println(e);
			e.printStackTrace(out);
		}

        // out.println(xml);
    }
}
