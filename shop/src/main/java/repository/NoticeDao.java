package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Notice;

public class NoticeDao {
	//마지막페이지
	public int selectNoticeLastPage(Connection conn, int rowPerPage) throws SQLException {
		String sql = "SELECT COUNT(*) FROM notice";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalCount = 0;
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();

			if (rs.next()) {
				totalCount = rs.getInt("COUNT(*)");
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return totalCount;
	}
	
	// 공지 리스트
		public List<Notice> selectNoticeList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
			List<Notice> list = new ArrayList<Notice>();
			
			String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, employee_id employeeId, update_date updateDate  FROM notice ORDER BY notice_no ASC LIMIT ?,?";
			PreparedStatement stmt = null;
			ResultSet rs = null;

			try {
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, beginRow);
				stmt.setInt(2, rowPerPage);
				rs = stmt.executeQuery();
				while (rs.next()) {
					Notice notice = new Notice();
					notice.setNoticeNo(rs.getInt("noticeNo"));
					notice.setNoticeTitle(rs.getString("noticeTitle"));
					notice.setEmployeeId(rs.getString("employeeId"));
					notice.setUpdateDate(rs.getString("updateDate"));
					
					list.add(notice);
				}
			} finally {
				if (rs != null) {
					rs.close();
				}
				if (stmt != null) {
					rs.close();
				}
			}
			return list;
		}
		//공지작성
		public int insertNotice(Connection conn, Notice paramNotice) throws SQLException {
			int row = 0;
			
			String sql="INSERT INTO notice(notice_title, employee_id, notice_content, create_date, update_date) VALUES(?,?,?,NOW(),NOW())";
			PreparedStatement stmt = null;
			try {
				stmt=conn.prepareStatement(sql);
				stmt.setString(1, paramNotice.getNoticeTitle());
				stmt.setString(2, paramNotice.getEmployeeId());
				stmt.setString(3,  paramNotice.getNoticeContent());
				row = stmt.executeUpdate();
			} finally {
				if (stmt != null) {
					stmt.close();
				}
			}
			return row;
		}
}
