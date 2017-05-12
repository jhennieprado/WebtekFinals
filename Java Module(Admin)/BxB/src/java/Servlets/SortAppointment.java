/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Servlets.DbManipulators.TableConnect;
import java.io.IOException;
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
@WebServlet(name = "SortAppointment", urlPatterns = {"/SortAppointment"})
public class SortAppointment extends HttpServlet {

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
        try{
            //Get the parameter 
            String sortBy = request.getParameter("sort");
            TableConnect connect = new TableConnect();
            int choice = Integer.parseInt(sortBy);
            ResultSet result = null;
            switch(choice){
                case 1:
                    final String query = "SELECT * FROM appointments WHERE status='rejected'";
                    result = connect.queryFromDatabase(query);                                        
                    break;
                case 2:
                    final String query1 = "SELECT * FROM appointments WHERE status='accepted'";
                    result = connect.queryFromDatabase(query1);
                    break;
                case 3:
                    final String query2 = "SELECT * FROM appointments WHERE status='request'";
                    result = connect.queryFromDatabase(query2);
                    break;
                case 4:
                    final String query3 = "SELECT * FROM appointments WHERE status='done'";
                    result = connect.queryFromDatabase(query3);
                    break;
                default:
                    //redirect to the error page.
                    break;
            }
            
            request.setAttribute("result",result);
            request.setAttribute("bean","appointment");
            RequestDispatcher dispatcher = request.getRequestDispatcher("ConvertResultSetServlet");
            dispatcher.forward(request,response);           
        }catch(ClassNotFoundException | NumberFormatException | SQLException exception){
            //Remember to forward this to the freaking error page
            //Make sure to pass as a request attribute a link to the previous page.
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
