package com.project.board.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.board.domain.BoardDTO;
import com.project.board.domain.BoardReplyDTO;
import com.project.board.domain.PageIngredient;
import com.project.board.service.BoardService;
import com.project.board.service.ReplyService;
import com.project.member.domain.MemberDTO;

@Controller
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService boardService;

	@Autowired
	private ReplyService replyService;
	
	// 공지사항 출력 + 페이징 + 검색
	@RequestMapping(value = "/announcement/announcement", method = RequestMethod.GET)
	public void adminBoardList(@RequestParam("pageNum") int pageNum,
			@RequestParam(value = "searchType", required = false, defaultValue = "title") String searchType,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			PageIngredient page, Model model) throws Exception {

		logger.info("공지사항 페이징 + 검색기능 시작 (Controller)\n검색타입 : {}\n검색어 : {}", searchType, keyword);
		
		// 파라미터 순서 int contentNum , int maxPageNum, int selectContent
		page = new PageIngredient(10,10);
		
		page.setPageNum(pageNum);
		page.setSearchType(searchType);
		page.setKeyword(keyword);
		page.setSearchTypeAndKeyword(searchType, keyword);

		// 게시글 총 갯수를 구한다. 단 검색타입과 키워드에 맞춘 결과에 대한 총 갯수를 출력해야한다.
		page.setTotalContent(boardService.totalSearchContent(searchType, keyword));

		List<BoardDTO> adminBoardList = null;
		adminBoardList = boardService.adminBoardList(
				page.getStartContentNum(), 
				page.getContentNum(), 
				searchType, keyword);
		
		model.addAttribute("adminBoardList", adminBoardList);
		model.addAttribute("page", page);
		
		logger.info("페이징 정보 : {}",page.toString());

		// 현재 페이지가 몇페이지인지 쉽게 구분하기위한 페이지 구분자를 넘김.
		model.addAttribute("selectedPageNum", pageNum);
	}

	// 작성 페이지 접속
	@RequestMapping(value = "/admin/boardWritePage", method = RequestMethod.GET)
	public void connectMemberBoardWrite() throws Exception {

		logger.info("회원 게시글 작성 페이지 접속 memberBoardWrite - controller");

	}

	// 게시글 등록하기
	@RequestMapping(value = "/admin/boardWrite", method = RequestMethod.POST)
	public String boardWrite(BoardDTO boardDTO, HttpSession session) throws Exception {

		logger.info("회원 게시글 작성 memberBoardWrite - controller");

		// 타입검사
		logger.info("타입검사 결과 : {}", session.getAttribute("memberInfo") instanceof Object);

		MemberDTO memberInfo = (MemberDTO) session.getAttribute("memberInfo");

		if (memberInfo != null) {

			if (memberInfo.getUserVerify() == 128) {
				boardDTO.setBoardLevel(1);
				boardService.boardWrite(boardDTO);

			} else {
				boardDTO.setBoardLevel(0);
				boardService.boardWrite(boardDTO);

			}

		} else {
			boardDTO.setBoardLevel(-1);
			boardService.boardWrite(boardDTO);

		}

		return "redirect:/admin/announcement?pageNum=1";
	}

	// 공지 삭제하기
	@ResponseBody
	@RequestMapping(value = "/admin/boardDelete", method = RequestMethod.POST)
	public void boardDelete(@RequestParam("bno") int bno) throws Exception {

		logger.info("회원 게시글 삭제 memberBoardDelete - BoardController");

		boardService.boardDelete(bno);

	}

	// 게시글 조회, 댓글보기
	@RequestMapping(value = "/admin/boardView", method = RequestMethod.GET)
	public void boardView(@RequestParam("bno") int bno, Model model, BoardDTO boardDTO, PageIngredient page) throws Exception {

		logger.info("회원 게시글 조회 boardView - BoardController");

		boardDTO = boardService.boardView(bno);

		// 댓글 가져오기
		List<BoardReplyDTO> boardReplyDTO = replyService.replyList(bno);
		logger.info("댓글 가져오기 boardView 에서 동시조회 후 계층형으로 - BoardController");

		model.addAttribute("boardDTO", boardDTO);

		model.addAttribute("replyDTO", boardReplyDTO);

	}

	// 게시글 수정하기 (의 개념으로 수정페이지 들어가기)
	@RequestMapping(value = "/admin/boardModifyPage", method = RequestMethod.GET)
	public void connectBoardModify(@RequestParam("bno") int bno, Model model, BoardDTO boardDTO) throws Exception {

		logger.info("게시글 수정 페이지 접속 connectBoardModify - controller");

		boardDTO = boardService.boardView(bno);

		model.addAttribute("boardDTO", boardDTO);
	}

	// 게시글 수정하기 로직
	@RequestMapping(value = "/admin/boardModify", method = RequestMethod.POST)
	public String boardModify(BoardDTO boardDTO) throws Exception {

		logger.info("게시글 수정 로직 실행 boardModify - controller");

		boardService.boardModify(boardDTO);

		return "redirect:/admin/boardView?bno=" + boardDTO.getBno();
	}

}
