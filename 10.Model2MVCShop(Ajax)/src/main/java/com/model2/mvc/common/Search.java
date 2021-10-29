package com.model2.mvc.common;


//==>����Ʈȭ���� �𵨸�(�߻�ȭ/ĸ��ȭ)�� Bean 
public class Search {
	
	///Field
	private int currentPage;
	private String searchCondition;
	private String searchKeyword;
	private int pageSize;
	//==> ����Ʈȭ�� currentPage�� �ش��ϴ� ȸ�������� ROWNUM ��� SELECT ���� �߰��� Field 
	//==> UserMapper.xml �� 
	//==> <select  id="getUserList"  parameterType="search"	resultMap="userSelectMap">
	//==> ����
	private int endRowNum;
	private int startRowNum;
	//0929 �߰�
	private String orderColurm;//="p.prod_no"; // order �� �÷�
	private String orderKey; // desc or asc 
		//0930 �߰�
	private String tranStatusCode;
		
		
	///Constructor
	public Search() {
	}
	
	///Method
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int paseSize) {
		this.pageSize = paseSize;
	}
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	//==> Select Query �� ROWNUM ������ �� 
	public int getEndRowNum() {
		return getCurrentPage()*getPageSize();
	}
	//==> Select Query �� ROWNUM ���� ��
	public int getStartRowNum() {
		return (getCurrentPage()-1)*getPageSize()+1;
	}

	
	
	 //

	public String getOrderColurm() {
		return orderColurm;
	}

	public String getOrderKey() {
		return orderKey;
	}

	public String getTranStatusCode() {
		return tranStatusCode;
		}



	public void setTranStatusCode(String tranStatusCode) {
		this.tranStatusCode = tranStatusCode;
	}



	public void setOrderColurm(String orderColurm) {
		this.orderColurm = orderColurm;
	}

	public void setOrderKey(String orderKey) {
		this.orderKey = orderKey;
	}
	
	@Override
	public String toString() {
		return "Search [currentPage=" + currentPage + ", searchCondition="
				+ searchCondition + ", searchKeyword=" + searchKeyword
				+ ", pageSize=" + pageSize + ", endRowNum=" + endRowNum
				+ ", startRowNum=" + startRowNum + "], tranStatusCode"+tranStatusCode+"OrderColurm"+orderColurm+"OrderKey"+orderKey;
	}
}