<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="euc-kr"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
	//DB접속 위한 클래스	
	Connection conn = null;
	Connection conn2 = null;

	//접속 후 쿼리문 실행 시킬 클래스	
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;

	//질의문에 대한 결과값이 있는 클래스
	ResultSet rs = null;

	int delnum = -1;
	String month = null;
	String day = null;
	String name = null;
	int num = -1;

	int count = -1;
	ArrayList<String> arr;

	try {
		//MySQL을 불러온다.
		Class.forName("com.mysql.jdbc.Driver");

		//DB컨넥션 정보를 인자로 넘기고 커넥션을 얻는다.
		conn = DriverManager.getConnection(
				"jdbc:mysql://127.0.0.1:3306/reserve_sys",
				"kimpaksa", "rla123");
		conn2 = DriverManager.getConnection(
				"jdbc:mysql://127.0.0.1:3306/reserve_sys",
				"kimpaksa", "rla123");


		//최근에 Insert된 순서대로 정렬한다.
		pstmt = conn
				.prepareStatement("SELECT * FROM reserve_sys.reser_table ORDER BY num DESC;");
		//요청 질의문 실행 후 결과값을 얻는다.
		rs = pstmt.executeQuery();

		rs.next();
		count = rs.getInt(1);
		count++;

		if (request.getParameter("dataflag").compareTo("3") == 0) {
			delnum = Integer.parseInt(request.getParameter("num"));
			
			String sql = "DELETE FROM reserve_sys.reser_table WHERE NUM = ?";
			pstmt2 = conn2.prepareStatement(sql); // prepareStatement에서 해당 sql을 미리 컴파일한다.
			pstmt2.setInt(1, delnum);
			pstmt2.executeUpdate(); // 쿼리를 실행한다.
		} else {
			month = new String(request.getParameter("mm"));
			day = new String(request.getParameter("dd"));
			name = new String(request.getParameter("myname").getBytes(
					"8859_1"), "KSC5601");
			out.print(month + " " + day + " " + name + " ");
			
			if (request.getParameter("dataflag").compareTo("2") == 0) {
				num = Integer.parseInt(request.getParameter("number"));
			}
			
			
			arr = new ArrayList();

			/*
			min
			0 = "00"
			1 = "15"
			2 = "30"
			3 = "45"
			 */
			arr.add(request.getParameter("before_hour"));
			arr.add(request.getParameter("before_min"));
			arr.add(request.getParameter("after_hour"));
			arr.add(request.getParameter("after_min"));

			
			if ((request.getParameter("dataflag").compareTo("1") == 0)) {
				String sql = "insert into reserve_sys.reser_table(NUM,YEAR,MONTH,DAY,BEFORE_HOUR,BEFORE_MIN,AFTER_HOUR,AFTER_MIN,NAME)";
				sql += "values(?,?,?,?,?,?,?,?,?)"; // sql 쿼리

				pstmt2 = conn2.prepareStatement(sql); // prepareStatement에서 해당 sql을 미리 컴파일한다.
				out.print("1");
				pstmt2.setInt(1, count);
				pstmt2.setString(2, "2014");
				pstmt2.setString(3, month);
				pstmt2.setString(4, day);
				pstmt2.setString(5, arr.get(0));
				out.print("2");

				switch (Integer.parseInt(arr.get(1))) {
				case 0:
					pstmt2.setString(6, "00");
					break;
				case 1:
					pstmt2.setString(6, "15");
					break;
				case 2:
					pstmt2.setString(6, "30");
					break;
				case 3:
					pstmt2.setString(6, "45");
					break;
				}

				pstmt2.setString(7, arr.get(2));
				out.print("3");

				switch (Integer.parseInt(arr.get(3))) {
				case 0:
					pstmt2.setString(8, "00");
					break;
				case 1:
					pstmt2.setString(8, "15");
					break;
				case 2:
					pstmt2.setString(8, "30");
					break;
				case 3:
					pstmt2.setString(8, "45");
					break;
				}

				pstmt2.setString(9, name);

				pstmt2.executeUpdate(); // 쿼리를 실행한다.

			} else if ((request.getParameter("dataflag").compareTo("2") == 0)) {
				String sql = "UPDATE reserve_sys.reser_table SET NUM = ?,YEAR = ?,MONTH = ?,DAY = ?,BEFORE_HOUR = ?,BEFORE_MIN = ?,AFTER_HOUR = ?,AFTER_MIN = ?,NAME = ? WHERE NUM = "
						+ num;

				pstmt2 = conn2.prepareStatement(sql); // prepareStatement에서 해당 sql을 미리 컴파일한다.
				out.print("1");
				pstmt2.setInt(1, count);
				pstmt2.setString(2, "2014");
				pstmt2.setString(3, month);
				pstmt2.setString(4, day);
				pstmt2.setString(5, arr.get(0));
				out.print("2");

				switch (Integer.parseInt(arr.get(1))) {
				case 0:
					pstmt2.setString(6, "00");
					break;
				case 1:
					pstmt2.setString(6, "15");
					break;
				case 2:
					pstmt2.setString(6, "30");
					break;
				case 3:
					pstmt2.setString(6, "45");
					break;
				}

				pstmt2.setString(7, arr.get(2));
				out.print("3");

				switch (Integer.parseInt(arr.get(3))) {
				case 0:
					pstmt2.setString(8, "00");
					break;
				case 1:
					pstmt2.setString(8, "15");
					break;
				case 2:
					pstmt2.setString(8, "30");
					break;
				case 3:
					pstmt2.setString(8, "45");
					break;
				}

				pstmt2.setString(9, name);

				pstmt2.executeUpdate(); // 쿼리를 실행한다.

			}
		}

		
		out.print("DB Insert Complate");
		response.sendRedirect("./index.jsp");

	} catch (Exception e) {
		e.printStackTrace();
		out.print(e.toString());
	} finally {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (pstmt2 != null)
			pstmt2.close();
		if (conn != null)
			conn.close();
		if (conn2 != null)
			conn2.close();
	}
%>