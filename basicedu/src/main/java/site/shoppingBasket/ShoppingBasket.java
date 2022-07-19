package site.shoppingBasket;

import java.util.List;

import site.mypage.product.Product;

public class ShoppingBasket extends Product {

	int shoppingBasketNo;
	int productNo;
	String id;
	int quantity;
	String productPrice;

	List<Integer> shoppingBasketNoList = null;
	String[] shoppingBasketNoArr = null;

	String productStatus; // soldOut : 매진, update : 가격/수량 변동

	public int getShoppingBasketNo() {
		return shoppingBasketNo;
	}
	public void setShoppingBasketNo(int shoppingBasketNo) {
		this.shoppingBasketNo = shoppingBasketNo;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(String productPrice) {
		this.productPrice = productPrice;
	}
	public List<Integer> getShoppingBasketNoList() {
		return shoppingBasketNoList;
	}
	public void setShoppingBasketNoList(List<Integer> shoppingBasketNoList) {
		this.shoppingBasketNoList = shoppingBasketNoList;
	}
	public String[] getShoppingBasketNoArr() {
		return shoppingBasketNoArr;
	}
	public void setShoppingBasketNoArr(String[] shoppingBasketNoArr) {
		this.shoppingBasketNoArr = shoppingBasketNoArr;
	}
	public String getProductStatus() {
		return productStatus;
	}
	public void setProductStatus(String productStatus) {
		this.productStatus = productStatus;
	}
}
