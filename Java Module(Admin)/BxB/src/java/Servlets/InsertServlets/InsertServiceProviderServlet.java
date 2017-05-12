/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.InsertServlets;

import Beans.ServiceProvider;
import Servlets.DbManipulators.TableInsert;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "InsertServiceProviderServlet", urlPatterns = {"/InsertServiceProviderServlet"})
public class InsertServiceProviderServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String email = request.getParameter("email");
            String contactNum = request.getParameter("contact");
            int totalRating = Integer.parseInt(request.getParameter("rating"));
            String userName = request.getParameter("user_name");
            String password = request.getParameter("pass_word");
            final String status = "N";
            
            ServiceProvider actor = new ServiceProvider(firstName,lastName,email,contactNum
                    ,userName,password,status,totalRating,null);
            
            TableInsert connect = new TableInsert();
            
            String query = "INSERT INTO serviceproviders(first_name, last_name ,email,"
                    + " contactno ,userName, password, accepted, totalRating, profpic) VALUES(?,?,?,?,?,?,?,?,?)";
            
            connect.insertIntoSp(actor, query);
            connect.closeConnection();
            
            String url = response.encodeRedirectURL("index.jsp");
            response.sendRedirect(url);
            
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(InsertServiceProviderServlet.class.getName()).log(Level.SEVERE, null, ex);
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
    }// </editor-fold>

}
