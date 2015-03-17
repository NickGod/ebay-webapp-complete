package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.ucla.cs.cs144.Item;
import edu.ucla.cs.cs144.Item.*;

public class BuyServlet extends HttpServlet implements Servlet {

	public BuyServlet () {}

	public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);

		//If session is new it means that the user came directly to the buy page through url. 
		//Close the session and go to error page
		if (session.isNew()) {
			session.invalidate();
			request.getRequestDispatcher("/invalid.jsp").forward(request, response);
			return;
		}

		//Get the item id
		String item_id = request.getParameter("id");
		Item buy_item = (Item) session.getAttribute(item_id);

		if (buy_item == null) {
			session.invalidate();
			request.getRequestDispatcher("/invalid.jsp").forward(request, response);
			return;
		}
		request.setAttribute("item_info", buy_item);		
		request.getRequestDispatcher("./buy.jsp").forward(request, response);		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doGet(request, response);
    }

}
