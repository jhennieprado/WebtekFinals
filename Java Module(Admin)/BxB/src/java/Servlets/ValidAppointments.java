/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Servlets.DbManipulators.TableConnect;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Vash
 */
@WebServlet(name = "ValidAppointments", urlPatterns = {"/ValidAppointments"})
public class ValidAppointments extends HttpServlet {

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
        HttpSession session = request.getSession(false);
        try{
            String userName = session.getAttribute("UserName").toString();
        }catch(NullPointerException exc){
            String redirect = response.encodeRedirectURL("SessionExpired.jsp");
            response.sendRedirect(redirect);
            return;
        }
        try {
            System.out.println("Will this go though here" + "\n");
            response.setContentType("text/html;charset=UTF-8");
            TableConnect connection = new TableConnect();
            String query = "SELECT * FROM appointments";
            ResultSet results = connection.queryFromDatabase(query);
            request.setAttribute("result", results);
            request.setAttribute("bean","appointment");
            RequestDispatcher dispatcher = request.getRequestDispatcher("ConvertResultSetServlet");
            dispatcher.forward(request,response);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Will this go though here");
            Logger.getLogger(ValidAppointments.class.getName()).log(Level.SEVERE, null, ex);
            ex.printStackTrace();
        }
        
        
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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
