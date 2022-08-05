package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SignDao {
	public String idCheck(Connection conn, String id) throws SQLException {
      String ckId = null;
      //
      System.out.println(id + "<--SignDao/id");
      
      /*
      SELECT t.id
      FROM (SELECT customer_id id FROM customer
            UNION
            SELECT employee_id id FROM employee
            UNION
            SELECT out_id id FROM out_id) t
      WHERE t.id = ?   
      --> null일때 사용가능한 아이디
      */
      
      String sql = "SELECT t.id FROM (SELECT customer_id id FROM customer UNION SELECT employee_id id FROM employee UNION SELECT out_id id FROM outid) t WHERE t.id = ?";
      PreparedStatement stmt = null;
      ResultSet rs = null;
      try {
    	  stmt=conn.prepareStatement(sql);
    	  stmt.setString(1,id);
    	  rs = stmt.executeQuery();
    	  if(rs.next()) {
    		  ckId=rs.getString("t.id");
    	  }
      }finally {
    	  if(rs!=null) {
    		  rs.close();
    	  }
    	  if(stmt!=null) {
    		  stmt.close();
    	  }
      }
      
      // if(rs != null) {
      // close....
      
      return ckId;
   }
}