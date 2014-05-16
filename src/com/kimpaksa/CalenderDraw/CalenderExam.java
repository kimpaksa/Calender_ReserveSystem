package com.kimpaksa.CalenderDraw;

import java.util.*;

public class CalenderExam{
	public int year;
	public int month;
	public int day;
	public int total;
	public ArrayList<String> arr;
	
	public CalenderExam(int y, int m, int d) {
		year = y;
		month = m;
		day = d;
		total = 365 * (year-1) + ( (year-1)/4) - ((year-1) /100) +((year-1) /400);	
		
		arr = new ArrayList();
		
		arr.add("SUN");
		arr.add("MON");
		arr.add("TUE");
		arr.add("WED");
		arr.add("THU");
		arr.add("FRI");
		arr.add("SAT");	
		
		//현재월-1월 까지 총 일수 계산
		for(int i=1; i <= month-1; i++){
			total += this.getDay(i, year);
		}

		//현재일
		total  += day;
	}
	
	/*
	 * 1월 : 31일
	 * 2월 : 28 or 29일
	 * 3월 : 31일
	 * 4월 : 30일
	 * 5월 : 31일
	 * 6월 : 30
	 * 7월 : 31
	 * 8월 : 31
	 * 9월 : 30
	 * 10월 : 31
	 * 11월 : 30
	 * 12월 : 31
	 */
	
	public int getDay(int month, int year){
		switch(month){
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
		case 2:
			if(year % 4 == 0)
				return 29;
			else 
				return 28;	
		}
		return 30;
	}
	
	/* 해당 달의 1일이 무슨요일인지 추출한다. */
	public int getOneDay(int month, int day, int total ) {
		int temp = total;
		temp -= (day-1);
		return temp % 7;
	}
	
	public void drawCalender()
	{
		int oneDay=0;			//
		int f=0;				// 
		boolean flag = true;	// 첫번째 주에 대한 Flag
		
		//년, 월 적기
		System.out.println(year + "." + month + " Calender" + "\n");
		
		//요일 적기
		for (int idx = 0; idx < arr.size(); idx++)	System.out.print(arr.get(idx) + "\t");
		System.out.println();
		
		//해당 달의 1일이 무슨요일인지 추출한다.
		oneDay = this.getOneDay(month,day,total);
		
		//달력 그리기
		for(int i=0; i < 6;  i++ ){
			//첫번째 주에 대해서 그려준다.
			if(flag == true){
				for (int s = 0; s < 7; s++) {
					if( s >= oneDay ) {
						if (f == day-1){System.out.print("*");}
						System.out.print(++f + "\t");
					} else {
						System.out.print("\t");
					}
				}
				System.out.println();
				flag = false;
			}
			//중간중간에 28 or 29 or 30 or 31 파악한다. 
			if(f >= getDay(month, year)) break;
			/* 나머지 일에 대해서 그려준다. */
			
			for (int s = 0; s < 7; s++) {
				//오늘이 20일이라면 20에 *표시를 해준다.
				if (f == day-1){System.out.print("*");}
				//일을 그린다.
				System.out.print(++f + "\t");
				//일이 28 or 29 or 30 or 31를 초과하지 않는다.
				if(f >= getDay(month, year)) break;
			}
			System.out.println();
		}
	}
}
