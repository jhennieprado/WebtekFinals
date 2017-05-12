/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.DeleteServlets;

import Servlets.DbManipulators.TableDelete;
import Servlets.DbManipulators.TableConnect;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
@WebServlet(name = "DeactivateServiceProvider", urlPatterns = {"/DeactivateServiceProvider"})
public class DeactivateServiceProvider extends HttpServlet {

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
            String [] idOfSp = request.getParameterValues("sp");
            TableConnect connect = new TableConnect();
            Connection connection = connect.getConnection();
            for(String id : idOfSp){
                //Try to remember if prepared statemenet actually changes the string of the query
                String query = "UPDATE serviceproviders SET accepted = 'D' WHERE spId = ?";
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setInt(1,Integer.parseInt(id));
                statement.executeUpdate();               
            }
            String url = response.encodeRedirectURL("ValidServiceProviderServlet");
            response.sendRedirect(url);        
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DeactivateServiceProvider.class.getName()).log(Level.SEVERE, null, ex);
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
