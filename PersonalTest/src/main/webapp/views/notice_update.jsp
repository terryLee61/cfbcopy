<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
String sessionUserId = (String) session.getAttribute("log");
String url = "jdbc:mysql://localhost:3306/personal";
String username = "root";
String password = "my1234";
String notice_id = request.getParameter("id");

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, username, password);

    String sql = "SELECT * FROM notice WHERE notice_idx = ?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, notice_id);

    ResultSet rs = pstmt.executeQuery();
    boolean hasNotice = rs.next();

    if (hasNotice) {
        String author = rs.getString("author");
        
        if (sessionUserId == null || !sessionUserId.equals(author)) {
            // 작성자가 아닌 경우, 혹은 로그인하지 않은 경우
            response.sendRedirect("notice_list");
        } else {
            // 작성자인 경우, 수정 가능한 폼 표시
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항_상세</title>
    <link rel="stylesheet" href="resources/style/notice.css">
</head>
<body>
    <div class="wrap">
        <!-- header 시작 -->
        <jsp:include page="header_form"></jsp:include>
        <!-- header 끝 -->

        <section id="wrap">
            <div class="contents_wrap">
                <div class="main_contents">
                    <div id="noticeBody">
<%
                    if (hasNotice) {
%>
                        <div class="detail_con">
                            <form method="post" action="NoticeUpdate">
                                <p class="idx_p">번호: <input type="text" name="notice_idx" value="<%= rs.getInt("notice_idx") %>" readonly ></p>
                                제목: <input type="text" name="title" value="<%= rs.getString("title") %>"><br>
                                글쓴이: <%= rs.getString("author") %><br>
                                내용: <input type="text" name="contents" value="<%= rs.getString("contents") %>"><br>
                                날짜: <%= rs.getString("reg_date") %><br>
                                <input type="submit" value="수정하기">
                            </form>
                        </div>
<%
                    } else {
%>
                        <div>
                            해당하는 공지사항이 없습니다.
                        </div>
<%
                    }
                }
            } else {
%>
            <div>
                해당하는 공지사항이 없습니다.
            </div>
<%
        }

    rs.close();
    pstmt.close();
    conn.close();
} catch (Exception e) {
    out.println("Exception: " + e.getMessage());
    e.printStackTrace();
}
%>
                    </div>
                </div>
            </div>
        </section>

        <!-- footer 시작 -->
        <jsp:include page="footer"></jsp:include>
        <!-- footer 끝 -->
    </div>
</body>
</html>
