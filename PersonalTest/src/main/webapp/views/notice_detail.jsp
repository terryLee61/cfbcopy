<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>공지사항_상세</title>
    </head>

    <link rel="stylesheet" href="resources/style/notice.css">

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
// 데이터베이스 연결 정보
String url = "jdbc:mysql://localhost:3306/personal";
		String username = "root";
		String password = "my1234";

// notice_idx 값 가져오기
String notice_id = request.getParameter("id");

// 데이터베이스 연결 및 쿼리 실행
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, username, password);

    String sql = "SELECT * FROM notice WHERE notice_idx = ?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, notice_id);

    ResultSet rs = pstmt.executeQuery();

    if (rs.next()) {
        out.println("Notice ID: " + rs.getInt("notice_idx") + "<br>");
        out.println("Title: " + rs.getString("title") + "<br>");
        out.println("Author: " + rs.getString("author") + "<br>");
        out.println("Contents: " + rs.getString("contents") + "<br>");
        out.println("Date: " + rs.getString("reg_date") + "<br>");
    } else {
        out.println("해당하는 공지사항이 없습니다.");
    }

    // 리소스 정리
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
                <!-- <script>
                    window.onload = function () {
                        loadNotices();
                    };
            
                    function loadNotices() {
                        var xhttp = new XMLHttpRequest();
                        xhttp.onreadystatechange = function () {
                            if (this.readyState == 4 && this.status == 200) {
                                var notices = JSON.parse(this.responseText);
                                displayNotices(notices);
                            }
                        };
                        xhttp.open("GET", "NoticeDetail", true);
                        xhttp.send();
                    }
            
                    function displayNotices(notices) {
                        var noticeBody = document.getElementById("noticeBody");
            
                        notices.forEach(function (notice) {
                            var div = document.createElement("div");
                            div.classList.add("notice");
            
                            var title = document.createElement("h2");
                            title.textContent = notice.title;
            
                            var contents = document.createElement("p");
                            contents.textContent = notice.contents;
            
                            var author = document.createElement("p");
                            author.textContent = "작성자: " + notice.author;
            
                            var regDate = document.createElement("p");
                            regDate.textContent = "작성일: " + notice.reg_date;
            
                            div.appendChild(title);
                            div.appendChild(contents);
                            div.appendChild(author);
                            div.appendChild(regDate);
            
                            noticeBody.appendChild(div);
                        });
                    }
                </script> -->
            </section>

            <!-- footer 시작 -->
            <jsp:include page="footer"></jsp:include>
            <!-- footer 끝 -->

        </div>
    </body>

    </html>