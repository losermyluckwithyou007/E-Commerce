 
package com.spring.servlets;

import com.spring.DAO.CategoryDAO;
import com.spring.DAO.ProductDAO;
import com.spring.entities.Category;
import com.spring.entities.Product;
import com.spring.helper.FactoryProvider;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
 
@MultipartConfig
public class ProductOperationServlet extends HttpServlet {
 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try ( PrintWriter out = response.getWriter()) {

            String op = request.getParameter("operation");

            if (op.trim().equals("addcategory")) {

                // Fetching category data
                String title = request.getParameter("catTitle");
                String desc = request.getParameter("catDescription");

                Category category = new Category();
                category.setCategoryTitle(title);
                category.setCategoryDescription(desc);

                //category save to database
                CategoryDAO categoryDAO = new CategoryDAO(FactoryProvider.getFactory());

                int catId = categoryDAO.saveCategory(category);

                HttpSession httpsession = request.getSession();
                httpsession.setAttribute("message", "Category added successfully : " + catId);
                response.sendRedirect("admin.jsp");
                return;
                
            }else if(op.trim().equals("addproduct")){
                
                // Fetching product data
                String pName = request.getParameter("pName");
                String pDescription = request.getParameter("pDescription");
                int pPrice = Integer.parseInt(request.getParameter("pPrice"));
                int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
                int pQuantity =Integer.parseInt(request.getParameter("pQuantity"));
                int catId = Integer.parseInt(request.getParameter("catId"));
                
                Part part = request.getPart("pPhoto");
                
                Product product = new Product();
                product.setpName(pName);
                product.setpDesc(pDescription);
                product.setpPrice(pPrice);
                product.setpDiscount(pDiscount);
                product.setpQuantity(pQuantity);
                product.setpPhoto(part.getSubmittedFileName());
                
                //get Categgory by ID
                CategoryDAO cdao = new CategoryDAO(FactoryProvider.getFactory());
                Category category = cdao.getCategoryById(catId);
                product.setCategory(category);

                //product saved..
                ProductDAO pdao = new ProductDAO(FactoryProvider.getFactory());
                pdao.saveProduct(product);

                //photo upload
                //find out the path to upload photo
                String path = request.getRealPath("image")+ File.separator + "products" + File.separator + part.getSubmittedFileName();
                System.out.println(path);
                
                //Uplaoding Code
                
             try{
                    FileOutputStream fos = new FileOutputStream(path);

                    InputStream is = part.getInputStream();

                    // Reading data 
                    byte[] data = new byte[is.available()];
                    is.read(data);

                    // Writing the Data
                    fos.write(data);
                    fos.close();
                    
                   } catch(Exception e){
                     e.printStackTrace();
                }
                
               

                HttpSession httpsession = request.getSession();
                httpsession.setAttribute("message", "Product added successfully : ");
                response.sendRedirect("admin.jsp");
                return;
                
            }
            
            
            
            
            
         
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
