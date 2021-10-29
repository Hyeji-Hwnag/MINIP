<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
<head>


<title>list product </title>




<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

function fncGetUserList(currentPage) {
	//document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage)
	var menu = $("input[name='menu']").val()
	
   	//document.detailForm.submit();
	
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu="+menu).submit();
} 
/* 
function fncGetUserList(currentPage){
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();		
} 

function fncGetOrderList(currentPage, orderColurm){
	document.getElementById("currentPage").value = currentPage;
	document.getElementById("orderColurm").value = orderColurm;
	
   	document.detailForm.submit();		
}

*/
function fncGetOrderList(currentPage, orderColurm){
	$("#currentPage").val(currentPage)
	$("#orderColurm").val(orderColurm)
	var menu = $("input[name='menu']").val()
	
	$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu="+menu).submit();

   	
}
/* 
function fncCheckTransaction(prodNo) {
	
	 
	
	var url = '/purchase/checkProductTranCode?prodNo='+prodNo;
		
	popWin 
	= window.open(url,"popWin", "left=300,top=200,width=700,height=200,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");
} */

$(function() {

	 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
		 fncGetUserList('1');
	});
	 
	 $( "input[value='가격낮은순']" ).on("click" , function() {
		 fncGetOrderList('1', 'p.price');
	});
	 
	 $( "input[value='가격높은순']" ).on("click" , function() {
		 fncGetOrderList('1', 'p.price desc');
	});
	 
	 $( "input[value='상품명낮은순']" ).on("click" , function() {
		 fncGetOrderList('1', 'p.prod_name asc');
	});
	 
	 $( "input[value='상품명높은순']" ).on("click" , function() {
		 fncGetOrderList('1', 'p.prod_name desc');
	});
	 
	$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
	
	$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
		var menu = $("input[name='menu']").val()
		var checkBtn = $(this);
		var tr = checkBtn.parent();
		var td = tr.children();
				
		var prodNo = td.eq(2).find("input").val();
		
				
		self.location ="/product/getProduct?menu="+menu+"&prodNo="+prodNo;
});
	
	
	
	$("td.checkT:contains('판매관리')").on("click" , function() {
		
		 var checkBtn = $(this);
			var tr = checkBtn.parent();
			var td = tr.children();
						
			var prodNo = td.eq(2).find("input").val();
			
		//alert($("td.ct_btn:contains('ID중복확인')").html());
		popWin 
		= window.open("/purchase/checkProductTranCode?prodNo="+prodNo,
									"popWin", 
									"left=300,top=200,width=700,height=200,marginwidth=0,marginheight=0,"+
									"scrollbars=no,scrolling=no,menubar=no,resizable=no");
	});
 
 
	
	
	
});


</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<!-- <form name="detailForm" action="/product/listProduct?menu=${menu}" method="post"> -->
<form name="detailForm">
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					<input name="menu" type="text" value="${menu}"/>
					<c:if test="${menu eq 'manage'}">
						상품 관리
					</c:if>
					<c:if test="${menu eq 'search'}">
						상품 검색
					</c:if>
					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
			<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
			<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
			<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
			
			</select>
			<input type="text" name="searchKeyword"  value="${search.searchKeyword}"  class="ct_input_g" style="width:200px; height:19px" />
		</td>
		
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:fncGetUserList('1');">검색</a> -->
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지</td>
	</tr>
	<tr>
	<td colspan="11" class="orderbutton">
		<input type="hidden" id="orderColurm" name="orderColurm" value=""/>
		<input type="hidden" id="orderKey" name="orderKey" value=""/>
		<input type="hidden" id="tranStatusCode" name="tranStatusCode" value=""/>
		
			 

		<!-- <a href="javascript:fncGetOrderList('1', 'p.price');">▲가격낮은순</a>&nbsp;&nbsp;&nbsp;
		<a href="javascript:fncGetOrderList('1', 'p.price desc');">▼가격높은순</a>&nbsp;&nbsp;&nbsp;
		<a href="javascript:fncGetOrderList('1', 'p.prod_name asc');">▲상품명</a>&nbsp;&nbsp;&nbsp;
		<a href="javascript:fncGetOrderList('1', 'p.prod_name desc');">▼상품명</a>&nbsp;&nbsp;&nbsp;
		 -->
		<input type="button" value="가격낮은순"/>
		<input type="button" value="가격높은순"/>
		<input type="button" value="상품명낮은순"/>
		<input type="button" value="상품명높은순"/>
	</td>
		
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격 </td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">수량</td>	
		<c:if test="${user.userId eq 'admin' && menu eq 'manage'}">
		<td class="ct_line02"></td>
		<td class="ct_list_b">판매관리</td>	
		</c:if>
		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:forEach var="product" items="${list}">
	
	<c:set var="i" value="${ i+1 }" />
	<tr class="ct_list_pop">
		<td align="center">${ i }</td>
		<td></td>
		<%-- 21/9/29
			proTranCode를 보냄 / 구매에서 쓰려고 --%>
		<td align="left">
		<!-- <a href="/product/getProduct?prodNo=${product.prodNo }&menu=${menu}">${product.prodName }</a> -->
		<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
		${product.prodName}
		</td>
		<td></td>
		<td align="left">${product.price }</td>
		<td></td>
		<td align="left">${product.manuDate }</td>
		<td></td>
		<td align="left">
		<c:if test="${product.stockCnt == 0}">
		재고없음 
		</c:if>
		<c:if test="${product.stockCnt != 0}">
		${product.stockCnt} 
		</c:if>
		
		
		
		<!--<c:if test="${tranStatusCode eq '구매완료' && user.userId eq 'admin' && menu eq 'manage'}">
		 <a href="javascript:fncCheckTransaction('${product.prodNo}');" id="prodNo">배송하기</a> 
		</c:if>-->
		</td>	
		<c:if test="${user.userId eq 'admin' && menu eq 'manage'}">
			<td></td>
			<td align="left" class="checkT">
			<!-- <a href="javascript:fncCheckTransaction('${product.prodNo}');">판매관리</a> -->
			판매관리
			</td>
		</c:if>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	</c:forEach>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		 <input type="hidden" id="currentPage" name="currentPage" value=""/>
		 
		 <jsp:include page="../common/pageNavigator.jsp"/>	
		 
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
