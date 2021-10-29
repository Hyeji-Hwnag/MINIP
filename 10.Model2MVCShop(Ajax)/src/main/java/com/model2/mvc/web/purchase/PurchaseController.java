package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	//setter Method ���� ����
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	

	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	//@RequestMapping("/addPurchaseView.do")
	@RequestMapping( value="addPurchaseView")
	public ModelAndView addPurchase( @RequestParam("prodNo") String prodNumber) throws Exception {

		System.out.println("/purchase/addPurchase.do   : GET");
		System.out.println("prodNumber: "+prodNumber);
		int prodNo = Integer.parseInt(prodNumber);
		//System.out.println("prodNo: "+prodNo);
		Purchase purchase = purchaseService.getPurchase(prodNo);
		
		//System.out.println("purchase ::: "+purchase);
		//model.addAttribute("purchase", purchase);
		
		//return "forward:/purchase/addPurchaseView.jsp";
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/addPurchaseView.jsp");
		modelAndView.addObject("purchase", purchase);
		return modelAndView;
		
		
	}
	
	//@RequestMapping("/addPurchase.do")
	@RequestMapping( value="addPurchase")
	public ModelAndView addPurchase( @ModelAttribute("purchase") Purchase purchase, @ModelAttribute("product") Product product,  @ModelAttribute("user") User user) throws Exception {

		System.out.println("/purchase/addPurchase   : POST");

		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
	
		//System.out.println("purchase : "+purchase);
		purchaseService.addPurchase(purchase);
		purchaseService.updateStockCntProduct(product.getProdNo(), product.getStockCnt()-1);
		
//		
//		model.addAttribute("purchase", purchase);
//		return "forward:/purchase/addPurchase.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/addPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		return modelAndView;
	}
	
	//@RequestMapping("/getPurchase.do")
	@RequestMapping( value="getPurchase")
	public ModelAndView getPurchase( @RequestParam("tranNo") int tranNo) throws Exception {
		
		System.out.println("/purchase/getPurchase    : GET/POST");

		Purchase purchase = purchaseService.getPurchase2(tranNo);
		//System.out.println("purchase.getDivyRequest : "+purchase);
//		model.addAttribute("purchase", purchase);
//		return "forward:/purchase/getPurchase.jsp"; //// jsp getPurchase�� ���� 
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		return modelAndView;
	}
	
	

	
	//@RequestMapping("/listPurchase.do")
	@RequestMapping( value="listPurchase" )
	public ModelAndView listPurchase( @ModelAttribute("search") Search search , HttpSession session) throws Exception{
		
		System.out.println("/purchase/listPurchase  : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		String buyerId=((User)session.getAttribute("user")).getUserId();
		
		search.setPageSize(pageSize);
		System.out.println("search"+search);
		
		// Business logic ����
		Map<String , Object> map=purchaseService.getPurchaseList(search, buyerId);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
//		model.addAttribute("list", map.get("list"));
//		model.addAttribute("resultPage", resultPage);
//		model.addAttribute("search", search);
//		return "forward:/purchase/listPurchase.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listPurchase.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);

		return modelAndView;
		
	}
	
	
	
	//@RequestMapping("/updatePurchaseView.do")
	@RequestMapping( value="updatePurchase", method=RequestMethod.GET )	
	public ModelAndView updatePurchase( @RequestParam("tranNo") String tranNumber) throws Exception{

		
		System.out.println("/purchase/updatePurchase   :: GET ");
		int tranNo = Integer.parseInt(tranNumber);
		Purchase purchase = purchaseService.getPurchase2(tranNo);
		
//		model.addAttribute("purchase", purchase);
//		return "forward:/purchase/updatePurchaseView.jsp";
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/updatePurchaseView.jsp");
		modelAndView.addObject("purchase", purchase);
		return modelAndView;
	}
	
	
	
	//@RequestMapping("/updatePurchase.do")
	@RequestMapping( value="updatePurchase", method=RequestMethod.POST )	
	public ModelAndView updatePurchase( @ModelAttribute("purchase") Purchase purchase, @RequestParam("tranNo") String tranNumber) throws Exception{


		System.out.println("/purchase/updatePurchase   : POST");
		System.out.println("trnNumber"+tranNumber);

		
		int tranNo = Integer.parseInt(tranNumber);
		System.out.println("trNO : "+tranNo);

		purchase.setTranNo(tranNo);
		System.out.println("purchase : "+purchase);
		//Business Logic
		String dlvyDate = purchase.getDivyDate().substring(0,4)+purchase.getDivyDate().substring(5,7)+purchase.getDivyDate().substring(8,10);

		purchase.setDivyDate(dlvyDate);
		
		purchaseService.updatePurchase(purchase);
//		model.addAttribute("purchase", purchase);
//		model.addAttribute("tranNo", tranNo);
//		return "forward:/getPurchase.do";
		// ����... //return "forward:/getPurchase.do?tranNo="+tranNo;
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase");
		modelAndView.addObject("purchase", purchase);
		modelAndView.addObject("tranNo", tranNo);
		return modelAndView;
	}
	
	//@RequestMapping("/updateTranCode.do")
	@RequestMapping( value="updateTranCode", method=RequestMethod.GET )
	public ModelAndView updateTranCode( @ModelAttribute("purchase") Purchase purchase, @RequestParam("tranNo") int tranNo, @RequestParam("tranCode") String tranCode) throws Exception{

		
		System.out.println("/purchase/updateTranCode       :: GET ");
		
		purchase.setTranCode("3"); 
		purchase.setTranNo(tranNo);
		
		purchaseService.updateTranCode(purchase);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/purchase/listPurchase");
		//return "redirect:/listPurchase.do";
		return modelAndView;
	}
	
//	@RequestMapping("/updateTranCodeByProd.do")
	@RequestMapping( value="updateTranCodeByProd")
	public ModelAndView updateTranCodeByProd(  @RequestParam("tranNo") int tranNo, @RequestParam("type") String url, @RequestParam("prodNo") String prodNo) throws Exception{

		
		System.out.println("/purchase/updateTranCodeByProd");
		Purchase purchase=new Purchase();
		

		purchase.setTranCode("2"); // 1-> 2�� ����ȰŴϱ�?!!!!!!!!!! ^^...
		purchase.setTranNo(tranNo);
		
		purchaseService.updateTranCode(purchase);

		//return "redirect:/checkProductTranCode.do?prodNo="+prodNo;
		ModelAndView modelAndView = new ModelAndView();
//		modelAndView.setViewName("redirect:/purchase/checkProductTranCode?prodNo="+prodNo);
		modelAndView.setViewName("redirect:/purchase/"+url);
		modelAndView.addObject("prodNo", prodNo);
		return modelAndView;
	}
	
//	@RequestMapping("/checkProductTranCode.do")
	@RequestMapping( value="checkProductTranCode", method=RequestMethod.GET )
	public ModelAndView checkProductTranCode( @RequestParam("prodNo") String prodNumber ) throws Exception{
		
		System.out.println("/purchase/checkProductTranCode  :: GET");
		//Business Logic
		int prodNo = Integer.parseInt(prodNumber);
		Map<String , Object> map=purchaseService.getProductPurchaseList(prodNo);
		
		
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/listProdPurchase.jsp");
		modelAndView.addObject("list", map.get("list"));
		
		return modelAndView;
		
	}
	
	
	@RequestMapping( value="listTransaction")
	public ModelAndView listTransaction(@ModelAttribute("search") Search search , HttpSession session) throws Exception{
		
		System.out.println("1111");
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
				
		search.setPageSize(pageSize);
		// Business logic ����
		Map<String , Object> map=purchaseService.getTransactionList(search);
		
		System.out.println("map: "+map);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage : "+((Integer)map.get("totalCount")).intValue());
		System.out.println("list : "+map.get("list"));

		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listTransaction.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}
	
	
	
	
	
}