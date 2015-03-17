package edu.ucla.cs.cs144;

import java.util.Date;
import java.text.Format;
import java.text.SimpleDateFormat;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.ucla.cs.cs144.Item;
import edu.ucla.cs.cs144.Item.*;

public class ConfirmServlet extends HttpServlet implements Servlet {

	public ConfirmServlet () {}

	public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);

		//If session is new it means that the user came directly to the buy page through url. 
		//Close the session and go to error page
		if (!request.isSecure() || session.isNew()) {
			session.invalidate();
			request.getRequestDispatcher("/invalid.jsp").forward(request, response);
			return;
		}

		//Get the item id and credit card info
		String card = request.getParameter("cc_info");
		if (card == "") {
			request.setAttribute("Error_msg", "You did not enter your credit card information.");
			request.getRequestDispatcher("/invalid.jsp").forward(request, response);
			return;
		}

		String item_id = request.getParameter("id");
		Item buy_item = (Item) session.getAttribute(item_id);

		//Remove session attribute 
		session.removeAttribute(item_id);

		if (buy_item == null) {
			session.invalidate();
			request.getRequestDispatcher("/invalid.jsp").forward(request, response);
			return;
		}

		//Get date
		Date date = new Date();
		Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date_str = formatter.format(date);

		//set attributes
		request.setAttribute("item_info", buy_item);
		request.setAttribute("card_info", card);
		request.setAttribute("date", date_str);
		request.getRequestDispatcher("./confirm.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doGet(request, response);
    }
}