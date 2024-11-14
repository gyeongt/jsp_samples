package util;

public class BbsUtil {
	
	//제목이 너무 긴 경우...으로 처리하는 함수
	public static String titleDot(String title) {
		String newTitle;
		
		if(title.length() > 50) {
			newTitle = title.substring(0, 50);
			newTitle += "...";
		}else {
			newTitle = title.trim();
		}
		
		return newTitle;
	}
	
	// 답글의 화살표 함수
	public static String arrow(int depth) {
		String img = "<img src='./arrow1.png' width='15px' height='15px' />";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
		
		String ts = "";
		for(int i = 0; i < depth; i++) {
			ts += nbsp;
		}
	
	return depth==0?"":ts + img;
	}
}
