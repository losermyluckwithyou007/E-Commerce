 
package com.spring.DAO;
 
import com.spring.entities.Category;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
 

public class CategoryDAO {
          private SessionFactory factoy;
          
          public CategoryDAO(SessionFactory factory){
              this.factoy = factory;
          }
          // Save category to DB
          public int saveCategory(Category cat){
              
              Session session = this.factoy.openSession();
              Transaction tx = session.beginTransaction();
              
              int catId = (int) session.save(cat);
              
              tx.commit();
              session.close();
              return catId;
              
          }
          
          public List<Category> getCategories(){
              
              Session s = this.factoy.openSession();
              Query query = s.createQuery("from Category");
              List<Category> list = query.list();
              return list;
          }
          
          public Category getCategoryById(int cid){
              
              Category cat = null;
              
              try{
                  
                   Session session = this.factoy.openSession();
                   cat = session.get(Category.class, cid);
                   session.close();
                  
              } catch(Exception e){
                  e.printStackTrace();
              }
              
              return cat;
          }
}
