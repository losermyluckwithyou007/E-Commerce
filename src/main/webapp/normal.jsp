<%@page import="com.spring.entities.User"%>
<%
     
       User user = (User) session.getAttribute("current-user");

           if (user == null) {

               session.setAttribute("message", "You are not logged in !! Login first");
               response.sendRedirect("login.jsp");
               return;
           } else {
               if (user.getUserType().equals("admin")) {
                   session.setAttribute("message", "You are admin !! You can not access this page!!");
                   response.sendRedirect("login.jsp");
                   return;
               }
           }




%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="component/common_css_js.jsp" %>
    </head>
    <body>
           <%@include file="component/navbar.jsp" %>
        <h1>This is normal user panel !</h1>
    </body>
</html>
