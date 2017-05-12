/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Servlets.DbManipulators.TableUpdate;
import Servlets.DbManipulators.TableConnect;
import Beans.ServiceProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Vash
 */
@WebServlet(name = "ApprovePServiceProvider", urlPatterns = {"/ApprovePServiceProvider"})
public class ApprovePServiceProvider extends HttpServlet {

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
        String spId = request.getParameter("pendingSp");
        HttpSession session = request.getSession(false);
        try{
           String userName = session.getAttribute("UserName").toString();
        }catch(NullPointerException exc){
           String redirect = response.encodeRedirectURL("SessionExpired.jsp");
           response.sendRedirect(redirect);
           return;
        }           

        //Turn into update instead of this
        try{
            TableConnect connection = new TableConnect();
            String query = "SELECT * FROM serviceproviders WHERE spid = " + spId;
            ResultSet pendingSp = connection.queryFromDatabase(query);
            ArrayList<ServiceProvider> list = new ArrayList<> ();
            while(pendingSp.next()){
                int spId2 = pendingSp.getInt(1);
                String first_name  = pendingSp.getString(2);
                String last_name = pendingSp.getString(3); 
                String email = pendingSp.getString(4);
                String contactNo = pendingSp.getString(5);
                String userName = pendingSp.getString(6);
                String passWord = pendingSp.getString(7);
                String status = "Y";
                int totalRating = pendingSp.getInt(9);
     

                ServiceProvider sp = new ServiceProvider(spId2,first_name,last_name,
                        email,contactNo,userName,passWord,status,totalRating);
                
               
                list.add(sp);
            }
            
            connection.closeConnection();
            
            TableUpdate update= new TableUpdate(); 
            
            list.forEach((sp) -> update.updateServiceProvider(sp));
            
            String url = response.encodeRedirectURL("PendingServiceProviderServlet");
            response.sendRedirect(url);
            
        }catch(IOException | ClassNotFoundException | SQLException exception){
            System.out.println("Something funky went wrong");
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
