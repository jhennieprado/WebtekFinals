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
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Vash, Adrian
 */
@WebServlet(name = "AnnualReport", urlPatterns = {"/AnnualReport"})
public class AnnualReport extends HttpServlet {

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
            int theYearToday = 2017;
            float totalRevenueForTheYear;
            String topServiceProvider;
            int numberOfAppointments;
            String topClient; 
            TableConnect connection = new TableConnect();
            Connection connect = connection.getConnection();

            String query = "SELECT * FROM appointments INNER JOIN "
                    + "serviceprovider_schedules ON appointments.sp_schedid = "
                    + "serviceprovider_schedules.schedid WHERE YEAR(serviceprovider_schedules.sched_date) = ?";
            PreparedStatement statement = connect.prepareStatement(query);
            statement.setInt(1,theYearToday);
            
            ResultSet set = statement.executeQuery();
            
            //get total revenue
            float totalRev = 0;
            
            while(set.next()){
                totalRev += set.getFloat(9) * 0.20;
            }
            
            request.setAttribute("totalRevTY", totalRev);
            
            //top appointment
             String query2 = "SELECT COUNT(*) FROM appointments "
                    + "INNER JOIN serviceprovider_schedules USING(spid) "
                    + "WHERE status = 'done' "
                    + "AND YEAR(serviceprovider_schedules.sched_date) = ?";
            ResultSet set1 = connection.queryFromDatabase(query2);
            
            set1.first();
            
            numberOfAppointments = set1.getInt(1);
            request.setAttribute("topAnnualserviceTY", numberOfAppointments);
            
            //top sp
            String query3 = "select spid, SUM(amount) FROM appointments INNER J"
                    + "OIN serviceproviders USING(spid) INNER JOIN serviceprovi"
                    + "der_schedules USING(spid) WHERE YEAR(serviceprovider_sc"
                    + "hedules.sched_date) = ? GROUP BY spid ORDER BY 2 DESC"
                    + " LIMIT 10";
            ResultSet set2 = connection.queryFromDatabase(query3); 
            String[] spidm = new String[10];
            float[] amountm = new float[10];
            int index=0;
            while(set2.next()){
                spidm[index] = set2.getString(1);
                amountm[index] = set2.getFloat(2);
                index++;
            }
            request.setAttribute("spidHiEarnTY", spidm);
            request.setAttribute("amountHiEarnTY", amountm);
            
            String query4 = "SELECT spid, avg(rating) FROM `appointments`"
                    + "INNER JOIN serviceprovider_schedules USING(spid) "
                    + "WHERE YEAR(serviceprovider_schedules.sched_date) "
                    + "= ? and status = 'done' GROUP BY spid";
            String query5 = "SELECT * FROM serviceproviders INNER JOIN servicep"
                    + "rovider_schedules USING(spid) WHERE YEAR(serviceprovide"
                    + "r_schedules.sched_date) = 5 ORDER BY totalrating ASC LIM"
                    + "IT 1";
            
            PreparedStatement statement1 = connect.prepareStatement(query4);
            statement.setInt(1,theYearToday);
            ResultSet set3 = statement1.executeQuery();
            ResultSet set4 = connection.queryFromDatabase(query5);
            set3.first();
            set4.first();
            
            
            String highestSp = set3.getString(2) + ", " + set3.getString(3);
            String lowestSp = set4.getString(2) + ", " + set3.getString(3);
            
            request.setAttribute("highestSpTY", highestSp);
            request.setAttribute("lowestSpTY", lowestSp);
            
            statement.close();
        }catch(Exception exception){
            
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
