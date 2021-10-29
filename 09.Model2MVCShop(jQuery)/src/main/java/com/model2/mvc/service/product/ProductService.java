package com.model2.mvc.service.product;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;


public interface ProductService {
	
	public void addProduct(Product product) throws Exception;

	public Product getProduct(int prodNo) throws Exception;
	
	public Product getProduct2(String prodName) throws Exception;

	public Map<String,Object> getProductList(Search search) throws Exception;

	public void updateProduct(Product product) throws Exception;
	
	//21. 10. 02. ������ ���Ͽ� �߰���Ŵ 
	public boolean checkDuplicationProduct(String prodName) throws Exception;
	public Map<String,Object> getProductTranList(int prodNo)  throws Exception;
	
	//21. 10. 15 ��ٱ����߰�  
	public void addCart(int prodNo, String userId)throws Exception;
	//21. 10. 15 ��ٱ��� ��ȿ�� üũ 
	public boolean validationCart(int prodNo, String userId)throws Exception;
	//21. 10. 17 ��ٱ��� ����Ʈ 
	public Map<String,Object> getCartList(Search search,String buyerId) throws Exception;
	//21. 10. 17 delete 
	public void deleteCart(int cartId) throws Exception;
}