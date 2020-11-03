package project.root.p004.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.util.NewBeanInstanceStrategy;
import project.root.p004.service.RootP004_d001Service;


/*
 * @Title	어드민 - 통계
 * @Author 	김세영
 * @Date	2020.11.02.
 * 
 * */

@Controller
@RequestMapping("/admin")
public class RootP004_d001ControllerImpl implements RootP004_d001Controller{

	@Autowired
	RootP004_d001Service rootP004_d001Service;
	
	// 회원통계페이지 연결
	@RequestMapping("/memberChart.do")
	public ModelAndView memberChartInit() {
		ModelAndView mav = new ModelAndView("RootP004_d001_init");
		mav.addObject("gender", rootP004_d001Service.selectMemberGenderChart());
		mav.addObject("ages", rootP004_d001Service.selectMemberAgeChart());
		// &분의일 회원 참가 비율
		mav.addObject("andgf",(searchParamSet("gender", "20")));	//여자 
		mav.addObject("andgm",(searchParamSet("gender", "10"))); 	//남자
		mav.addObject("anda10",(searchParamSet("age", "10"))); 	//10대
		mav.addObject("anda20",(searchParamSet("age", "20"))); 	//20대
		mav.addObject("anda30",(searchParamSet("age", "30"))); 	//20대
		mav.addObject("anda40",(searchParamSet("age", "40"))); 	//40대
		mav.addObject("anda50",(searchParamSet("age", "50"))); 	//50대
		// &분의일 점유율 통계
		mav.addObject("totalAndSet",separateChartList(rootP004_d001Service.selectTotalAndOneTypeChart(), "one_type", "result"));
		mav.addObject("eatCategory",separateChartList(rootP004_d001Service.selectCategoryAndOne("010"), "category", "total"));
		mav.addObject("buyCategory",separateChartList(rootP004_d001Service.selectCategoryAndOne("011"), "category", "total"));
		mav.addObject("actCategory",separateChartList(rootP004_d001Service.selectCategoryAndOne("012"), "category", "total"));
		return mav;
	}
	
	private Map<String, String> searchParamSet(String flagParam, String param){
		Map<String, String> searchParam = new HashMap<String, String>();
		searchParam.put("flag",flagParam);
		searchParam.put("param", param);
		List<Map<String, String>> selectList = rootP004_d001Service.selectAndOneChart(searchParam);
		Map<String, String> resultMap = new HashMap<String, String>();
		for(Map<String, String>i : selectList) {
			resultMap.put("one"+String.valueOf(i.get("one_type")), String.valueOf(i.get("result")));
		}
		return resultMap;		
	}
	
	// 라벨, 값 분리 저장
	private Map<String, Object> separateChartList(List<Map<String, String>> list, String key, String value) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<String> labels = new ArrayList<String>();
		List<String> data = new ArrayList<String>();
		// list 저장값 분리
		for(Map iter: list) {
			labels.add("'"+String.valueOf(iter.get(key))+"'");
			data.add("'"+String.valueOf(iter.get(value))+"'");
		}
		resultMap.put("labels",labels);
		resultMap.put("data",data);
		return resultMap;
	}
	

	
}
