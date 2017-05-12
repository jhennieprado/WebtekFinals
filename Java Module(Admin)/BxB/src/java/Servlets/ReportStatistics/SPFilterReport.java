/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.ReportStatistics;

import Servlets.DbManipulators.TableConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
 * @author Vash, Adrian
 */
@WebServlet(name = "SPFilterReport", urlPatterns = {"/SPFilterReport"})
public class SPFilterReport extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            TableConnect connection = new TableConnect();
            Connection connect = connection.getConnection();
            int spid = Integer.parseInt(request.getParameter("select1"));
            String query ="SELECT spid, servicename, count(servicename), CONCAT(first_name,' ',last_name) FROM ap"
                    + "pointments inner join services using(serviceid)inner JOI"
                    + "N `serviceproviders` using(spid) INNER JOIN sp_skills us"
                    + "ing(spid) where appointments.spid = ? group by services."
                    + "serviceid";
            
             PreparedStatement statement1 = connect.prepareStatement(query);
             statement1.setInt(1,spid);
             ResultSet res = statement1.executeQuery();
             
             res.first();
             String spName = res.getString(4);
             String srName = res.getString(2);
             int srF = res.getInt(3);
             
             request.setAttribute("frequentServ",srName);
             request.setAttribute("frequency",srF);
             request.setAttribute("spname",spName);
             
             RequestDispatcher dispats = request.getRequestDispatcher("SPReport.jsp");
            dispats.forward(request,response);
            
        }catch (Exception ex) {
            Logger.getLogger(SPFilterReport.class.getName()).log(Level.SEVERE, null, ex);
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
