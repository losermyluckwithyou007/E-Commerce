<%@page import="com.spring.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.spring.DAO.CategoryDAO"%>
<%@page import="com.spring.helper.FactoryProvider"%>
<%@page import="com.spring.entities.User"%>
<%
     
         User user = (User) session.getAttribute("current-user");

         if (user == null) {

             session.setAttribute("message", "You are not logged in !! Login first");
             response.sendRedirect("login.jsp");
             return;
         } else {
             if (user.getUserType().equals("normal")) {
                 session.setAttribute("message", "You are not admin !! You can not access this page!!");
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
        <title>Admin Panel</title>
        <%@include file="component/common_css_js.jsp" %>
        
    </head>
    <body>
        <%@include file="component/navbar.jsp" %>
         
        <div class="container admin">
            
            <div class="container-fluid mt-3">
                <%@include file="component/message.jsp" %>
            </div>
            
            <div class="row mt-5">
                
                <!-- first column -->
                <div class="col-md-4 ">
                    
                    <div class="card text-center">
                        
                        <div class="card-body">
                            
                            <div class="container">
                                
                                <img style="max-width: 150px;" class="img-fluid" src="image/team.png" alt="user_icon">
                                
                            </div>
                                
                            
                            <h1>45158</h1>
                            <h1  class="text-uppercase text-muted">Users</h1>
                            
                        </div>
                    </div>
                    
                </div>
                
                <!-- second column -->
                <div class="col-md-4">
                    
                     <div class="card text-center">
                        
                        <div class="card-body">
                            
                            
                            <div class="container">
                                
                                <img style="max-width: 150px;" class="img-fluid" src="image/list.png" alt="categories_icon">
                                
                            </div>
                            
                            <h1>42846</h1>
                            <h1 class="text-uppercase text-muted">Categories</h1>
                            
                        </div>
                    </div>
                    
                </div>
                
                <!-- third column -->
                <div class="col-md-4">
                    
                     <div class="card text-center">
                        
                        <div class="card-body">
                            
                            <div class="container">
                                
                                <img  style="max-width: 150px;" class="img-fluid" src="image/delivery-box.png" alt="product_icon">
                                
                            </div>
                            
                            <h1>42588</h1>
                            <h1 class="text-uppercase text-muted">Product</h1>
                            
                        </div>
                    </div>
                    
                </div>
                    
            </div>
            
            <!-- Second Row -->
            <div class="row mt-5">
                
                <!-- Second Row: First Column -->
                <div class="col-md-6">
                    
                    <div class="card" data-toggle="modal" data-target="#add-category-modal" >
                        
                        <div class="card-body text-center">
                            
                            <div class="container">
                                
                                <img  style="max-width: 150px;" class="img-fluid" src="image/maths.png" alt="product_icon">
                                
                            </div>
                            
                            <p class="mt-2">Click her to add new categories</p>
                            <h1 class="text-uppercase text-muted">Add Categories</h1>
                            
                        </div>
                    </div>
                    
                </div>
                
                <!-- Second Row: Second Column -->
                <div class="col-md-6">
                    
                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        
                        <div class="card-body text-center">
                            
                            <div class="container">
                                
                                <img  style="max-width: 150px;" class="img-fluid" src="image/plus.png" alt="product_icon">
                                
                            </div>
                            
                            <p class="mt-2">Click her to add new Product</p>
                            <h1 class="text-uppercase text-muted">Add Product</h1>
                            
                        </div>
                    </div>
                    
                </div>
                
                           
            </div>
            
        </div>
         
        <!-- START Add category model -->
         

          <!-- Modal -->
          <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog modal-lg" role="document">
                  <div class="modal-content">
                      <div class="modal-header custom-bg text-white">
                          <h5 class="modal-title" id="exampleModalLabel">Fill Category Details</h5>
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                          </button>
                      </div>
                      <div class="modal-body">
                           
                          <form action="ProductOperationServlet" method="post">
                              
                              <input type="hidden" name="operation" value="addcategory">
                              
                             <div class="form-group">
                                       <input type="text" class="form-control" name="catTitle" placeholder="Enter Category Title" required />
                             </div>
                             
                             <div class="form-group">
                                       <textarea  style="height: 300px;" class="form-control" placeholder="Enter Category Description" name="catDescription" required ></textarea>
                             </div>
                              
                              <div class="container text-center">
                                  <button class="btn btn-outline-success">Add Category</button>
                                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                              </div>
                              
                          </form>
                          
                      </div>
                       
                  </div>
              </div>
          </div>      
        <!-- End Add category model -->
        
        
        
        <!--Start Add product modal-->
          <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog modal-lg" role="document">
                  <div class="modal-content">
                      <div class="modal-header custom-bg text-white">
                          <h5 class="modal-title" id="exampleModalLabel">Product Details</h5>
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                          </button>
                      </div>
                      <div class="modal-body">
                          
                          <form action="ProductOperationServlet" method="post" enctype="multipart/form-data" >
                              
                              <input type="hidden" name="operation" value="addproduct">
                              
                             <div class="form-group">
                                       <input type="text" class="form-control" name="pName" placeholder="Enter Product Name" required />
                             </div>                          
                             <div class="form-group">
                                       <textarea  style="height: 300px;" class="form-control" placeholder="Enter Product Description" name="pDescription" required ></textarea>
                             </div>                             

                              <div class="form-group">
                                       <input type="number" class="form-control" name="pPrice" placeholder="Price" required />
                             </div>
                              <div class="form-group">
                                       <input type="number" class="form-control" name="pDiscount" placeholder="Discount"/>
                             </div>
                              <div class="form-group">
                                       <input type="number" class="form-control" name="pQuantity" placeholder="Quantity" required />
                             </div>
                               
                              <%
                                  
                                      CategoryDAO cdao = new CategoryDAO(FactoryProvider.getFactory());
                                      List<Category> list = cdao.getCategories();

                              %>
                              <div class="dropdown form-group">
                                  <select name="catId" class="form-control" id="">
                                      
                                      <%
                                          for(Category c: list){
                                      %>
                                      <option value="<%= c.getCategoryId() %>" > <%= c.getCategoryTitle() %> </option>
                                       <% } %>
                                  </select>
                              </div>
                              
                              <div class="form-group">
                                  <label for=pPhoto"">Select Picture of Product</label>
                                  <br>
                                  <input type="file"  id="pPhoto" name="pPhoto"  required />
                              </div>

                              <div class="container text-center">
                                  <button class="btn btn-outline-success">Add Product</button>
                                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                              </div>

                          </form>

                      </div>

                  </div>
              </div>
          </div>
        <!--End Product modal-->
        
    </body>
</html>
