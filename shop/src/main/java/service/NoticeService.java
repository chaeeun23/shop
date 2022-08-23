package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import repository.CustomerDao;
import repository.NoticeDao;
import repository.OutIdDao;
import vo.Notice;

public class NoticeService {
	private NoticeDao noticeDao;

	// 마지막 페이지
	public int getNoticeLastPage(int rowPerPage) {
		int lastPage = 0;
		int totalCount = 0;
		Connection conn = null;
		NoticeDao noticeDao = null;

		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음

			noticeDao = new NoticeDao();
			totalCount = noticeDao.selectNoticeLastPage(conn, rowPerPage);

			if (totalCount == 0) {
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

	// 고객리스트
	public List<Notice> getNoticeList(int rowPerPage, int currentPage) {
		List<Notice> list = null;
		Connection conn = null;
		int beginRow = 0;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);

			beginRow = (currentPage - 1) * rowPerPage;

			noticeDao = new NoticeDao();
			list = noticeDao.selectNoticeList(conn, rowPerPage, beginRow);

			if (list == null) {
				throw new Exception();
			}

		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); // 예외를 던지지말고 감싸야함
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

	// 공지작성
	public int addNotice(Notice paramNotice) {
		int row = 0;
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);

			noticeDao = new NoticeDao();
			row = noticeDao.insertNotice(conn, paramNotice);
			if (row == 0) {
				throw new Exception();
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace(); // 예외메세지를 콘솔에 띄움
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
	//공지수정
	public int modifyNotice(Notice paramNotice) {
		int row=0;
		Connection conn=null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);

			NoticeDao noticeDao = new NoticeDao();
			row = noticeDao.updateNotice(conn, paramNotice);
			if (row == 0) {
				throw new Exception();
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace(); // 예외메세지를 콘솔에 띄움
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
	//공지 상세보기
	public Notice getNoticeOne(int noticeNo){
		//
		System.out.println(noticeNo+" <-- service/noticeNo");
		Notice notice = new Notice();
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			noticeDao=new NoticeDao();
			notice = noticeDao.selectNotice(conn, noticeNo);
			
			if(notice==null) {
				throw new Exception();
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		return notice;
	}
	//공지삭제
	public int removeNotice(Notice paramNotice) {
		int row = 0;
		Connection conn=null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋 안되게 잠금

			noticeDao = new NoticeDao();
			row=noticeDao.deleteNotice(conn, paramNotice.getNoticeNo());
			
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace(); // 예외메세지를 콘솔에 띄움
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
}
