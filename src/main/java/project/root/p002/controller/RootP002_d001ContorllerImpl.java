package project.root.p002.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import common.Pagination;
import project.root.p002.service.RootP002_d001Service;
import project.root.p002.vo.RootP002VO;

@Controller
public class RootP002_d001ContorllerImpl implements RootP002_d001Controller{
	
	@Autowired
	private RootP002_d001Service rootP002_d001Service;
	
	@RequestMapping("searchMain.do")
	public String searchMain() {
		return "p002_d001_searchMain";
	}
	
	@RequestMapping("fullSearch.do")
	public String fullSearch(@RequestParam(defaultValue="") String searchKeyword, Model model) {
		//where절에 쓸 objectID 배열 생성
		List<String> notice = new ArrayList<>();
		List<String> and_one = new ArrayList<>();
		List<String> shop = new ArrayList<>();
		List<String> c_article = new ArrayList<>();
		List<String> club = new ArrayList<>();
		
		//검색 후 조회된 데이터를 사용하여 배열에 값 할당
		List<RootP002VO> voList = rootP002_d001Service.fullSearch(searchKeyword);
		for(int i=0; i<voList.size(); i++) {
			switch(voList.get(i).getTableName()) {
			case "NOTICE" : notice.add(voList.get(i).getObjectId()); break;
			case "AND_ONE" : and_one.add(voList.get(i).getObjectId()); break;
			case "SHOP" : shop.add(voList.get(i).getObjectId()); break;
			case "C_ARTICLE" : c_article.add(voList.get(i).getObjectId()); break;
			case "CLUB" : club.add(voList.get(i).getObjectId()); break;
			}
		}
		
		//view단으로 보낼 최종 리절트 맵
		Map<String,Object> searchResult = new HashMap<>();
		//검색조건 맵
		Map<String,Object> searchParam = new HashMap<>();
		//앞서 생성한 배열을 이용하여 실제 데이터 조회 후 결과 리스트를 리절트맵에 put
		if(notice.size()!=0) {
			searchParam.put("selectName","N_ID, N_TITLE, N_CONTENT, N_DATE");
			searchParam.put("tableName", "NOTICE");
			searchParam.put("columnName","N_ID");
			searchParam.put("idList",notice);
			List<Map<String,String>> noticeResultList = rootP002_d001Service.getObject(searchParam);
			searchResult.put("noticeList", noticeResultList);
			searchParam.clear();
		}
		if(and_one.size()!=0) {
			searchParam.put("selectName","ONE_TYPE, ONE_ID, ONE_CATEGORY, ONE_TITLE, ONE_LOCATE_LAT, ONE_LOCATE_LNG, ONE_TIME, ONE_MEMBERMAX, ONE_DATE, ONE_STATE, ONE_HASHTAG, ONE_CONTENT, ONE_ADDR");
			searchParam.put("tableName", "AND_ONE");
			searchParam.put("columnName","ONE_ID");
			searchParam.put("idList",and_one);
			List<Map<String,String>> and_oneResultList = rootP002_d001Service.getObject(searchParam);
			searchResult.put("and_oneList", and_oneResultList);
			searchParam.clear();
		}
		if(shop.size()!=0) {
			searchParam.put("selectName","S_ID, S_CATEGORY, S_NAME, S_SCORE, S_CONTENT, S_PHONENUMBER, S_HASHTAG, S_LOCATE_LAT, S_LOCATE_LNG");
			searchParam.put("tableName", "SHOP");
			searchParam.put("columnName","S_ID");
			searchParam.put("idList",shop);
			List<Map<String,String>> shopResultList = rootP002_d001Service.getObject(searchParam);
			searchResult.put("shopList", shopResultList);
			searchParam.clear();
		}
		if(c_article.size()!=0) {
			searchParam.put("selectName","CA_ID, CA_CONTENT, C_ID, CA_DATE, M_ID, CA_IMG, CA_PIN");
			searchParam.put("tableName", "C_ARTICLE");
			searchParam.put("columnName","CA_ID");
			searchParam.put("idList",c_article);
			List<Map<String,String>> c_articleResultList = rootP002_d001Service.getObject(searchParam);
			searchResult.put("c_articleList", c_articleResultList);
			searchParam.clear();
		}
		if(club.size()!=0) {
			searchParam.put("selectName","C_ID, C_NAME, C_CONTENT, C_OPENINGDATE, C_HASHTAG, C_MEMBERCNT, C_MEMBERMAX, C_CATEGORY");
			searchParam.put("tableName", "CLUB");
			searchParam.put("columnName","C_ID");
			searchParam.put("idList",club);
			List<Map<String,String>> clubResultList = rootP002_d001Service.getObject(searchParam);
			searchResult.put("clubList", clubResultList);
			searchParam.clear();
		}
		
		//표시되지 않은 결과까지 포함한 총 결과 수를 추출하여 리절트맵에 put
		List<Map<String,String>> listCntList = rootP002_d001Service.getSearchCnt(searchKeyword);
		for(int i=0; i<listCntList.size(); i++) {
			switch(listCntList.get(i).get("TABLENAME")) {
			case "NOTICE" : searchResult.put("noticeCnt", listCntList.get(i).get("RESULTCOUNT")); break;
			case "AND_ONE" : searchResult.put("and_oneCnt", listCntList.get(i).get("RESULTCOUNT")); break;
			case "SHOP" : searchResult.put("shopCnt", listCntList.get(i).get("RESULTCOUNT")); break;
			case "C_ARTICLE" : searchResult.put("c_articleCnt", listCntList.get(i).get("RESULTCOUNT")); break;
			case "CLUB" : searchResult.put("clubCnt", listCntList.get(i).get("RESULTCOUNT")); break;
			}
		}
		
		model.addAttribute("searchResult",searchResult);
		model.addAttribute("searchKeyword",searchKeyword);
		
		return "p002_d001_fullSearch"; // toDo - viewName으로 수정
	}
	
	@RequestMapping("searchDetail.do")
	public String searchDetail(@RequestParam(defaultValue="") String searchKeyword, 
			@RequestParam(defaultValue="") String tableName, 
			@RequestParam(defaultValue="1")int curPage, Model model) {
		//페이징을 위해 listCnt 추출
		List<Map<String,String>> listCntList = rootP002_d001Service.getSearchCnt(searchKeyword);
		int listCnt = 0;
		for(int i=0; i<listCntList.size(); i++) {
			if(tableName.equals(listCntList.get(i).get("TABLENAME"))) {
				String _listCnt = String.valueOf(listCntList.get(i).get("RESULTCOUNT"));
				listCnt = Integer.parseInt(_listCnt);
			}
		}
		//페이지네이션 세팅 및 쿼리 검색
		Pagination pagination = new Pagination(listCnt, curPage);
		Map<String,String> searchParam = new HashMap<>();
		searchParam.put("tableName",tableName);
		searchParam.put("searchKeyword",searchKeyword);
		searchParam.put("startIndex",(pagination.getStartIndex()+1)+"");
		searchParam.put("endIndex",(pagination.getStartIndex()+pagination.getPageSize())+"");
		
		//view단에 attribute
		List<Map<String,String>> resultList = rootP002_d001Service.searchDetail(searchParam);
		model.addAttribute("pagination",pagination);
		model.addAttribute("resultList",resultList);
		model.addAttribute("searchKeyword",searchKeyword);
		model.addAttribute("tableName",tableName);
		
		return "p002_d001_searchDetail"; // toDo - viewName으로 수정
	}
}
