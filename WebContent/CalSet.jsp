<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="euc-kr"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
	GregorianCalendar gc = new GregorianCalendar();
	String actionType=null;
	String num=null;
	
	// DB접속 위한 클래스	
	Connection conn = null;

	//접속 후 쿼리문 실행 시킬 클래스	
	PreparedStatement pstmt = null;

	//질의문에 대한 결과값이 있는 클래스
	ResultSet rs = null;

	try {
		//MySQL을 불러온다.
		Class.forName("com.mysql.jdbc.Driver");

		//DB컨넥션 정보를 인자로 넘기고 커넥션을 얻는다.
		conn = DriverManager.getConnection(
				"jdbc:mysql://127.0.0.1:3306/reserve_sys", "kimpaksa",
				"rla123");

		if (request.getParameter("actiontype").compareTo("new") == 0){
			actionType = request.getParameter("actiontype");
		} else {
			num = request.getParameter("num");
			actionType = request.getParameter("actiontype");	
			//커넥션 객체를 얻은 후 쿼리문을 DB에 요청
			pstmt = conn
					.prepareStatement("SELECT * FROM reserve_sys.reser_table WHERE num="
							+ num);

			//요청 질의문 실행 후 결과값을 얻는다.
			rs = pstmt.executeQuery();

			rs.next();
		}
		
		
		

		//out.print(Integer.parseInt(rs.getString(3)));

		//	gc.get(Calendar.YEAR),	
		//(gc.get(Calendar.MONTH)+1),
		//gc.get(Calendar.DATE)+1);
		
		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script type='text/javascript'>
	function onTimeCheck() {
		alert(document.getElementsByName("mm").value);
	}

	//after_hour는 before_hour보다 작을 수 없다.
</script>

</head>
<body>

	<center>
		<span>신청</span>
	</center>

	<form action='CalProcess.jsp' method='POST'>
		<table border='1' cellpadding='0' cellspacing='0' align='center'>
			<tr>
				<td>이름 :</td>
				<td>
				<%
					if (actionType.compareTo("new") == 0) {
				%>
					<input type='text' name='myname'>
				<%
					} else if (actionType.compareTo("modify") == 0) { 
				%>
					<input type='text' name='myname' value='<%=rs.getString("name") %>'>
				<%
					} 
				%>
				
				</td>
			</tr>

			<tr>
				<td>예약월일 :</td>
				<td><select name='mm'>
						<%
							for (int i = 1; i <= 12; i++) {
									if (actionType.compareTo("new") == 0) {
						%>
						<option value='<%=i%>'
							<%if (i == (gc.get(Calendar.MONTH) + 1))
							out.print("selected");%>>
							<%=i%></option>
						<%
							} else if (actionType.compareTo("modify") == 0) {
						%>
						<option value='<%=i%>'
							<%if (i == Integer.parseInt(rs.getString("month")))
							out.print("selected");%>>
							<%=i%></option>
						<%
							}
								}
						%>
				</select> 월 <select name='dd'>
						<%
							for (int i = 1; i <= 31; i++) {
									if (actionType.compareTo("new") == 0) {
						%>
						<option value='<%=i%>'
							<%if (i == gc.get(Calendar.DATE) + 1)
							out.print("selected");%>><%=i%></option>
						<%
							} else if (actionType.compareTo("modify") == 0) {
						%>
						<option value='<%=i%>'
							<%if (i == Integer.parseInt(rs.getString("day")))
							out.print("selected");%>><%=i%></option>
						<%
							}
								}
						%>
				</select> 일</td>
			</tr>

			<tr>
				<td>시작시간 :</td>
				<td><select name='before_hour'>
						<%
							for (int i = 1; i <= 24; i++) {
									if (actionType.compareTo("new") == 0) {
						%>
						<option value='<%=i%>'><%=i%></option>
						<%
							} else if (actionType.compareTo("modify") == 0) {
						%>
						<option value='<%=i%>'
							<%if (i == Integer.parseInt(rs.getString("before_hour")))
							out.print("selected");%>><%=i%></option>
						<%
							}
								}
						%>
				</select> : <select name='before_min'>
						<%
							int dd = -1;

								if (actionType.compareTo("new") == 0) {
						%>
						<option value='0' selected>00</option>
						<option value='1'>15</option>
						<option value='2'>30</option>
						<option value='3'>45</option>

						<%
							} else if (actionType.compareTo("modify") == 0) {

									if (rs.getString("before_min").compareTo("00") == 0) {
										dd = 0;
									} else if (rs.getString("before_min").compareTo("15") == 0) {
										dd = 1;
									} else if (rs.getString("before_min").compareTo("30") == 0) {
										dd = 2;
									} else {
										dd = 3;
									}
						%>
						<option value='0' <%if (dd == 0)
						out.print("selected");%>>00</option>
						<option value='1' <%if (dd == 1)
						out.print("selected");%>>15</option>
						<option value='2' <%if (dd == 2)
						out.print("selected");%>>30</option>
						<option value='3' <%if (dd == 3)
						out.print("selected");%>>45</option>
						<%
							}
						%>


				</select> ~ <select name='after_hour'>
						<%
							for (int i = 1; i <= 24; i++) {
									if (actionType.compareTo("new") == 0) {
						%>
						<option value='<%=i%>'><%=i%></option>
						<%
							} else if (actionType.compareTo("modify") == 0) {
						%>
						<option value='<%=i%>'
							<%if (i == Integer.parseInt(rs.getString("after_hour")))
							out.print("selected");%>><%=i%></option>
						<%
							}
								}
						%>
				</select> : <select name='after_min'>
						<%
							int ee = -1;

								if (actionType.compareTo("new") == 0) {
						%>
						<option value='0' selected>00</option>
						<option value='1'>15</option>
						<option value='2'>30</option>
						<option value='3'>45</option>

						<%
							} else if (actionType.compareTo("modify") == 0) {

									if (rs.getString("before_min").compareTo("00") == 0) {
										ee = 0;
									} else if (rs.getString("before_min").compareTo("15") == 0) {
										ee = 1;
									} else if (rs.getString("before_min").compareTo("30") == 0) {
										ee = 2;
									} else {
										ee = 3;
									}
						%>
						<option value='0' <%if (ee == 0)
						out.print("selected");%>>00</option>
						<option value='1' <%if (ee == 1)
						out.print("selected");%>>15</option>
						<option value='2' <%if (ee == 2)
						out.print("selected");%>>30</option>
						<option value='3' <%if (ee == 3)
						out.print("selected");%>>45</option>
						<%
							}
						%>

				</select></td>
			</tr>
		</table>

		<table cellpadding='0' cellspacing='0' align='center'>
			<tr>
				<td><input type='submit' value='apply' name='cal_submit' /></td>
				<td><input type='reset' value='reset' name='cal_reset' /></td>
			</tr>
		</table>

		<%
			if (actionType.compareTo("new") == 0) {
		%>
			<input type='hidden' name='dataflag' value='1' />
			
		<%
			} else if (actionType.compareTo("modify") == 0) {
		%>
			<input type='hidden' name='dataflag' value='2' />
			<input type='hidden' name='number' value='<%=num %>' />
		<%
			}
		%>
	</form>
</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
		System.out.println(e.toString());
	} finally {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}
%>