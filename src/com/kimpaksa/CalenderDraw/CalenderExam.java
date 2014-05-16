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
		
		//�����-1�� ���� �� �ϼ� ���
		for(int i=1; i <= month-1; i++){
			total += this.getDay(i, year);
		}

		//������
		total  += day;
	}
	
	/*
	 * 1�� : 31��
	 * 2�� : 28 or 29��
	 * 3�� : 31��
	 * 4�� : 30��
	 * 5�� : 31��
	 * 6�� : 30
	 * 7�� : 31
	 * 8�� : 31
	 * 9�� : 30
	 * 10�� : 31
	 * 11�� : 30
	 * 12�� : 31
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
	
	/* �ش� ���� 1���� ������������ �����Ѵ�. */
	public int getOneDay(int month, int day, int total ) {
		int temp = total;
		temp -= (day-1);
		return temp % 7;
	}
	
	public void drawCalender()
	{
		int oneDay=0;			//
		int f=0;				// 
		boolean flag = true;	// ù��° �ֿ� ���� Flag
		
		//��, �� ����
		System.out.println(year + "." + month + " Calender" + "\n");
		
		//���� ����
		for (int idx = 0; idx < arr.size(); idx++)	System.out.print(arr.get(idx) + "\t");
		System.out.println();
		
		//�ش� ���� 1���� ������������ �����Ѵ�.
		oneDay = this.getOneDay(month,day,total);
		
		//�޷� �׸���
		for(int i=0; i < 6;  i++ ){
			//ù��° �ֿ� ���ؼ� �׷��ش�.
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
			//�߰��߰��� 28 or 29 or 30 or 31 �ľ��Ѵ�. 
			if(f >= getDay(month, year)) break;
			/* ������ �Ͽ� ���ؼ� �׷��ش�. */
			
			for (int s = 0; s < 7; s++) {
				//������ 20���̶�� 20�� *ǥ�ø� ���ش�.
				if (f == day-1){System.out.print("*");}
				//���� �׸���.
				System.out.print(++f + "\t");
				//���� 28 or 29 or 30 or 31�� �ʰ����� �ʴ´�.
				if(f >= getDay(month, year)) break;
			}
			System.out.println();
		}
	}
}
