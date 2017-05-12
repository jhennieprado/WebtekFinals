/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.DeleteServlets;

import Servlets.DbManipulators.TableConnect;
import Servlets.DbManipulators.TableDelete;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
@WebServlet(name = "DeactivateClient", urlPatterns = {"/DeactivateClient"})
public class DeactivateClient extends HttpServlet {

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
            String [] checkedBoxes = request.getParameterValues("clients");
            System.out.println(checkedBoxes.length);
            TableConnect connection = new TableConnect();
            Connection connect = connection.getConnection();
            /**
             * String query = "UPDATE clients SET accepted = "DEACTIVATED" WHERE clientId = ?;
             * PreparedStatement statement = connection.prepareStatement(query);
             * statement.setInt(WhateverTheValieHereNeeds);
             * statement.executeQuery();
             * closeConnection();
             */
            for(String clientId : checkedBoxes){
                String query = "UPDATE clients SET accepted =  'D' WHERE clientno = ?";
                PreparedStatement statement = connect.prepareStatement(query);
                statement.setInt(1,Integer.parseInt(clientId));
                statement.executeUpdate();
            }
            
            connection.closeConnection();
            
            String url = response.encodeRedirectURL("ValidClients");
            response.sendRedirect(url);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DeactivateClient.class.getName()).log(Level.SEVERE, null, ex);
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
