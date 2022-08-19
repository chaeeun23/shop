package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import repository.GoodsDao;
import repository.OrdersDao;
import vo.Orders;

public class OrdersService {
	private OrdersDao ordersDao; 
	
	// 고객별 주문 마지막 페이지
		public int getOrdersLastPageByCustomer(String cusotmerId, int rowPerPage) {
			int lastPage = 0;
			int totalCount = 0;
			Connection conn = null;
			
			try {
				conn = new DBUtil().getConnection();
				conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
				
				this.ordersDao = new OrdersDao();		 			
				totalCount = ordersDao.selectOrdersLastPageByCustomer(conn, cusotmerId, rowPerPage);
				
				if(totalCount == 0) { 
					throw new Exception();
				}
				
				lastPage = totalCount / rowPerPage;
				if (totalCount % rowPerPage != 0) {
					lastPage += 1;
				}
				conn.commit();		
			} catch (Exception e) {
				e.printStackTrace(); // console에 예외메세지 출력
				try {
					conn.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return lastPage;
		}
	//주문마지막페이지	
	public int getOrdersLastPage(int rowPerPage) {
		int lastPage = 0;
		int totalCount =0;
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.ordersDao = new OrdersDao();		 			
			totalCount = ordersDao.selectOrdersLastPage(conn, rowPerPage);
			
			if(totalCount == 0) {
				throw new Exception();
			}
			
			lastPage = totalCount / rowPerPage;
			if (totalCount % rowPerPage != 0) {
				lastPage += 1;
			}
			conn.commit();		
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return lastPage;
	}
	// 고객 한명의 주문목록
	public List<Map<String, Object>> getOrdersListByCustomer(String customerId, int rowPerPage, int currentPage) {
		List<Map<String, Object>> list = null; 

		int beginRow=0;
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			list = new ArrayList<>();
			
			ordersDao = new OrdersDao();
			beginRow = (currentPage - 1) * rowPerPage;
			
			list = ordersDao.selectOrdersListByCustomer(conn, customerId, rowPerPage, beginRow);
			
			if(list == null) { 
				throw new Exception();
			}
				
			conn.commit();		
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 배송상태변경
	public boolean modifyOrdersState(Orders orders) {
		boolean result = false;
		Connection conn = null;
		int row = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.ordersDao = new OrdersDao();	
			row = ordersDao.updateOrdersState(conn, orders);
			
			if(row != 1) { 
				throw new Exception();
			} else {
				result = true;
			}		
			conn.commit();		
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); 
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	// 주문 상세보기
	public Map<String, Object> getOrdersOne(int ordersNo) throws SQLException {
		Map<String, Object> map = null; 

		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			map = new HashMap<>();			
			ordersDao = new OrdersDao();
			
			map = ordersDao.selectOrdersOne(conn, ordersNo);
			
			if(map == null) { 
				throw new Exception();
			}
				
			conn.commit();		
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); 
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
	}
	
	// 전체 주문 목록
	public List<Map<String, Object>> getOrdersList(int rowPerPage, int currentPage) {
		List<Map<String, Object>> list = null; 

		int beginRow;
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			list = new ArrayList<>();
			
			ordersDao = new OrdersDao();
			beginRow = (currentPage - 1) * rowPerPage;
			
			list = ordersDao.selectOrdersList(conn, rowPerPage, beginRow);
			
			if(list == null) { 
				throw new Exception();
			}
				
			conn.commit();		
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); 
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
}