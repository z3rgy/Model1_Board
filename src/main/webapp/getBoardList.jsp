<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 클래스 불러오기 -->
<%@ page errorPage="error.jsp"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardDO"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<%
request.setCharacterEncoding("UTF-8"); //한글
//검색 대상(제목 또는 작성자) 및 검색 텍스트 객체를 저장할 변수 설정
String searchField = ""; //검색 대상(제목 또는 작성자)
String searchText = ""; //검색 텍스트 객체 레퍼런스 변수

if (request.getParameter("searchCondition") != "" && request.getParameter("searchKeyword") != "") { //&&(and)

	searchField = request.getParameter("searchCondition");
	searchText = request.getParameter("searchKeyword");
}
//BoardDAO 클래스 객체 생성
BoardDAO boardDAO = new BoardDAO();

List<BoardDO> boardList = boardDAO.getBoardList(searchField, searchText);

request.setAttribute("boardList", boardList);

int totalList = boardList.size();
request.setAttribute("totalList", totalList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.header {
	text-align: left;
	background: #1abc9c;
	color: white;
	font-size: 30px;
}

#pp {
	background-color: #4CAF50;
	color: white;
	font-size: 30px;
}

#customers {
	font-family: Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

#customers td, #customers th {
	border: 1px solid #ddd;
	padding: 8px;
}

#customers tr:nth-child(even) {
	background-color: #f2f2f2;
}

#customers tr:hover {
	background-color: #ddd;
	align: center;
}

#customers th {
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: center;
	background-color: #4CAF50;
	color: white;
}
</style>
</head>
<body>
	<div class="header">
		<h3>${IdKey}님환영합니다.</h3>
		<a href="logout_proc.jsp">logout</a>
	</div>
	<form action="getBoardList.jsp" name="form2" method="POST">
		<p id="pp">총게시글: ${totalList}</p>
		<table id="customers">
			<tr>
				<td><select name="searchCondition" class="custom-select">
						<option value="TITLE">제목</option>
						<option value="WRITER">작성자</option>
						<option value="CONTENT">내용</option>
				</select> <input type="text" name="searchKeyword"> <input
					type="submit" value="검색"></td>
			</tr>
		</table>
		<table id="customers">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>등록일</th>
				<th>조회수</th>
			</tr>

			<c:forEach var="board" items="${boardList}">
				<tr>
				<td align="center">${board.seq}</td>
				<td align="center"><a
					href="getBoard.jsp?seq=${board.seq}">${board.title}</a></td>
				<td align="center">${board.writer}</td>
				<td align="center">${board.regDate}</td>
				<td align="center">${board.cnt}</td>
				</tr>
			</c:forEach>

			<%-- 			<%
			for (BoardDO board : boardList) {
			%>
			<tr>
				<td align="center"><%=board.getSeq()%></td>
				<td align="center"><a
					href="getBoard.jsp?seq=<%=board.getSeq()%>"><%=board.getTitle()%></a></td>
				<td align="center"><%=board.getWriter()%></td>
				<td align="center"><%=board.getRegDate()%></td>
				<td align="center"><%=board.getCnt()%></td>
			</tr>
			<%
			}
			%> --%>
		</table>
		<hr>
		<a href="insertBoard.jsp">새 게시글 등록</a> &nbsp;&nbsp;&nbsp; 
		<a href="getBoardList.jsp">전체 게시글 목록 보기</a>
	</form>
</body>
</html>