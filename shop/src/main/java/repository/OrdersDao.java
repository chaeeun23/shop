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
	// 고객 한명의 주문목록 (관리자, 고객)
	public List<Map<String, Object>> selectOrdersListByCustomer(Connection conn, String customerId, int rowPerPage,
			int beginRow) throws SQLException {
		List<Map<String, Object>> list = null;
		Map<String, Object> map = null;

		String sql = "SELECT o.orders_no ordersNo, o.orders_quantity ordersQuantity, o.orders_price ordersPrice, o.orders_addr ordersAddr, o.orders_state ordersState, o.update_date updateDate, o.create_date createDate, g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, c.customer_id customerId, c.customer_name customerName FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no INNER JOIN customer c ON o.customer_id = c.customer_id WHERE c.customer_id = ? ORDER BY o.create_date DESC LIMIT ?, ?";
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
				map.put("ordersNo", rs.getInt("ordersNo"));
				map.put("ordersQuantity", rs.getInt("ordersQuantity"));
				map.put("ordersPrice", rs.getInt("ordersPrice"));
				map.put("ordersAddr", rs.getString("ordersAddr"));
				map.put("ordersState", rs.getString("ordersState"));
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

	// 전체 주문 목록 (관리자만)
	public List<Map<String, Object>> selectOrdersList(Connection conn, int rowPerPage, int beginRow)
			throws SQLException {
		List<Map<String, Object>> list = null;
		Map<String, Object> map = null;

		String sql = "SELECT o.orders_no ordersNo, o.customer_id customerId, o.orders_quantity ordersQuantity, o.orders_price ordersPrice, o.orders_addr ordersAddr, o.orders_state ordersState, o.update_date updateDate, o.create_date createDate, g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no ORDER BY o.create_date DESC LIMIT ?, ?";
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
				map.put("ordersNo", rs.getInt("ordersNo"));
				map.put("customerId", rs.getString("customerId"));
				map.put("ordersQuantity", rs.getInt("ordersQuantity"));
				map.put("ordersPrice", rs.getInt("ordersPrice"));
				map.put("ordersAddr", rs.getString("ordersAddr"));
				map.put("ordersState", rs.getString("ordersState"));
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
	// 주문 상세보기
		public Map<String, Object> selectOrdersOne(Connection conn, int ordersNo) throws SQLException {
			Map<String, Object> map = null;
			
			String sql = "SELECT o.orders_no ordersNo, o.customer_id customerId, o.orders_quantity ordersQuantity"
					+ ", o.orders_price ordersPrice, o.orders_addr ordersAddr, o.orders_state ordersState"
					+ ", o.update_date updateDate, o.create_date createDate"
					+ ", g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice"
					+ " FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no WHERE o.orders_no = ?";		
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			try {
				map = new HashMap<String, Object>();
				
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, ordersNo);
				
				rs = stmt.executeQuery();
				
				if(rs.next()) {
					map.put("ordersNo", rs.getInt("ordersNo"));
					map.put("customerId", rs.getString("customerId"));
					map.put("ordersQuantity", rs.getInt("ordersQuantity"));
					map.put("ordersPrice", rs.getInt("ordersPrice"));
					map.put("ordersAddr", rs.getString("ordersAddr"));
					map.put("ordersState", rs.getString("ordersState"));
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
		// 배송상태변경
		public int updateOrdersState(Connection conn, Orders orders) throws SQLException {
			int row = 0;
			String sql = "UPDATE orders SET orders_state = ? WHERE orders_no = ?";
			PreparedStatement stmt = null;

			try {
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, orders.getOrdersState());
				stmt.setInt(2, orders.getOrdersNo());
				
				row = stmt.executeUpdate();
			}finally {
				if(stmt!=null) {
					stmt.close();
				}
			}
			
			return row;
		}
}
