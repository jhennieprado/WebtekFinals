/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Servlets.DbManipulators.TableConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
@WebServlet(name = "SortServiceByCat", urlPatterns = {"/SortServiceByCat"})
public class SortServiceByCat extends HttpServlet {

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
            String categ = request.getParameter("categ");
            String query = "SELECT * FROM services WHERE category = ?";
            String catQuery = "SELECT DISTINCT category FROM services";
            
            System.out.println(categ);
            TableConnect connect = new TableConnect();
            PreparedStatement statement = connect.getConnection().prepareStatement(query);
            PreparedStatement statement2 = connect.getConnection(). prepareStatement(catQuery);
            statement.setString(1,categ);
            System.out.println(statement);
            ResultSet result = statement.executeQuery();
            ResultSet cat1 = statement2.executeQuery();
            ArrayList<String> categories = new ArrayList<> ();
            while(cat1.next()){
                categories.add(cat1.getString(1));
            }
            request.setAttribute("results",result);
            request.setAttribute("bean","services");
            request.setAttribute("categories",categories);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("ConvertResultSetServlet");
            dispatcher.forward(request,response);
            
        }catch(ClassNotFoundException | SQLException exc){
            
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
