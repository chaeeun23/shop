package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import vo.GoodsImg;

public class GoodsImgDao {
	// 이미지 추가
		public int insertGoodsImg(Connection conn, GoodsImg goodsImg) throws SQLException {
			int row = 0;
			
			String sql = "INSERT INTO goods_img (goods_no, filename, origin_filename, content_type, create_date) VALUES (?, ?, ?, ?, now())";
			PreparedStatement stmt = null;		
			try {
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, goodsImg.getGoodsNo());
				stmt.setString(2, goodsImg.getFileName());
				stmt.setString(3, goodsImg.getOriginFileName());
				stmt.setString(4, goodsImg.getContentType());
				
				row = stmt.executeUpdate(); 
			} finally {
				if(stmt != null) {
					stmt.close();
				}
			}
			
			System.out.println(row + " <-- row");
			return row;
		}
		// 이미지 수정
		public int updateGoodsImg(Connection conn, GoodsImg goodsImg) throws SQLException {
			int row = 0;
			
			String sql = "UPDATE goods_img SET filename = ?, origin_filename = ?, content_type = ? WHERE goods_no = ?";
			PreparedStatement stmt = null;		
			try {
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, goodsImg.getFileName());
				stmt.setString(2, goodsImg.getOriginFileName());
				stmt.setString(3, goodsImg.getContentType());
				stmt.setInt(4, goodsImg.getGoodsNo());
				
				row = stmt.executeUpdate(); 
			} finally {
				if(stmt != null) {
					stmt.close();
				}
			}
			
			System.out.println(row + " <-- row");
			return row;
		}
	}