/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.InsertServlets;

import Beans.Client;
import Servlets.DbManipulators.TableInsert;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author Vash
 */
@WebServlet(name = "InsertClientServlet", urlPatterns = {"/InsertClientServlet"})
public class InsertClientServlet extends HttpServlet {

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
            String formDate = request.getParameter("birthdate");
            SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date date = form.parse(formDate);
            Date sqlDate = new Date(date.getTime());           
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            
            Timestamp accountCreated = new Timestamp(new java.util.Date().getTime());
            String email = request.getParameter("email") ;
            String userName = request.getParameter("username");
            String passWord = request.getParameter("password");
            String contactNumber = request.getParameter("contactNo");
            String address = request.getParameter("address");
            final String status = "N";
           
            Client client = new Client(firstName,lastName,sqlDate,email,userName,
                    passWord,contactNumber,address,accountCreated,status);
            
            TableInsert insert = new TableInsert();
            
            String query = "INSERT into clients(first_name,last_name,birthdate,"
                    + "email,username,password,contactno,address,accountcreated,"
                    + "accepted,profpic) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
            
            insert.insertIntoClient(client, query);
            insert.closeConnection();
            
            String url = response.encodeRedirectURL("index.jsp");
            response.sendRedirect(url);
            
        } catch (ParseException | ClassNotFoundException | SQLException ex) {
            Logger.getLogger(InsertClientServlet.class.getName()).log(Level.SEVERE, null, ex);
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
