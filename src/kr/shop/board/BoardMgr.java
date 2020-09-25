package kr.shop.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardMgr {	//BL : 鍮꾩쫰�땲�뒪 濡쒖쭅
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	private int tot;	//�쟾泥� �젅肄붾뱶 �닔
	private int pList = 10;	//�럹�씠吏� �떦 �옄猷� 異쒕젰 �뻾 �닔 
	private int pageSu;	//�쟾泥� �럹�씠吏� �닔(default = 0)
	
	public BoardMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");	//jdbc_maria : context.xml�뿉 �엳�뒗 �씠由�
		} catch (Exception e) {
			System.out.println("BoardMgr err : " + e);
		}
	}
	
	public ArrayList<BoardDto> getDataAll(int page, String stype, String sword){	//紐⑸줉蹂닿린
		ArrayList<BoardDto> list = new ArrayList<BoardDto>();
		//String sql = "select * from shopboard order by gnum desc, onum asc";
		
		String sql = "select * from shopboard";
		
		try {
			conn = ds.getConnection();
			if(sword == null) {
				sql += " order by gnum desc, onum asc";
				pstmt = conn.prepareStatement(sql);
			} else {	//寃��깋
				sql += " where " + stype + " like ?";
				sql += " order by gnum desc, onum asc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + sword + "%");
			}
			rs = pstmt.executeQuery();
			
			//paging
			for (int i = 0; i < (page - 1) * pList; i++) {
				rs.next(); 	
			}
			
			int k = 0;
			while(rs.next() && k < pList) {
				BoardDto dto = new BoardDto();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setBdate(rs.getString("bdate"));
				dto.setReadcnt(rs.getInt("readcnt"));
				dto.setNested(rs.getInt("nested"));
				list.add(dto);
				k++;
			}
		} catch (Exception e) {
			System.out.println("getDataAll err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return list;
	}

	public int currentGetNum() {	
		String sql = "select max(num) from shopboard";
		int cnt = 0;
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) cnt = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("currentGetNum err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();	//�븘�슂�뾾�쑝硫� �뿰寃� �빐�젣
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return cnt;
	}

	public void saveData(BoardBean bean) {
		String sql = "insert into shopboard values(?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getPass());
			pstmt.setString(4, bean.getMail());
			pstmt.setString(5, bean.getTitle());
			pstmt.setString(6, bean.getCont());
			pstmt.setString(7, bean.getBip());
			pstmt.setString(8, bean.getBdate());
			pstmt.setInt(9, 0); 	//readcnt
			pstmt.setInt(10, bean.getGnum());
			pstmt.setInt(11, 0);	//onum
			pstmt.setInt(12, 0);	//nested
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("saveData err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();	
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}

	public void totalList() {
		String sql = "select count(*) from shopboard";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			tot = rs.getInt(1);
		
		} catch (Exception e) {
			System.out.println("totalList err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
	}

	public int getPageSu() {
		pageSu = tot / pList;
		if(tot % pList > 0) pageSu++;
		return pageSu;
	}

	public void updateReadcnt(String num) {	
		String sql = "update shopboard set readcnt=readcnt + 1 where num=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("updateReadcnt err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();	
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}

	}
	
	public BoardDto getData(String num) {
		String sql = "select * from shopboard where num=?";
		BoardDto dto = null;
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new BoardDto();
				dto.setNum(Integer.parseInt(num));
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				dto.setMail(rs.getString("mail"));
				dto.setTitle(rs.getString("title"));
				dto.setCont(rs.getString("cont"));
				dto.setBip(rs.getString("bip"));
				dto.setBdate(rs.getString("bdate"));
				dto.setReadcnt(rs.getInt("readcnt"));				
			}
		} catch (Exception e) {
			System.out.println("getData err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();	
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return dto;
	}
	
	public BoardDto getReplyData(String num) {	//�뙎湲��슜
		BoardDto dto = null;
		String sql = "select * from shopboard where num=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new BoardDto();
				dto.setTitle(rs.getString("title"));
				dto.setGnum(rs.getInt("gnum"));	//湲��꽆踰�
				dto.setOnum(rs.getInt("onum"));	//�삤�뜑�꽆踰�
				dto.setNested(rs.getInt("nested"));
			}
		} catch (Exception e) {
			System.out.println("getReplyData err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();	// �궗�슜�븞�븯硫� �쟻�쓣 �븘�슂X
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();	//�븘�슂�뾾�쑝硫� �뿰寃� �빐�젣
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return dto;
	}
	
	public void updateOnum(int gnum, int onum) {	
		String sql = "update shopboard set onum=onum + 1 where onum >= ? and gnum=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, onum);
			pstmt.setInt(2, gnum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("updateOnum err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();	// �궗�슜�븞�븯硫� �쟻�쓣 �븘�슂X
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();	//�븘�슂�뾾�쑝硫� �뿰寃� �빐�젣
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
		
	public void saveReplyData(BoardBean bean) {	//�뙎湲��슜
		String sql = "insert into shopboard values(?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getPass());
			pstmt.setString(4, bean.getMail());
			pstmt.setString(5, bean.getTitle());
			pstmt.setString(6, bean.getCont());
			pstmt.setString(7, bean.getBip());
			pstmt.setString(8, bean.getBdate());
			pstmt.setInt(9, 0); 	//readcnt
			pstmt.setInt(10, bean.getGnum());
			pstmt.setInt(11, bean.getOnum());	//onum
			pstmt.setInt(12, bean.getNested());	//nested
			pstmt.executeUpdate();
				
		} catch (Exception e) {
			System.out.println("saveReplyData err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();	//�븘�슂�뾾�쑝硫� �뿰寃� �빐�젣
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	
	public boolean checkPass(int num, String new_pass) {	//�닔�젙 �옉�뾽�뿉�꽌 鍮꾨쾲 鍮꾧탳
		boolean b = false;
		String sql = "select pass from shopboard where num=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(new_pass.equals(rs.getString("pass"))) {
					b = true;
				}
			}
		} catch (Exception e) {
			System.out.println("checkPass err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();	//�븘�슂�뾾�쑝硫� �뿰寃� �빐�젣
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return b;
	}
	
	public void saveEdit(BoardBean bean) {
		String sql = "update shopboard set name=?,mail=?,title=?,cont=? where num=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getMail());
			pstmt.setString(3, bean.getTitle());
			pstmt.setString(4, bean.getCont());
			pstmt.setInt(5, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("saveEdit err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();	//�븘�슂�뾾�쑝硫� �뿰寃� �빐�젣
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
	}
	
	public void delData(String num) {
		String sql = "delete from shopboard where num=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("delData err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();	//�븘�슂�뾾�쑝硫� �뿰寃� �빐�젣
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	
}
