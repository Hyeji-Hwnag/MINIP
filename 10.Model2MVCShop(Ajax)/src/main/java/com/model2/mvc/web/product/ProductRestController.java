package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	

	

	//@RequestMapping( value="json/autoProduct/{keyword}", method=RequestMethod.POST)
	@RequestMapping( value="json/autoProduct", method=RequestMethod.POST)
	//public ArrayList AutoProduct( @PathVariable String keyword, Locale locale, Model model, HttpServletRequest request,
	public ArrayList AutoProduct(  Locale locale, Model model, HttpServletRequest request,
			 HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");
		
		System.out.println("/json/AutoProduct : GET");
		String keyword = request.getParameter("keyword");
		List<Product> list = productService.getAutoProdName(keyword);
	
		ArrayList ja = new ArrayList();
		
		
		
		for(int i=0; i<list.size(); i++) {
			
			ja.add(list.get(i).getProdName());
			
		}
		System.out.println("ja: "+ja);
		return ja;
	
	}
	
	
	
	
	
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public Product addProduct( @RequestBody Product product) throws Exception {

		System.out.println("/product/addProduct : POST");
		//Business Logic
		//manuDate �׳� ����? �ȵ� �� ���Ƽ� ó�� 
		System.out.println("product : "+product);
		String manuDate = product.getManuDate().substring(0,4)+product.getManuDate().substring(5,7)+product.getManuDate().substring(8);
		product.setManuDate(manuDate);
		System.out.println("1");
		
		String temDir = "F:\\workspace_hhj\\07.Model2MVCShop(URI,pattern)_h\\src\\main\\webapp\\images\\uploadFiles\\";
		
		
		
//		if(!file.getOriginalFilename().isEmpty()) {
//			file.transferTo(new File(temDir, file.getOriginalFilename()));
//			
//		}
		//product.setFileName(file.getOriginalFilename());
		
		productService.addProduct(product);
		//model.addAttribute("product", product);

	
		//return "forward:/product/addProduct.jsp";
		return productService.getProduct(10010);
	    // prodNo �� �޾ƿ���
	}
	
	

	
	
	
	
	
	
	//@RequestMapping("/getProduct.do")
	@RequestMapping( value="json/getProduct/{prodNm}/{menu}")
	public Product getProduct( @PathVariable String prodNm ,  @PathVariable String menu , HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		// Cookie ó�� �ؾ� �� 
		
	System.out.println("/product/getProduct : GET / POST");
		//Business Logic
		//System.out.println("proTranCode :"+proTranCode);
		int prodNo = Integer.parseInt(prodNm);
		Product product = productService.getProduct(prodNo);
		
		 
//		System.out.println("product.get::::::"+product.getProTranCode());
		//model.addAttribute("product", product);
		
		if (menu.equals("manage")) {
			
			//return "forward:/product/updateProductView.do";
			//Ȥ�� GET ������� ��ĥ �� �ִ��� Ȯ���غ���.
			//�ϴ�...... �غ���! updateProduct��. 
			//return "forward:/product/updateProductView";
			System.out.println("manage�� �Ѿ��");
		}
		System.out.println("search�� �Ѿ��");
//		String ckHistory = "";
//		  
//		for (Cookie c: request.getCookies()){


		      //if (c.getName().equals("history")){

		    	//  ckHistory=c.getValue();       
		     // }
		 // }
		   
//		System.out.println("cookie "+ ckHistory);
	//	   Cookie cookie = new Cookie("history", prodNo+","+ckHistory);   // ��Ű ����
		//   cookie.setMaxAge(60*60);   // ���� Cookie�� �����Ⱓ
		 //  cookie.setPath("/");
		  // response.addCookie(cookie);
		   //model.addAttribute("cookie", cookie);
		   // Model �� View ����
		   
		   // ��Ű => ��ٱ��� -> session 
		
		//return "forward:/product/getProduct.jsp";
		   return productService.getProduct(prodNo);
	}

}