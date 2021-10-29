package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.user.UserDao;



@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public PurchaseDaoImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addPurchase(Purchase purchase) throws Exception {
		sqlSession.insert("PurchaseMapper.addPurchase", purchase);
	}

	public Purchase getPurchase(int ProdNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getPurchase", ProdNo);
	}
	
	public Purchase getPurchase2(int tranNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getPurchase2", tranNo);
	}
	
	
	
	public void  updatePurchase(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}
	public void  updateTranCode(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updateTranCode", purchase);
	}
	//public void  updateStockCntProduct(int prodNo, int stockCnt) throws Exception {
	public void  updateStockCntProduct(Product product) throws Exception {
		sqlSession.update("PurchaseMapper.updateStockCntProduct", product);
	}


	public Map<String,Object> getPurchaseList(Search search,String buyerId) throws Exception {
		
		Map<String , Object>  map = new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("buyerId", buyerId);
	
		
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getPurchaseList", map); 
		System.out.println("list: "+list);
/*
 *  �̰� ���� ���� �ּ� 
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setBuyer((User)sqlSession.selectOne("UserMapper.getUser", list.get(i).getBuyer().getUserId()));
			list.get(i).setPurchaseProd((Product)sqlSession.selectOne("ProductMapper.getProduct", list.get(i).getPurchaseProd().getProdNo()));
		}
	*/	
		map.put("totalCount", sqlSession.selectOne("PurchaseMapper.getTotalCount", buyerId));

		map.put("list", list);

	return map;
	}
	
	public List<Purchase> getSaleList(Search search) throws Exception {
		return sqlSession.selectList("PurchaseMapper.getSaleList", search);
	}

	// �Խ��� Page ó���� ���� ��ü Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getTotalCount", search);
	}
	
	//21.10.13
	public Map<String, Object> getProductPurchaseList(int prodNo) throws Exception{
		System.out.println("prodNo : "+prodNo);
		Map<String , Object>  map = new HashMap<String, Object>();
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getProductPurchaseList", prodNo); 
		map.put("list", list);
		System.out.println("list1 : "+list);
		return map;
	}
	
	//21. 10. 14 
	public Map<String, Object> getTransactionList(Search search) throws Exception{
		Map<String , Object>  map = new HashMap<String, Object>();
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getTransactionList", search); 
		map.put("list", list);
		map.put("totalCount", sqlSession.selectOne("PurchaseMapper.getTotalCount"));

		return map;
	}
}