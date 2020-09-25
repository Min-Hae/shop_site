package kr.shop.order;

import java.util.Hashtable;

public class CartMgr {	//맵뉴 => hashtable/hashmap
	private Hashtable hCart = new Hashtable();	//Hashtable<k, v>형태(key, value) : 안쓰면 기본값
	
	public void addCart(OrderBean obean) {
		String product_no = obean.getProduct_no();
		int quantity = Integer.parseInt(obean.getQuantity());
		//System.out.println(product_no + " 주문수:" + quantity + " id:" + obean.getId());
		
		if(quantity > 0) {	//주문수량이 0보다 클때 => 주문이 일어났을때
			//동일 상품 주문인 경우에는 주문 수만 증가
			if(hCart.containsKey(product_no)) {
				OrderBean temp = (OrderBean)hCart.get(product_no);	//key, value값 안주면 각각 object형태로 저장되어있음
				quantity += Integer.parseInt(temp.getQuantity());
				temp.setQuantity(Integer.toString(quantity));
				hCart.put(product_no, temp);
				System.out.println("동일 상품 주문인 경우에는 주문 수 : " + quantity);
			}else {	//고객이 새로운 상품을 장바구니에 담기함
				hCart.put(product_no, obean);	//put() : <k, v>형태 (key, value)로 담을 때
			}
		}
	}
	
	public Hashtable getCartList() {
		return hCart;
	}
	
	public void updateCart(OrderBean obean) {
		String product_no = obean.getProduct_no();
		hCart.put(product_no, obean);
	}
	
	public void deleteCart(OrderBean obean) {
		String product_no = obean.getProduct_no();
		hCart.remove(product_no);
	}	
}
