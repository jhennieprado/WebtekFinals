/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.ReportStatistics;

import Servlets.DbManipulators.TableConnect;
import java.io.IOException;
import java.sql.Connection;
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
 * @author Vash, Adrian
 */
@WebServlet(name = "MonthlyReport", urlPatterns = {"/MonthlyReport"})
public class MonthlyReport extends HttpServlet {

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
            int theMonthToday = Integer.parseInt(request.getParameter("month"));
            int theYearToday = Integer.parseInt(request.getParameter("year"));
            float totalRevenueForTheMonth;
            String topServiceProvider;
            int numberOfAppointments;
            String topClient; 
            TableConnect connection = new TableConnect();
            Connection connect = connection.getConnection();
            String query = "SELECT * FROM appointments INNER JOIN "
                    + "serviceprovider_schedules ON appointments.sp_schedid = "
                    + "serviceprovider_schedules.schedid WHERE MONTH(servicepro"
                    + "vider_schedules.sched_date) = ? and YEAR(serviceprovid"
                    + "er_schedules.sched_date) = ?";
            PreparedStatement statement = connect.prepareStatement(query);
            statement.setInt(1,theMonthToday);
            statement.setInt(2,theYearToday);
            
            ResultSet set = statement.executeQuery();
            
            
            //get total revenue
            float totalRev = 0;
            
            while(set.next()){
                totalRev += set.getFloat(9) * 0.20;
            }
            
            request.setAttribute("totalRevForMonth", totalRev);
            
            
            //get number of appointments for the month;
            String query2 = "SELECT COUNT(*) FROM appointments "
                    + "INNER JOIN serviceprovider_schedules USING(spid) "
                    + "WHERE status = 'done' "
                    + "AND MONTH(serviceprovider_schedules.sched_date) = ? and YEAR(serviceprovid"
                    + "er_schedules.sched_date) = ?";
            
            PreparedStatement stet = connect.prepareStatement(query2);
            stet.setInt(1,theMonthToday);
            stet.setInt(2,theYearToday);
            
            ResultSet set1 = stet.executeQuery();
            
            set1.first();
            
            numberOfAppointments = set1.getInt(1);
            request.setAttribute("numOfAppointmentThisMonth", numberOfAppointments);
            
            
            //Get the top service provider for the month
            //sp of the month
            String query3 = "select spid,first_name,last_name, SUM(amount) FROM appointments INNER "
                    + "JOIN serviceproviders USING(spid) INNER JOIN serviceprov"
                    + "ider_schedules USING(spid) WHERE MONTH(serviceprovider_sc"
                    + "hedules.sched_date) = ? and YEAR(serviceprovid"
                    + "er_schedules.sched_date) = ? GROUP BY spid ORDER BY 4 DESC LIM"
                    + "IT 10 ";
            PreparedStatement stet2 = connect.prepareStatement(query3);
            stet2.setInt(1, theMonthToday);
            stet2.setInt(2, theYearToday);
            ResultSet set2 = stet2.executeQuery();
            ArrayList<String> spidm = new ArrayList<>();
            ArrayList<Float> amountm = new ArrayList<>();
            String spname;
            while(set2.next()){
                spname = set2.getString(2)+", "+set2.getString(3);
                spidm.add(spname);
                amountm.add(set2.getFloat(4));
            }
            request.setAttribute("spidHiEarn", spidm);
            request.setAttribute("amountHiEarn", amountm);
            
            
            //Highest Rated SP 
            String query4 = "SELECT spid,first_name,last_name, avg(rating) FROM `appointments`"
                    + "INNER JOIN serviceprovider_schedules USING(spid) "
                    +"INNER JOIN serviceproviders USING(spid)"
                    + "WHERE MONTH(serviceprovider_schedules.sched_date) "
                    + "= ? and YEAR(serviceprovid"
                    + "er_schedules.sched_date) = ? and status = 'done' GROUP BY spid";
            String query5 = "SELECT * FROM serviceproviders INNER JOIN servicep"
                    + "rovider_schedules USING(spid) WHERE MONTH(serviceprovide"
                    + "r_schedules.sched_date) = ? and YEAR(serviceprovider_schedules.sched_date) = ? ORDER BY totalrating ASC LIM"
                    + "IT 1";
            
            PreparedStatement statement1 = connect.prepareStatement(query4);
            statement1.setInt(1,theMonthToday);
            statement1.setInt(2,theYearToday);
            ResultSet set3 = statement1.executeQuery();
            
            PreparedStatement stet3 = connect.prepareStatement(query5);
            stet3.setInt(1,theMonthToday);
            stet3.setInt(2,theYearToday);
            ResultSet set4 = stet3.executeQuery();
            set3.first();
            set4.first();
            
            
            String highestSp = set3.getString(2) + ", " + set3.getString(3)+" : "+ set3.getInt(1);
            String lowestSp = set4.getString(2) + ", " + set3.getString(3)+" : "+ set3.getInt(1);
            
            
            request.setAttribute("highestSp", highestSp);
            request.setAttribute("lowestSp", lowestSp);
            
            statement.close();
            
            String strMonth = "";
            switch(theMonthToday){
                case 1:  strMonth = "January"; break;
                case 2:  strMonth = "February"; break;
                case 3:  strMonth = "March"; break;
                case 4:  strMonth = "April"; break;
                case 5:  strMonth = "May"; break;
                case 6:  strMonth = "June"; break;
                case 7:  strMonth = "July"; break;
                case 8:  strMonth = "August"; break;
                case 9:  strMonth = "September"; break;
                case 10:  strMonth = "October"; break;
                case 11:  strMonth = "November"; break;
                case 12:  strMonth = "December"; break;
                
                
            }
            request.setAttribute("month",strMonth);
            request.setAttribute("year",theYearToday);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("Report.jsp");
            dispatcher.forward(request,response);
            
        }catch(ClassNotFoundException | SQLException exception){
            exception.printStackTrace();
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
