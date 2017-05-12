/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Beans.Appointment;
import Beans.Client;
import Beans.ServiceProvider;
import Servlets.DbManipulators.TableConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Timestamp;
import java.sql.Date;
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
@WebServlet(name = "MainServlet", urlPatterns = {"/MainServlet"})
public class MainServlet extends HttpServlet {


    /**
     * Processes requests for both HTTP <code>GET</code> and/or <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * 
     */
    @SuppressWarnings("ConvertToTryWithResources")
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        TableConnect connect;
        System.out.println("dadaan ba dito?");
        request.setAttribute("DateToday", new java.util.Date().toString());
        
        //Oh yeah the repeated code is real. Please refactor!
        HttpSession session = request.getSession(false);
        try{
            String userName = session.getAttribute("UserName").toString();
        }catch(NullPointerException exc){
            String redirect = response.encodeRedirectURL("SessionExpired.jsp");
            response.sendRedirect(redirect);
            return;
        }
        
        try{
            //The naming conventions here are horrendous!
            //The way this servlet is structured too.
            //BE SURE TO KEEP IN MIND MODULARITY AND REUSE
            //Too "HARD CODED"
            connect = new TableConnect();
            String services = "SELECT COUNT(*) FROM services";
            String clients = "SELECT COUNT(*) FROM clients";
            String spQuery = "SELECT COUNT(*) FROM serviceproviders WHERE accepted = 'Y'";
            String spQuery2 = "SELECT COUNT(*) FROM serviceproviders WHERE accepted = 'N'";
            String clientQuery = "SELECT COUNT(*) FROM clients WHERE accepted = 'N'";
            String clientQuery2 = "SELECT COUNT(*) FROM clients WHERE accepted = 'Y'";
            String clientNum = "SELECT COUNT(*) FROM serviceproviders LIMIT 10";
            String appointmentsNum = "SELECT COUNT(*) FROM appointments";
            
            ResultSet service1 = connect.queryFromDatabase(services);
            ResultSet client = connect.queryFromDatabase(clients);
            ResultSet sp = connect.queryFromDatabase(spQuery);
            ResultSet sp2 = connect.queryFromDatabase(spQuery2);
            ResultSet cq = connect.queryFromDatabase(clientQuery);
            ResultSet cq2 = connect.queryFromDatabase(clientQuery2);
            ResultSet cq3 = connect.queryFromDatabase(clientNum);
            ResultSet app1 = connect.queryFromDatabase(appointmentsNum);
           
            String services2 = "SELECT * FROM services";
            String customerQuery2 = "SELECT * FROM clients ORDER BY accountcreated DESC LIMIT 10"; //Try to remember to fix this and order it by last name as well
            String serviceProviders2 = "SELECT * FROM serviceproviders";
            String appointmentQuery = "SELECT * FROM appointments ORDER BY daterequest DESC LIMIT 10";
            
            ResultSet allServices = connect.queryFromDatabase(services2);
            ResultSet allClients = connect.queryFromDatabase(customerQuery2);
            ResultSet allServiceProviders = connect.queryFromDatabase(serviceProviders2);
            ResultSet allAppointments = connect.queryFromDatabase(appointmentQuery);
            
            ArrayList<Client> list = new ArrayList<> ();
            ArrayList<Appointment> list2 = new ArrayList<> ();
            
            while(allClients.next()){
                //get rows
                int clientNo = allClients.getInt(1);
                String firstName = allClients.getString(2);
                String lastName = allClients.getString(3);
                //get into simple date format here
                Date birthdate = allClients.getDate(4);
                String email = allClients.getString(5);
                String userName = allClients.getString(6);
                String password = allClients.getString(7);
                String contactNo = allClients.getString(8);
                String address = allClients.getString(9);
                Timestamp time = allClients.getTimestamp(10);
                String stat = allClients.getString(11);
                
                Client clientent = new Client(clientNo,firstName,lastName,birthdate,email,userName,password,contactNo,address,time,stat);
                
                list.add(clientent);
                
            }
            
            while(allAppointments.next()){
                //get everything again
                int appNumber = allAppointments.getInt(1);
                int spSchedId = allAppointments.getInt(2);
                Timestamp stamp = allAppointments.getTimestamp(3);
                int clientNo = allAppointments.getInt(4);
                int serviceId = allAppointments.getInt(5);
                String status = allAppointments.getString(6);
                int rating = allAppointments.getInt(7);
                int spId = allAppointments.getInt(8);
                float amount = allAppointments.getFloat(9);
                Appointment appoinment = new Appointment(appNumber,spSchedId,stamp,clientNo,serviceId,status,rating,spId,amount);
                list2.add(appoinment);
            }
            
        

            service1.first();
            client.first();
                
            sp.first();
            sp2.first();
            
            cq.first();
            cq2.first();
            cq3.first();
            
            app1.first();
            
            int numOfServices = service1.getInt(1);
            int numOfClients = client.getInt(1);
          
            int numOfValSp = sp.getInt(1);
            int numOfInvalSp = sp2.getInt(1);
            
            int numOfValC = cq.getInt(1);
            int numOfPendC = cq2.getInt(1);
            int numOfC = cq3.getInt(1);
            int numOfApps = app1.getInt(1);
            
            request.setAttribute("numOfServices", numOfServices);
            request.setAttribute("numOfCustomers",numOfClients);
            request.setAttribute("AllServices", allServices);
            request.setAttribute("AllClients", list);
            request.setAttribute("AllServiceProviders",allServiceProviders);
            request.setAttribute("numOfValSp", numOfValSp);
            request.setAttribute("numOfInvalSp",numOfInvalSp);
            request.setAttribute("numOfValC",numOfValC);
            request.setAttribute("numOfPendC",numOfPendC);
            request.setAttribute("numOfC",numOfC);
            request.setAttribute("numOfApps",numOfApps);
            request.setAttribute("latestAppointments",list2);
            service1.close();
            client.close();
            connect.closeConnection();
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request,response);
        }catch(ClassNotFoundException | SQLException exception){
            exception.printStackTrace();           
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
    }
}
