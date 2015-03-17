package edu.ucla.cs.cs144;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.PrintWriter;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProxyServlet extends HttpServlet implements Servlet {
       
    public ProxyServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here// your codes here
        String query = request.getParameter("q");
        query = URLEncoder.encode(query, "UTF-8")
                         .replaceAll("\\+", "%20")
                         .replaceAll("\\%21", "!")
                         .replaceAll("\\%27", "'")
                         .replaceAll("\\%28", "(")
                         .replaceAll("\\%29", ")")
                         .replaceAll("\\%7E", "~");
        //query = "tes";
        String full_url = "http://google.com/complete/search?output=toolbar&q="+query;

        PrintWriter pw = response.getWriter();

        //open connection and set up content type
        URL suggestURL = new URL(full_url);
        HttpURLConnection connect = (HttpURLConnection) suggestURL.openConnection();
        connect.setRequestMethod("GET");
        response.setContentType("text/xml");

        BufferedReader bufread = new BufferedReader(new InputStreamReader(connect.getInputStream()));
		String str = bufread.readLine();

		//write out
		while (str != null) {
			pw.println(str);
			str = bufread.readLine();
		}

		//disconnect
		connect.disconnect();
    }
}
