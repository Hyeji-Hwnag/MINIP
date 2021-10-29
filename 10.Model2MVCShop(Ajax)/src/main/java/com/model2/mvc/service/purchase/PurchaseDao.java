package com.model2.mvc.service.purchase;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;


//==> ȸ���������� CRUD �߻�ȭ/ĸ��ȭ�� DAO Interface Definition
public interface PurchaseDao {
	
	// INSERT
	public void addPurchase(Purchase purchase) throws Exception ;	
	// SELECT ONE
	public Purchase getPurchase(int ProdNo) throws Exception;	
	public Purchase getPurchase2(int tranNo) throws Exception;
	public void  updatePurchase(Purchase purchase) throws Exception;
	public void  updateTranCode(Purchase purchase) throws Exception;
	public void  updateStockCntProduct(Product product) throws Exception;
	public Map<String,Object> getPurchaseList(Search search,String buyerId) throws Exception;
	public List<Purchase> getSaleList(Search search) throws Exception;
	
	
	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
	// 21.10.13
	public Map<String, Object> getProductPurchaseList(int prodNo) throws Exception;
	//21. 10. 14
	public Map<String, Object> getTransactionList(Search search) throws Exception;
	
}