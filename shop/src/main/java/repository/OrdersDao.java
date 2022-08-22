package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Orders;

public class OrdersDao {
	//주문 추가
	public int insertCustomerOrders(Connection conn, Orders orders) throws SQLException {
		//
		System.out.println(orders + " <--orders/ordersDao");
		int row = 0;
		String sql="INSERT INTO orders(goods_no, customer_id, order_quantity, order_price, order_addr, order_detail_addr, order_state, update_date, create_date) VALUES(?,?,?,?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = null;
		
		try {
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, orders.getGoodsNo());
			stmt.setString(2, orders.getCustomerId());
			stmt.setInt(3, orders.getOrderQuantity());
			stmt.setInt(4, orders.getOrderPrice());
			stmt.setString(5,orders.getOrderAddr());
			stmt.setString(6,orders.getOrderDetailAddr());
			stmt.setString(7, orders.getOrderState());
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// 전체 주문 목록 
	   public List<Map<String, Object>> selectOrdersList(Connection conn, int rowPerPage, int beginRow)
	         throws SQLException {
	      List<Map<String, Object>> list = null;
	      Map<String, Object> map = null;

	      String sql = "SELECT o.order_no orderNo, o.customer_id customerId, o.order_quantity orderQuantity, o.order_price orderPrice, o.order_addr orderAddr,o.order_detail_addr orderDetailAddr, o.order_state orderState, o.update_date updateDate, o.create_date createDate, g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no ORDER BY o.order_no ASC LIMIT ?, ?";
	   PreparedStatement stmt = null;
	      ResultSet rs = null;

	      try {
	         list = new ArrayList<>();

	         stmt = conn.prepareStatement(sql);
	         stmt.setInt(1, beginRow);
	         stmt.setInt(2, rowPerPage);

	         rs = stmt.executeQuery();

	         while (rs.next()) {
	            map = new HashMap<String, Object>();
	            map.put("orderNo", rs.getInt("orderNo"));
	            map.put("customerId", rs.getString("customerId"));
	            map.put("orderQuantity", rs.getInt("orderQuantity"));
	            map.put("orderPrice", rs.getInt("orderPrice"));
	            map.put("orderAddr", rs.getString("orderAddr"));
	            map.put("orderDetailAddr", rs.getString("orderDetailAddr"));
	            map.put("orderState", rs.getString("orderState"));
	            map.put("updateDate", rs.getString("updateDate"));
	            map.put("createDate", rs.getString("createDate"));
	            map.put("goodsNo", rs.getInt("goodsNo"));
	            map.put("goodsName", rs.getString("goodsName"));
	            map.put("goodsPrice", rs.getInt("goodsPrice"));

	            list.add(map);
	         }
	      } finally {
	         if (rs != null) {
	            rs.close();
	         }
	         if (stmt != null) {
	            stmt.close();
	         }
	      }
	      return list;
	   }

	
	// 주문리스트 마지막페이지
    public int selectOrdersLastPage(Connection conn, int rowPerPage) throws SQLException {
       int totalCount = 0;
       String sql = "SELECT COUNT(*) FROM orders";
       
       PreparedStatement stmt = null;
       ResultSet rs = null;
       
       try {
          stmt = conn.prepareStatement(sql);
          rs = stmt.executeQuery();

          if (rs.next()) {
             totalCount = rs.getInt("COUNT(*)");
          }
       } finally {
          if(rs != null) {
             rs.close();
          }
          if(stmt != null) {
             stmt.close();
          }
       }
       
       return totalCount;
    }
    
    // 배송상태변경
    public int updateOrdersState(Connection conn, Orders orders) throws SQLException {
       int row = 0;
       String sql = "UPDATE orders SET order_state = ? WHERE order_no = ?";
       PreparedStatement stmt = null;

       try {
          stmt = conn.prepareStatement(sql);
          stmt.setString(1, orders.getOrderState());
          stmt.setInt(2, orders.getOrderNo());
          
          row = stmt.executeUpdate();
       }finally {
          if(stmt!=null) {
             stmt.close();
          }
       }
       
       return row;
    }
 // 주문리스트 마지막페이지
    public int selectOrdersLastPageByCustomer(Connection conn, String customerId, int rowPerPage) throws SQLException {
       int totalCount = 0;
       String sql = "SELECT COUNT(*) FROM orders WHERE customer_id = ?";
       
       PreparedStatement stmt = null;
       ResultSet rs = null;
       
       try {
          stmt = conn.prepareStatement(sql);
          stmt.setString(1, customerId);
          rs = stmt.executeQuery();

          if (rs.next()) {
             totalCount = rs.getInt("COUNT(*)");
          }
       } finally {
          if(rs != null) {
             rs.close();
          }
          if(stmt != null) {
             stmt.close();
          }
       }
       
       return totalCount;
    }

    // 고객 한명의 주문목록
    public List<Map<String, Object>> selectOrdersListByCustomer(Connection conn, String customerId, int rowPerPage,
          int beginRow) throws SQLException {
       List<Map<String, Object>> list = null;
       Map<String, Object> map = null;

       String sql = "SELECT o.order_no orderNo, o.order_quantity orderQuantity, o.order_price orderPrice, o.order_addr orderAddr, o.order_detail_addr orderDetailAddr, o.order_state orderState, o.update_date updateDate, o.create_date createDate, g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, c.customer_id customerId, c.customer_name customerName FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no INNER JOIN customer c ON o.customer_id = c.customer_id WHERE c.customer_id = ? ORDER BY o.order_no ASC LIMIT ?, ?";
       PreparedStatement stmt = null;
       ResultSet rs = null;

       try {
          list = new ArrayList<>();

          stmt = conn.prepareStatement(sql);
          stmt.setString(1, customerId);
          stmt.setInt(2, beginRow);
          stmt.setInt(3, rowPerPage);

          rs = stmt.executeQuery();

          while (rs.next()) {
             map = new HashMap<String, Object>();
             map.put("orderNo", rs.getInt("orderNo"));
             map.put("orderQuantity", rs.getInt("orderQuantity"));
             map.put("orderPrice", rs.getInt("orderPrice"));
             map.put("orderAddr", rs.getString("orderAddr"));
             map.put("orderDetailAddr", rs.getString("orderDetailAddr"));
             map.put("orderState", rs.getString("orderState"));
             map.put("updateDate", rs.getString("updateDate"));
             map.put("createDate", rs.getString("createDate"));
             map.put("goodsNo", rs.getInt("goodsNo"));
             map.put("goodsName", rs.getString("goodsName"));
             map.put("goodsPrice", rs.getInt("goodsPrice"));
             map.put("customerId", rs.getString("customerId"));
             map.put("customerName", rs.getString("customerName"));

             list.add(map);
          }
       } finally {
          if (rs != null) {
             rs.close();
          }
          if (stmt != null) {
             stmt.close();
          }
       }
       return list;
    }
 // 주문 상세보기
    public Map<String, Object> selectOrdersOne(Connection conn, int ordersNo) throws SQLException {
       Map<String, Object> map = null;
       
       String sql = "SELECT o.order_no orderNo, o.customer_id customerId, o.order_quantity orderQuantity"
             + ", o.order_price orderPrice, o.order_addr orderAddr, o.order_detail_addr orderDetailAddr, o.order_state orderState"
             + ", o.update_date updateDate, o.create_date createDate"
             + ", g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice"
             + " FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no WHERE o.order_no = ?";      
       PreparedStatement stmt = null;
       ResultSet rs = null;
       
       try {
          map = new HashMap<String, Object>();
          
          stmt = conn.prepareStatement(sql);
          stmt.setInt(1, ordersNo);
          
          rs = stmt.executeQuery();
          
          if(rs.next()) {
             map.put("orderNo", rs.getInt("orderNo"));
             map.put("customerId", rs.getString("customerId"));
             map.put("orderQuantity", rs.getInt("orderQuantity"));
             map.put("orderPrice", rs.getInt("orderPrice"));
             map.put("orderAddr", rs.getString("orderAddr"));
             map.put("orderDetailAddr", rs.getString("orderDetailAddr"));
             map.put("orderState", rs.getString("orderState"));
             map.put("updateDate", rs.getString("updateDate"));
             map.put("createDate", rs.getString("createDate"));
             map.put("goodsNo", rs.getInt("goodsNo"));
             map.put("goodsName", rs.getString("goodsName"));
             map.put("goodsPrice", rs.getInt("goodsPrice"));
          }
       } finally {
          if(rs != null) {
             rs.close();
          }
          if(stmt != null) {
             stmt.close();
          }
       }
       return map;
    }

}
