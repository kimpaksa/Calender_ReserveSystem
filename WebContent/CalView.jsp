<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%!
	public class ReserveData {
		int num;
		String year;
		String month;
		String day;
		String beforeHour;
		String beforeMin;
		String afterHour;
		String afterMin;
		String name;

		public ReserveData(){}
		public ReserveData(int num, String year, String month, String day, String beforeHour,
				String beforeMin, String afterHour, String afterMin, String name) {
			this.num = num;
			this.year = year;
			this.month = month;
			this.day = day;
			this.beforeHour = beforeHour;
			this.beforeMin = beforeMin;
			this.afterHour = afterHour;
			this.afterMin = afterMin;
			this.name = name;
		}
	}
%>

<%
	String num = request.getParameter("num");
	
	ReserveData data = null;
	
	//DB접속 위한 클래스	
	Connection conn = null;

	//접속 후 쿼리문 실행 시킬 클래스	
	PreparedStatement pstmt = null;
	
	//질의문에 대한 결과값이 있는 클래스
	ResultSet rs = null;
	
	try{
		//MySQL을 불러온다.
		Class.forName("com.mysql.jdbc.Driver");
		
		//DB컨넥션 정보를 인자로 넘기고 커넥션을 얻는다.
		conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/reserve_sys", "kimpaksa", "rla123");
		
		//커넥션 객체를 얻은 후 쿼리문을 DB에 요청
		pstmt = conn.prepareStatement("SELECT * FROM reserve_sys.reser_table WHERE NUM = ?");
		pstmt.setInt(1, Integer.parseInt(num));
						
		//요청 질의문 실행 후 결과값을 얻는다.
		rs = pstmt.executeQuery();
	
		rs.next();
		data = new ReserveData(rs.getInt(1), rs.getString(2), 
					rs.getString(3), rs.getString(4), rs.getString(5), 
					rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9));
	
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type='text/javascript'>
	function onModify(num){
		location.href="CalSet.jsp?num="+num+"&actiontype=modify";
	}
	
	function onDelete(num){
		if (confirm("삭제 하시겠습니까?")){
			location.href="CalProcess.jsp?num="+num+"&dataflag=3";
		} else {
			location.href="index.jsp";
		}
	}
</script>
</head>
<body>

<table border='1'>
<tr>
	<td>이름</td>
	<td><%=data.name %></td>
<tr>
<tr>
	<td>예약시간</td>
	<td><%=data.beforeHour %>:<%=data.beforeMin %>~<%=data.afterHour %>:<%=data.afterMin %></td>
<tr>
<tr>
	<td><input type='button' value='수정' onClick='onModify(<%=num %>);' /></td>
	<td><input type='button' value='삭제' onClick='onDelete(<%=num %>);' /></td>
<tr>
</table>


</body>
</html>