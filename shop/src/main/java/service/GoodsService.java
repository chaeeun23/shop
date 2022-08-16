package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.GoodsDao;
import repository.GoodsImgDao;
import vo.Goods;
import vo.GoodsImg;

public class GoodsService {
	private GoodsDao goodsDao; 
	private GoodsImgDao goodsImgDao;
	// 상품삭제
	public int removeGoods(int goodsNo) throws SQLException {
		Connection conn = null;
		
		int imgRow = 0;
		int row = 0;
		try {
			conn = new DBUtil().getConnection();
			
			goodsDao = new GoodsDao();
			goodsImgDao = new GoodsImgDao();
			
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			imgRow = goodsImgDao.deleteGoodsOneImg(conn, goodsNo);
			if (imgRow != 0) { 
				row = goodsDao.deleteGoodsOne(conn, goodsNo);
				if (row == 0) {
					throw new Exception(); 
				}
			}
			conn.commit();
		} catch (Exception e) { 
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); 
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		} finally {
			if (conn != null) {
				conn.close();
			}
		}
		return row;
	}
	
	// 상품수정
	public int modifyGoods(Goods goods, GoodsImg goodsImg) {
		int row = 0;
		
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			goodsDao = new GoodsDao();
			goodsImgDao = new GoodsImgDao();
			
			row = goodsDao.updateGoods(conn, goods);
			
			if(row != 0) {
				row = goodsImgDao.updateGoodsImg(conn, goodsImg);
				if(row == 0) {
					throw new Exception();  
				}
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
		return row;
	}
	
	// 상품추가
	public int addGoods(Goods goods, GoodsImg goodsImg) {
		int goodsNo = 0;
		
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			goodsDao = new GoodsDao();
			goodsImgDao = new GoodsImgDao();
			
			goodsNo = goodsDao.insertGoods(conn, goods); 
			System.out.println(goodsNo + " <-- goodsNo");
			
			if(goodsNo != 0) {
				goodsImg.setGoodsNo(goodsNo);
				if(goodsImgDao.insertGoodsImg(conn, goodsImg) == 0) {
					throw new Exception();   
				}
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
		return goodsNo;
	}
	
	// 상품 상세보기
	public Map<String, Object> getGoodsAndImgOne(int goodsNo) {
		Connection conn = null;
		Map<String, Object> map = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.goodsDao = new GoodsDao();	
			map = goodsDao.selectGoodsAndImgOne(conn, goodsNo);
			
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
	
	// 상품 품절 변경
	public boolean modifyGoodsSoldOut(Goods goods) {
		Connection conn = null;
		boolean result = false;
		int row = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.goodsDao = new GoodsDao();	
			row = goodsDao.updateGoodsSoldOut(conn, goods);
			
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
	
	// 상품리스트
	public List<Goods> getGoodsListByPage(int rowPerPage, int currentPage) {
		List<Goods> list = null;
		Connection conn = null;
		int beginRow;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.goodsDao = new GoodsDao();		 			
			beginRow = (currentPage - 1) * rowPerPage;
			list = goodsDao.selectGoodsListByPage(conn, rowPerPage, beginRow);
			
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
	
	// 상품 마지막 페이지
	public int getGoodsLastPage(int rowPerPage) {
		int lastPage = 0;
		int totalCount = 0;
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.goodsDao = new GoodsDao();		 			
			totalCount = goodsDao.selectGoodsLastPage(conn, rowPerPage);
			
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
}