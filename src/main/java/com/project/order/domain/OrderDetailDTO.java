package com.project.order.domain;

public class OrderDetailDTO {

	private int orderDetailNum; // [2] 여기로 들어온 키가
	private int orderNum;
	private int pno; // [3] 다시 여기로 역전됨
	private int productTotalPrice;
	private int productCnt;

	// 이너 조인 값
	private String userId;
	private String productName;
	private int productPrice;

	public OrderDetailDTO() {
		
	}
	
	public OrderDetailDTO(int orderDetailNum, int orderNum, int pno, int productTotalPrice, int productCnt,
			String userId, String productName, int productPrice) {
		super();
		this.orderDetailNum = orderDetailNum;
		this.orderNum = orderNum;
		this.pno = pno;
		this.productTotalPrice = productTotalPrice;
		this.productCnt = productCnt;
		this.userId = userId;
		this.productName = productName;
		this.productPrice = productPrice;
	}

	public int getOrderDetailNum() {
		return orderDetailNum;
	}

	public void setOrderDetailNum(int orderDetailNum) {
		this.orderDetailNum = orderDetailNum;
	}

	public int getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}

	public int getPno() {
		return pno;
	}

	public void setPno(int pno) {
		this.pno = pno;
	}

	public int getProductTotalPrice() {
		return productTotalPrice;
	}

	public void setProductTotalPrice(int productTotalPrice) {
		this.productTotalPrice = productTotalPrice;
	}

	public int getProductCnt() {
		return productCnt;
	}

	public void setProductCnt(int productCnt) {
		this.productCnt = productCnt;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	@Override
	public String toString() {
		return "OrderDetailDTO [orderDetailNum=" + orderDetailNum + ", pno=" + pno + ", productTotalPrice="
				+ productTotalPrice + ", productCnt=" + productCnt + ", orderNum=" + orderNum + ", userId=" + userId
				+ ", productName=" + productName + ", productPrice=" + productPrice + "]";
	}

}
