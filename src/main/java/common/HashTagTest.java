package common;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HashTagTest {
	public static void main(String[] args) {
		String hashTagOfShop1 = "#치킨#맛집#치느님#가성비";
		String hashTagOfShop2 = "#족발#맛집#치킨#티비나온집";
		String hashTagOfShop3 = "#치킨#맛집#감성#로켓배달";
		String hashTagOfShop4 = "#맛집#냉면#인스타맛집#가성비";
		String hashTagOfShop5 = "#치킨#피자#맛집";
		String hashTagOfShop6 = "#치킨#맛집#리뷰이벤트#가성비";
		
		/*
		 * 각각의 객체들(가게, 같이하기 등)은 DB상 해시태그 컬럼에 #으로 구분된 문자열이 저장되어 있음.
		 * 테스트를 위해 6개의 가게가 있다 가정하고 직접 해시태그를 입력함.
		 * */
		
		List<String> shopList = new ArrayList<>();
		
		shopList.add(hashTagOfShop1);
		shopList.add(hashTagOfShop2);
		shopList.add(hashTagOfShop3);
		shopList.add(hashTagOfShop4);
		shopList.add(hashTagOfShop5);
		shopList.add(hashTagOfShop6);
		
		/*
		 * 읽어온 정보들을 모두 리스트에 담아준다. 
		 * DAO에서 selectList 를 사용해 SELECT HASHTAG FROM SHOP을 통해 데이터를 읽으면 같은 모양새가 될 것.
		 * */
		
		
		Map<String,Integer> hashTag = new HashMap<>();
		
		/*
		 * 해시태그 정보가 저장될 맵을 선언.
		 * Key는 해시태그 이름이고 Value는 카운트 횟수로 사용할 것.
		 * */
		
		for(int i=0; i<shopList.size(); i++) {
			String[] parser = shopList.get(i).split("#");
			for(int j=0; j<parser.length; j++) {
				if(parser[j].equals("")) {
					continue;
				}else {
					if(hashTag.containsKey(parser[j])) {
						int value = (int)hashTag.get(parser[j]);
						value++;
						hashTag.replace(parser[j], value);
					}else {
						hashTag.put(parser[j], 1);
					}
				}
			}
		}
		/*
		 * 먼저 String.split 메소드를 통해 #을 기준으로 문자열을 잘라준 후 배열에 넣는다.
		 * 이후 배열의 길이만큼 for문을 돌리는데, 만약 해시맵에 이미 key값(자른 문자열 예:치킨)이 들어있다면
		 * value를 불러와 1 늘려준 후 다시 넣어준다.
		 * 들어있지 않다면 value를 1로 설정하여 새로 put 해준다.
		 * 이것을 shopList 리스트의 길이만큼(가게 수 만큼) 반복한다.
		 * 공백이 파싱되어 카운트되는 경우를 해결하기 위해 공백 체크 후 continue하는 코드를 삽입했다.
		 * */
		
		List<String> keySetList = new ArrayList<>(hashTag.keySet());
		/*
		 * value값 기준 정렬을 위해 hashTag 맵의 Key값들을 keySetList 리스트에 넣어준다.(map.keySet() 메소드 사용)
		 * */
		
		System.out.println("======> 정렬 전 입력된 값 확인");
		for(int i=0; i<keySetList.size(); i++) {
			System.out.println("해시태그 : #" + keySetList.get(i) + "  /  횟수 : " + hashTag.get(keySetList.get(i)));
		}
		// 단순한 로깅용 printout for문
		
		Collections.sort(keySetList, (o1, o2) -> (hashTag.get(o2).compareTo(hashTag.get(o1))));
		/*
		 * 컬렉션 클래스의 sort를 사용하여 keySetList 리스트의 순서를 정렬한다.
		 * hashTag 맵의 데이터를 직접 건드리는게 아님.
		 * */
		
		
		System.out.println("======> 정렬 후 입력된 값 확인");
		for(int i=0; i<keySetList.size(); i++) {
			System.out.println("해시태그 : #" + keySetList.get(i) + "  /  횟수 : " + hashTag.get(keySetList.get(i)));
		}
		// keySetList가 정렬되었기에 내림차순으로 hashTag 맵의 데이터를 출력할 수 있게 되었다.
		
		System.out.println("======>상위 3개 해시태그만 printout");
		for(int i=0; i<3; i++) {
			System.out.println("#"+keySetList.get(i));
		}
		//이제 이 데이터들을 List에 담든 하나씩 attribute 하든 model을 통해 view단으로 보낼 수 있게 되었다.
	}
}
