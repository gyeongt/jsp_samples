package util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import dto.CalendarDto;

public class CalendarUtil {
	
	//문자열 검사 : 빈 문자열 -> true
	public static boolean nvl(String msg) {
		return msg == null || msg.trim().equals("")?true:false;
	}
	
	// 한자리 숫자를 두자리로 만들어주는 함수 1 ~ 9 -> 01 ~ 09 로 바꿔주는 함수
	public static String two(String msg) {
		return msg.trim().length()<2? "0" + msg.trim() : msg.trim();
	}
	
	// 앞에 0이 있는 문자열을 한자리 문자로 변환 08 -> 8
	public static String one(String msg) {
		return msg.charAt(0)=='0'?msg.charAt(1)+"":msg;
	}
	
	//일별 일정을 모두 볼 수 있는 caldaylist.jsp로 이동되도록 하는 함수(날짜표시)
	public static String daylist(int year, int month, int day) {
		String str = "";
		
		str += String.format("&nbsp;<a href='caldaylist.jsp?year=%d&month=%d&day=%d' style='color:#546E7A'><b>",
															year, month, day);
		str += String.format("%2d", day);
		str += "</b></a>";
		
		return str;
	}
	
	//일정추가
	public static String calwrite(int year, int month, int day) {
		String str= "";
		
		String img = "<img src='./images/pen2.png' width='18px' height='18px' title='일정추가'>";
		
		str = String.format("<a href='calwrite.jsp?year=%d&month=%d&day=%d'>%s</a>",
														year, month, day, img);
		
		return str;
	}
	
	// 제목이 길 경우...으로 처리
	public static String dot3(String msg) {
		String str = "";
		
		if(msg.length() >= 10) {
			str = msg.substring(0, 10);
			str += "...";
		}else {
			str = msg.trim();
		}
		return str;
	}
	
	//날짜별로 테이블을 생성하기 위한 함수
	public static String makeTable(int year, int month, int day, List<CalendarDto> list) {
		String str = "";
		
		// 2023 7 5 -> 20230705		202307051015 <- rdate
		String dates = (year + "") + two(month + "") + two(day + "");
		
		str += "<table>";		
		for(CalendarDto dto : list) {
			if(dto.getRdate().substring(0, 8).equals(dates)) {
				str += "<tr>";
				str += "	<td style='padding:0px'>";
				str += "		<a href='caldetail.jsp?seq=" + dto.getSeq() + "'>";				
				str	+= "			<font style='font-size:10px;color:blue'>";
				str += 					dot3( dto.getTitle() );
				str += "			</font>";	
				str += "		</a>";		
				str += "	</td>";
				str += "</tr>";
			}			
		}				
		str += "</table>";		
		return str;
	}
	
	// 202307051029 -> 2023-07-05-10:29
	// 날짜와 시간을 유저가 보기 편하도록 설정하는 함수
public static String toDates(String mdate) {
		
		// 날짜형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");
		
		String s = 		mdate.substring(0, 4) + "-"		// yyyy
					+ 	mdate.substring(4, 6) + "-"		// MM
					+ 	mdate.substring(6, 8) + " "		// dd
					+	mdate.substring(8, 10) + ":"	// hh
					+	mdate.substring(10) + ":00";	// mm:ss
		Timestamp d = Timestamp.valueOf(s);
		
		return sdf.format(d);
	}
	
	
}
