/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.InsertServlets;

import Beans.Service;
import Servlets.DbManipulators.TableInsert;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Vash
 */
@WebServlet(name = "InsertServiceServlet", urlPatterns = {"/InsertServiceServlet"})
public class InsertServiceServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        
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
        String serviceName = request.getParameter("service_name");
        float serviceAmount = Float.parseFloat(request.getParameter("service_amount"));
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        
        Service service = new Service(serviceName, serviceAmount, 
                description,category);
        
        try {
            TableInsert insert = new TableInsert();
            String query = "INSERT INTO services(servicename, serviceamount"
                    + ", description, category) VALUES(?,?,?,?)";
            insert.insertIntoService(service, query);
            insert.closeConnection();
            String redirect = response.encodeRedirectURL("MainServlet");
            response.sendRedirect(redirect);
                    
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(InsertServiceServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "The movie is just too god mang";
    }// </editor-fold>

}
