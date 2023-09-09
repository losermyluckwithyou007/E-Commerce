<%-- 
    Document   : index
    Created on : 26-Jul-2023, 1:12:45 PM
    Author     : loser
--%>

<%@page import="com.spring.helper.Helper"%>
<%@page import="com.spring.entities.Category"%>
<%@page import="com.spring.DAO.CategoryDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.spring.entities.Product"%>
<%@page import="com.spring.DAO.ProductDAO"%>
<%@page import="com.spring.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MyCart - Home</title>

        <%@include file="component/common_css_js.jsp" %>

    </head>
    <body>
          <%@include file="component/navbar.jsp" %>
          
          <div class="container-fluid">

          <div class="row mt-3 mx-2">
                   <%
                       String cat = request.getParameter("category");
                       
                       ProductDAO dao = new ProductDAO(FactoryProvider.getFactory());
                       
                       List<Product> list = null;
                       if(cat==null || cat.trim().equals("all")){
                             list  = dao.getAllProducts();
                            
                       }else {
                             int cid = Integer.parseInt(cat.trim());
                             list = dao.getAllProductsById(cid);
                             
                       }
                     
                       CategoryDAO cdao = new CategoryDAO(FactoryProvider.getFactory());
                       List<Category> clist = cdao.getCategories();
                   %>              
                   
              <!-- show categories -->
              <div class="col-md-2">
                  
                   
                  <div class="list-group mt-4">
                      <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                          All Products
                      </a>
                       
                  
                  <%
                      for(Category c: clist) {
                   %>   
                   <a href="index.jsp?category=<%= c.getCategoryId() %>" class="list-group-item list-group-item-action "> <%= c.getCategoryTitle() %> </a>   
                   <%
                    }
                  %>
                   </div>

                  
              </div>
              
              <!-- show products -->
              <div class="col-md-10">
                   
                  
                   <!--Row-->
                   <div class="row mt-4">
                       
                       <div class="col-md-12">
                           
                           <div class="card-columns">
                               
                               <!--Traversing products-->
                               
                               <%
                                   
                                      for(Product p: list) {

                               %>
                               
                               <div class="card">
                                   <div class="container text-center">
                                      <img class="card-img-top m-2" src="image/products/<%= p.getpPhoto() %>" style="max-height: 200px; max-width: 100% ; width: auto"  >
                                    
                                   </div>
                                   
                                   <div class="card-body">
                                       
                                       <h5 class="card-title"><%= p.getpName() %></h5>
                                       
                                       <p class="card-text"><%= Helper.get10Word(p.getpDesc()) %></p>

                                   </div>
                                       <div class="card-footer">
                                           
                                           <button class="btn custom-bg text-white">Add To Cart</button>
                                           <button class="btn  btn-outline-primary">&#8377; <%= p.getpPrice() %></button>
                                           
                                       </div>    
                               </div>
                               
                               
                               <% }
                                   
                                     if(list.size()==0){
                                       out.println("<h1>No item in this category...</h1>");
                                       }

                               %>
                               
                           </div>
                           
                           
                       </div>
                   </div>
                  
              </div>

          </div>
          </div>                     

    </body>
</html>
