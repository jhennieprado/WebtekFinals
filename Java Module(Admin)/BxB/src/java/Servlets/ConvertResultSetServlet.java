/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Beans.*;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
@WebServlet(name = "ConvertResultSetServlet", urlPatterns = {"/ConvertResultSetServlet"})
public class ConvertResultSetServlet extends HttpServlet {

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
       
        //You can turn this into even just one method man. Do not forget to do this.
        
        //You can even put this thing in a switch statement. I think that would
        //be a lot more readable to a certain point.
        
        //String bean = (String) request.getAttribute("bean");
        //Check if you can use string in a switch but im pretty sure that you can
        //UGHGH THIS IMPLEMENTATION SUCKS, do we even need this?
        System.out.println((String) request.getAttribute("bean"));
        if("spY".equals((String) request.getAttribute("bean"))){
            ResultSet validSp = (ResultSet) request.getAttribute("result");
            ArrayList<ServiceProvider> list = new ServiceProvider().toArrayList(validSp);         
            request.setAttribute("ValidSpList",list);
            System.out.println(list.size());
            RequestDispatcher dispatcher = request.getRequestDispatcher("DeleteSp.jsp");
            dispatcher.forward(request, response);
        }
        
        if("spN".equals((String) request.getAttribute("bean"))){
            ResultSet pendingSp = (ResultSet) request.getAttribute("result");
            ArrayList<ServiceProvider> list = new ServiceProvider().toArrayList(pendingSp);
            request.setAttribute("PendingSp",list); // I think you also can change the name of the attribute to be the same as the other.lets try that later
            System.out.println(list.size());
            RequestDispatcher dispatcher = request.getRequestDispatcher("ApproveSp.jsp");
            dispatcher.forward(request, response);
        }
        
        if("appointment".equals((String) request.getAttribute("bean"))){
            System.out.println("Dadaan ba siya dito sa appointment bean?");
            ResultSet appointments = (ResultSet) request.getAttribute("result");
            ArrayList<Appointment> list = new Appointment().toArrayList(appointments);
            request.setAttribute("Appointments",list);
            RequestDispatcher dispatcher = request.getRequestDispatcher("Appointment.jsp");
            dispatcher.forward(request, response);
        }
        
        if("clientN".equals((String) request.getAttribute("bean"))){
            ResultSet clients = (ResultSet) request.getAttribute("result");
            ArrayList<Client> list = new Client().toArrayList(clients);
            request.setAttribute("results",list);
            System.out.println(list.size());
            RequestDispatcher dispatcher = request.getRequestDispatcher("ApproveClient.jsp");
            dispatcher.forward(request, response);           
        }
        
        if("client".equals((String) request.getAttribute("bean"))){
            ResultSet clients = (ResultSet) request.getAttribute("result");
            ArrayList<Client> list = new Client().toArrayList(clients);
            request.setAttribute("clients",list);
            RequestDispatcher dispatcher = request.getRequestDispatcher("DeleteClient.jsp");
            dispatcher.forward(request,response);
        }
        
        
        if("services".equals ((String) request.getAttribute("bean"))){
            ResultSet services = (ResultSet) request.getAttribute("results");
            ArrayList<Service> list = new Service().toArrayList(services);
            request.setAttribute("results",list);
            RequestDispatcher dispatcher = request.getRequestDispatcher("DeleteService.jsp");
            dispatcher.forward(request,response);               
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
