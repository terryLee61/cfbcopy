package controller.Qna;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Qna.QnaDao;

/**
 * Servlet implementation class QnaWriteAction
 */
//@WebServlet("/QnaWriteAction")
public class QnaWriteAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QnaWriteAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		  request.setCharacterEncoding("UTF-8"); // 인코딩 설정

	        // 클라이언트로부터 전송된 데이터 받기
	        String title = request.getParameter("title");
	        String author = request.getParameter("author");
	        String contents = request.getParameter("contents");

	        // 현재 시간 정보를 Timestamp 형식으로 생성
	        Timestamp regDate = new Timestamp(System.currentTimeMillis());

	        // QnaDao 객체 생성
	        QnaDao qnaDao = QnaDao.getInstance();

	        // 공지사항 추가를 위한 메서드 호출
	        boolean success = qnaDao.addQna(title, author, contents, regDate);

	        // 결과를 클라이언트에 전송
	        response.setContentType("text/html;charset=UTF-8");
	        PrintWriter out = response.getWriter();
	     // 성공 시 클라이언트에게 스크립트를 보내어 팝업 및 리다이렉션 수행
	        if (success) {
	            out.println("<script>alert('공지사항 추가 성공'); window.location.href='qna_list';</script>");
	        } else {
	            out.println("<script>alert('공지사항 추가 실패');</script>");
	        }

	        out.close();
	    }
}
