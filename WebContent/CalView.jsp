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
	
	//DB���� ���� Ŭ����	
	Connection conn = null;

	//���� �� ������ ���� ��ų Ŭ����	
	PreparedStatement pstmt = null;
	
	//���ǹ��� ���� ������� �ִ� Ŭ����
	ResultSet rs = null;
	
	try{
		//MySQL�� �ҷ��´�.
		Class.forName("com.mysql.jdbc.Driver");
		
		//DB���ؼ� ������ ���ڷ� �ѱ�� Ŀ�ؼ��� ��´�.
		conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/reserve_sys", "kimpaksa", "rla123");
		
		//Ŀ�ؼ� ��ü�� ���� �� �������� DB�� ��û
		pstmt = conn.prepareStatement("SELECT * FROM reserve_sys.reser_table WHERE NUM = ?");
		pstmt.setInt(1, Integer.parseInt(num));
						
		//��û ���ǹ� ���� �� ������� ��´�.
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
		if (confirm("���� �Ͻðڽ��ϱ�?")){
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
	<td>�̸�</td>
	<td><%=data.name %></td>
<tr>
<tr>
	<td>����ð�</td>
	<td><%=data.beforeHour %>:<%=data.beforeMin %>~<%=data.afterHour %>:<%=data.afterMin %></td>
<tr>
<tr>
	<td><input type='button' value='����' onClick='onModify(<%=num %>);' /></td>
	<td><input type='button' value='����' onClick='onDelete(<%=num %>);' /></td>
<tr>
</table>


</body>
</html>