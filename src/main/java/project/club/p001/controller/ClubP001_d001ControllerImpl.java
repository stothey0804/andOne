package project.club.p001.controller;

import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import common.dao.CommonDAO;
import project.club.p001.service.ClubP001_d001Service;
import project.club.vo.ClubVO;

@Controller
public class ClubP001_d001ControllerImpl implements ClubP001_d001Controller{
	@Autowired
	ClubP001_d001Service clubP001_d001Service;
	@Autowired
	ClubVO p001_d001;
	@Autowired
	CommonDAO commonDAO;
	
	@Override      //소모임 메인페이지
	@RequestMapping(value="/club/clubMain.do",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView clubMain(HttpSession session) throws Exception{
		String m_id = (String) session.getAttribute("m_id");
		//상위 멤버수 소모임 리스트
		List<ClubVO> clubList = clubP001_d001Service.clubList();
		//나의 소모임 리스트
		List<ClubVO> myClubList = clubP001_d001Service.myClubList(m_id);
		//소모임 대표이미지 encoding
		getEncoded(clubList);
		getEncoded(myClubList);
		
		ModelAndView mav = new ModelAndView("clubMain");
		mav.addObject("clubList",clubList);
		mav.addObject("myClubList",myClubList);
		mav.addObject("myClubCnt", myClubList.size());
		return mav;
	}
	@Override	//카테고리 검색결과
	@RequestMapping(value="/club/searchClubCategory.do",method= {RequestMethod.GET})
	public ModelAndView searchClubCategory(@RequestParam(value="c_category",required = true) String c_category) throws Exception{
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_category", c_category);
		List<ClubVO> categoryClubList = clubP001_d001Service.categoryClubList(searchMap);
		String category_name = clubP001_d001Service.categoryName(searchMap);
		getEncoded(categoryClubList);
		ModelAndView mav = new ModelAndView("categorySearchList");
		mav.addObject("categoryClubList", categoryClubList);
		mav.addObject("gc_name", category_name);
		return mav;
	}
	@Override		//소모임 검색결과 페이지
	@RequestMapping(value="/club/searchClub.do",method= {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView searchClubList(@RequestParam(value="searchWord", required=false) String searchWord) throws Exception{
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("searchWord", "%"+searchWord+"%");
		List<ClubVO> list = clubP001_d001Service.searchClubList(searchMap);
		
		//소모임 대표이미지 encoding
		getEncoded(list);
		ModelAndView mav = new ModelAndView("searchList");
		mav.addObject("resultList",list);
		mav.addObject("cnt", list.size());
		mav.addObject("searchWord",searchWord); 
		return mav;
	}
	
	@Override		//소모임 상세페이지
	@RequestMapping(value="/club/detailClub.do",method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView detailClub(@RequestParam(value="c_id",required = true) String c_id, HttpSession session,HttpServletRequest request) throws Exception{
		String m_id = (String)session.getAttribute("m_id");
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_id", c_id);
		searchMap.put("m_id",m_id);
			
		ClubVO vo = clubP001_d001Service.detailClub(searchMap);
		//회원 등급 확인
		String rank = clubP001_d001Service.memberCheck(searchMap);
		
		byte[] encoded = null;
		String clubImg = "";
		//소모임 대표 이미지 encoding
		if(vo.getC_imgByte() != null) {
			encoded = Base64.getEncoder().encode(vo.getC_imgByte());
			clubImg = new String(encoded);	
		}
//		System.out.println("========"+vo.getArticleList().get(0).getArticleReplyList().get(0).getCar_content());
		//소모임 게시글 이미지 encoding
		for(int i=0; i<vo.getArticleList().size();i++) {
			if(vo.getArticleList().get(i).getArticleImgList()!=null) {
				for(int j=0; j < vo.getArticleList().get(i).getArticleImgList().size();j++) {
					if(vo.getArticleList().get(i).getArticleImgList().get(j) != null) {
						encoded = Base64.getEncoder().encode((byte[]) vo.getArticleList().get(i).getArticleImgList().get(j).getArticleImg());
						vo.getArticleList().get(i).getArticleImgList().get(j).setResultArticleImg(new String(encoded));
					}
				}
			}
			//댓글 멤버 이미지 encoding
			if(vo.getArticleList().get(i).getArticleReplyList().size()!=0) {
				for(int j=0; j < vo.getArticleList().get(i).getArticleReplyList().size();j++) {
					if(vo.getArticleList().get(i).getArticleReplyList().get(j) !=null) {
						//상위댓글
						if(vo.getArticleList().get(i).getArticleReplyList().get(j).getM_img() == null) {
						} else {
							encoded = Base64.getEncoder().encode((byte[])vo.getArticleList().get(i).getArticleReplyList().get(j).getM_img());
							vo.getArticleList().get(i).getArticleReplyList().get(j).setE_m_img(new String(encoded));
						}
						//하위댓글
						if(vo.getArticleList().get(i).getArticleReplyList().get(j).getArticleRe_replyList() != null) {
							for(int k=0 ; k < vo.getArticleList().get(i).getArticleReplyList().get(j).getArticleRe_replyList().size(); k++) {
								if(vo.getArticleList().get(i).getArticleReplyList().get(j).getArticleRe_replyList().get(k).getM_img() != null) {
									encoded = Base64.getEncoder().encode(vo.getArticleList().get(i).getArticleReplyList().get(j).getArticleRe_replyList().get(k).getM_img());
									vo.getArticleList().get(i).getArticleReplyList().get(j).getArticleRe_replyList().get(k).setE_m_img(new String(encoded));
								}
							}
						}
						
					}
				}
			}
			//게시글 멤버 이미지 encoding
			if(vo.getArticleList().get(i).getUserImg()!=null) {
				encoded = Base64.getEncoder().encode(vo.getArticleList().get(i).getUserImg());
				vo.getArticleList().get(i).setResultUserImg(new String(encoded));
			}
		}
	
		//운영진 목록
//		List<ClubMemberVO> leader = clubP001_d001Service.getLeaderMember(searchMap);
		//일반 회원 목록
//		List<ClubMemberVO> members = clubP001_d001Service.getClubMember(searchMap);
		//회원 목록 이미지 encoding
//		Common.getEncodedUser(members);
//		Common.getEncodedUser(leader);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName(Common.checkLoginDestinationView("detailClub", request));
		mav.addObject("clubInfo", vo);
		mav.addObject("rank", rank);
		mav.addObject("clubImg",clubImg);
//		mav.addObject("members", members);
//		mav.addObject("leader", leader);
		return mav;
	}
	
	//article encoding method
	public void getEncoded(List<ClubVO> list) {
		byte[] encoded = null;
		if(list!=null) {
			for(int i=0; i < list.size();i++) {
				if(list.get(i).getC_imgByte() != null) {
					encoded = Base64.getEncoder().encode(list.get(i).getC_imgByte());
					list.get(i).setResultImg(new String(encoded));	
				}
			}
		}
	}

}
