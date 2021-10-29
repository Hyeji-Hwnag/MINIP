
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
<head>
<title>��ٱ��� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

function fncGetUserList(currentPage) {
	//document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage)
   	//document.detailForm.submit();
	$("form").attr("method" , "POST").attr("action" , "/product/listCart").submit();
} 
/* 
function fncGetUserList(currentPage){
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();		
}
 */


 function fncCheckStockCnt(stockCnt, prodNo) {
 	// Form ��ȿ�� ����
 	//var name=document.detailForm.userName.value;
 	
 	if (stockCnt<=0){
 		alert("������ �����Ͽ� ���Ÿ� �� �� �����ϴ�. ");
 		return;
 	}else{
 		
 		$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchaseView?prodNo="+prodNo).submit();

 	}
 	
 }
 
 
 $(function() {
	 
	
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		//==> userId LINK Event ����ó��
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 3 �� 1 ��� ���� : $(".className tagName:filter�Լ�") �����.
		$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
				//Debug..
				//alert( "1" );
				self.location ="/product/getProduct?menu=search&prodNo="+$(this).text().trim();
		});
		
		/* $( ".ct_list_pop td:nth-child(9)" ).on("click" , function() {
			//Debug..
			var tr = $(this);
			var td = tr.children();
			console.log("dd"+td.text());
			
			var prodNo = td.eq(3).text();
			
			alert(prodNo+":::");
			fncCheckStockCnt('${product.stockCnt }', '${product.prodNo}' );
			
	}); */
		 $(".checkBtn:contains('����')").click(function(){
				var str = "";
				//var tdArr = new Array();
				var checkBtn = $(this);
				
				var tr = checkBtn.parent();
				var td = tr.children();
				
				var prodNo = td.eq(2).text().trim();
				var stockCnt = td.eq(6).text().trim();
				
				//console.log("prodNo : "+prodNo+", stockCnt: "+stockCnt);
				fncCheckStockCnt(stockCnt, prodNo);
		});
		 $(".checkBtn:contains('����')").click(function(){
				
				
				//var tdArr = new Array();
				var checkBtn = $(this);
				
				var tr = checkBtn.parent();
				var td = tr.children();
				
				//var cartId=td.eq(13).text().trim();
				var cartId=td.eq(12).find("input").val();
				
				self.location="/product/deleteCart?cartId="+cartId;
		});
		
});	
 

 




</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� ��ٱ���</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<!-- <tr>
		<td colspan="11">��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������</td>
	</tr> -->
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ�̸�</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">����</td>
		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>




	<c:forEach var="product" items="${list}">
		
	<c:set var="i" value="${ i+1 }" />	 
	<tr class="ct_list_pop">
		<td align="center">
			${ i }
		</td>
		<td></td>
		<td align="left">
		<!-- 
			<a href="/user/getUser?userId=${user.userId}">${product.prodNo}</a> -->
			${product.prodNo}
		</td>
		<td></td>
		<td align="left">${product.prodName}</td>
		<td></td>
		<td align="left">${product.stockCnt}</td>
		<td></td>
		<td align="left" class="checkBtn">
		<!-- 
		<input type="button" class="checkBtn" value="����" />
		<a href="javascript:fncCheckStockCnt('${product.stockCnt }', '${product.prodNo} }')">���Ź�ư</a></td> -->
		����</td>
		
		<td></td>
		<td align="left" class="checkBtn">
		<!-- <a href="/product/deleteCart?cartId=${product.cartId}">������ư</a>-->
		����</td>
		<td></td>
		<td><input type="hidden" value="${product.cartId}"/></td>
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

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>