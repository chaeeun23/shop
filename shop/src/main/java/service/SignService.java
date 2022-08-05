package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.SignDao;

public class SignService {
	private SignDao signDao;
	//return
	//true : 사용가능한 아이디
	//false : 
	public boolean idCheck(String id) throws SQLException {
		boolean result = false;
		SignDao signDao = new SignDao();
		this.signDao = new SignDao();
		
		Connection conn= null;
		try {
			conn=new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			if(signDao.idCheck(conn, id)==null) {
				result = true;
			}
			conn.commit();
			
		} catch(Exception e) {
			e.printStackTrace();
			conn.rollback();
			
		} finally {
			
			}
		return result;
		}
	} 
	
