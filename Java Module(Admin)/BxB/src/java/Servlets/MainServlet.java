/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Vash
 */
@WebServlet(name = "MainServlet", urlPatterns = {"/MainServlet"})
public class MainServlet extends HttpServlet {


    /**
     * Processes requests for both HTTP <code>GET</code> and/or <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * 
     */
    @SuppressWarnings("ConvertToTryWithResources")
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        TableConnect connect;
        System.out.println("dadaan ba dito?");
        System.out.println((String) request.getAttribute("userName"));
        try{
            connect = new TableConnect();
            String actorQuery = "SELECT COUNT(*) FROM actor";
            String customerQuery = "SELECT COUNT(*) FROM customer";
            String filmQuery = "SELECT COUNT(*) FROM film";
            String spQuery = "SELECT COUNT(*) FROM serviceprovider WHERE accepted = 'Y'";
            String spQuery2 = "SELECT COUNT(*) FROM serviceprovider WHERE accepted = 'N'";
            ResultSet actor = connect.queryFromDatabase(actorQuery);
            ResultSet customer = connect.queryFromDatabase(customerQuery);
            ResultSet film = connect.queryFromDatabase(filmQuery);
            ResultSet sp = connect.queryFromDatabase(spQuery);
            ResultSet sp2 = connect.queryFromDatabase(spQuery2);
            
            String actorQuery2 = "SELECT * FROM actor";
            String customerQuery2 = "SELECT * FROM customer";
            String filmQuery2 = "SELECT * FROM film";
            ResultSet allActors = connect.queryFromDatabase(actorQuery2);
            ResultSet allCustomer = connect.queryFromDatabase(customerQuery2);
            ResultSet allFilms = connect.queryFromDatabase(filmQuery2);
            
            
            

            actor.first();
            customer.first();
            film.first();
            sp.first();
            sp2.first();
            int numOfActors = actor.getInt(1);
            int numOfCustomers = customer.getInt(1);
            int numOfFilms = film.getInt(1);
            int numOfValSp = sp.getInt(1);
            int numOfInvalSp = sp2.getInt(1);
            request.setAttribute("numOfActors", numOfActors);
            request.setAttribute("numOfCustomers",numOfCustomers);
            request.setAttribute("AllActors", allActors);
            request.setAttribute("AllCustomer", allCustomer);
            request.setAttribute("numOfFilms", numOfFilms );
            request.setAttribute("AllFilms", allFilms);
            request.setAttribute("numOfValSp", numOfValSp);
            request.setAttribute("numOfInvalSp",numOfInvalSp);
            actor.close();
            customer.close();
            connect.closeConnection();
            RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request,response);
        }catch(ClassNotFoundException | SQLException exception){
            exception.printStackTrace();
            
        }
       
    }


    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
