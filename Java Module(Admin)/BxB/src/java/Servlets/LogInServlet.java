/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
/**
/**
 *
 * @author Vash
 */
@WebServlet(name = "LogInServlet", urlPatterns = {"/LogInServlet"})
public class LogInServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String userName = request.getParameter("user_name");
        String passWord = request.getParameter("pass_word");
        System.out.println(userName + "\n" + passWord);

        try {
            LogInCheck logInCheck = new LogInCheck(userName, passWord);
            if(logInCheck.isCredentialsValid()){
                
                /** If you want to still do the ajax thingy
                String red = response.encodeRedirectURL("LogInSuccess.jsp");
                String json = "{ 'content':" + '"' + red + '"' + " , " + "'type':'url'}";
                json = json.replace("'".charAt(0), '"' );
                response.getWriter().write(json);
                else* */
                
                request.setAttribute("UserName", userName);
                request.setAttribute("DateToday", new Date().toString());
                logInCheck.closeConnection();
                RequestDispatcher dispatcher = request.getRequestDispatcher("MainServlet");
                dispatcher.forward(request, response);
            }else{
                response.getWriter().write("Failed to write to database");
                String url = response.encodeRedirectURL("LogInFail.jsp");
                logInCheck.closeConnection();
                response.sendRedirect(url);       
                return;
            }
            logInCheck.closeConnection();
        } catch (Exception ex) {
            Logger.getLogger(LogInServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.getWriter().write("SOMETHING WENT WRONG!");
        }


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
