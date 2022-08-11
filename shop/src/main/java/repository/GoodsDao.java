package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Goods;

public class GoodsDao {
	//고객 상품리스트 페이지에서 사용
	public List<Map<String, Object>> selectCustomerGoodsListByPage(Connection conn, int rowPerPage, int beginRow) throws SQLException{
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		//고객의 판매량수가 많은 것 부터
		String sql="SELECT g.*, t.* FROM goods g LEFT JOIN (SELECT goods_no, SUM(order_quantity) FROM orders GROUP BY goods_no) t g.goods_no = t.goods_no ORDER BY t.";
		
		stmt = conn.prepareStatement(sql);
		rs=stmt.executeQuery();
		
		while(rs.next()) {
			Map<String, Object> map = new HashMap<String,Object>();
		}
		if(rs != null) {
			rs.close();
		}
		if(stmt != null) {
			stmt.close();
		}
		return list;
	}
	//상품 수정
	public int updateGoods(Connection conn, Goods goods) throws SQLException {
		int row = 0;
		
		String sql = "UPDATE goods SET goods_name = ?, goods_price = ?, update_date = NOW()"
				+ " WHERE goods_no = ?";
		PreparedStatement stmt = null;		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, goods.getGoodsName());
			stmt.setInt(2, goods.getGoodsPrice());
			stmt.setInt(3, goods.getGoodsNo());

			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		System.out.println(row + " <-- row");
		return row;
	}
	
	//상품 추가
	 // 반환값 : key값 (jdbc api)
	   public int insertGoods(Connection conn, Goods goods) throws SQLException {
	      int keyId = 0;
	      String sql = "INSERT INTO goods (goods_name, goods_price, update_date, create_date,  sold_out) VALUES (?, ?, now(), now(), ?)";
	      PreparedStatement stmt = null;
	      ResultSet rs = null;
	      // 1) insert
	      // 2) select last_ai_key from...
	      try {
				stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				stmt.setString(1, goods.getGoodsName());
				stmt.setInt(2, goods.getGoodsPrice());
				stmt.setString(3, goods.getSoldOut());
				
				// 1) insert
				stmt.executeUpdate(); // insert 성공한 row 수
				
				// 2) select last_ai_key from ...
				rs = stmt.getGeneratedKeys(); // select last_key
				
				if(rs.next()) {
					keyId = rs.getInt(1);
				}
			} finally {
				if(rs != null) {
					rs.close();
				}
				if(stmt != null) {
					stmt.close();
				}
			}
	      //
			System.out.println(keyId + " <-- GoodsDao/keyId");
			return keyId;
		}
	//제품 상세보기
	public Map<String, Object> selectGoodsAndImgOne(Connection conn, int goodsNo) throws SQLException {
		Map<String, Object> map = null;
		String sql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.update_date updateDate, g.create_date createDate, g.sold_out soldOut, gi.filename filename, gi.origin_filename originFilename, gi.content_type contentType FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_no = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		//
		System.out.println(goodsNo + "<-- GoodsDao/goodsNo");
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			rs = stmt.executeQuery();
			while (rs.next()) {
				map = new HashMap<String, Object>();
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getInt("goodsPrice"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				map.put("soldOut", rs.getString("soldOut"));
				map.put("filename", rs.getString("filename"));
				map.put("originFilename", rs.getString("originFilename"));
				map.put("contentType", rs.getString("contentType"));
			}

		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}

		return map;
	}

	// 상품리스트
	public List<Goods> selectGoodsListByPage(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		List<Goods> list = new ArrayList<>();
		Goods goods = new Goods();
		String sql = "SELECT goods_no goodsNo, goods_name goodsName, goods_price goodsPrice, update_date updateDate, create_date createDate, sold_out soldOut FROM goods ORDER BY goods_no DESC LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while (rs.next()) {
				goods.setGoodsNo(rs.getInt("goodsNo"));
				goods.setGoodsName(rs.getString("goodsName"));
				goods.setGoodsPrice(rs.getInt("goodsPrice"));
				goods.setUpdateDate(rs.getString("updateDate"));
				goods.setCreateDate(rs.getString("createDate"));
				goods.setSoldOut(rs.getString("soldOut"));
				list.add(goods);
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
	// 상품 soldout 변경
		public int updateGoodsSoldOut(Connection conn, Goods goods) throws SQLException {
			int row = 0;
			String sql = "UPDATE goods SET sold_out = ? WHERE goods_no = ?";
			PreparedStatement stmt = null;

			try {
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, goods.getSoldOut());
				stmt.setInt(2, goods.getGoodsNo());
				
				row = stmt.executeUpdate();
			}finally {
				if(stmt!=null) {
					stmt.close();
				}
			}
			return row;
		}
//상품리스트 마지막페이지
		public int selectGoodsLastPage(Connection conn, int rowPerPage) throws SQLException {
			int totalCount = 0;
			String sql = "SELECT COUNT(*) FROM goods";
			
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
}
