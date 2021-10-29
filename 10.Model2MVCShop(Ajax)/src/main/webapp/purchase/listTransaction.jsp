
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<html>
<head>
<title>��� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">


function fncGetUserList(currentPage) {
	//document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage)
	$("form").attr("method" , "POST").attr("action" , "/purchase/listTransaction").submit();
} 




$(function() {
	$("td.checkT:contains('����ϱ�')").on("click" , function() {
	
		
		 var checkBtn = $(this);
		var tr = checkBtn.parent();
		var td = tr.children();
						
		var tranNo = td.eq(0).text().trim();
		
		var prodNo = td.eq(10).find("input").val();
			
		self.location="/purchase/updateTranCodeByProd?tranNo="+tranNo+"&type=listTransaction&prodNo="+prodNo;
	});
});


</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" >

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">��� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">�ֹ���ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">������ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">������</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�߼������</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�߼��ϱ�</td>
		<td class="ct_line02"></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>




	<c:forEach var="purchase" items="${list}">
		<c:set var="tranStatusCode" value="�Ǹ���"/>
		<c:set var="tranCode" value="${fn:trim(purchase.tranCode)}"/>
		<c:choose>
			<c:when test="${ ! empty tranCode && tranCode eq '1'}">
				<c:set var="tranStatusCode" value="���ſϷ�"/>
			</c:when>
			<c:when test="${ ! empty tranCode && tranCode eq '2'}">
				<c:set var="tranStatusCode" value="�����"/>
			</c:when>
			<c:when test="${ ! empty tranCode && tranCode eq '3'}">
				<c:set var="tranStatusCode" value="��ۿϷ�"/>
			</c:when>
		</c:choose>

	 <c:set var="i" value="${ i+1 }" />	 
	<tr class="ct_list_pop">
		<td align="center">
			${purchase.tranNo }</a>
		</td>
		<td></td>
		<td align="left">
			${purchase.purchaseProd.prodName}</a>
		</td>
		<td></td>
		<td align="left">${purchase.buyer.userId}</td>
		<td></td>
		<td align="left">${purchase.orderDate}</td>
		<td></td>
		<td align="left">${purchase.divyDate}</td>
		<td></td>
		<td align="left" class="checkT">
		<!-- 
		<a href="/purchase/updateTranCodeByProd?tranNo=${purchase.tranNo}&type=listTransaction&prodNo=${purchase.purchaseProd.prodNo}">����ϱ�</a>
		 -->
		 <input type="hidden" value=${purchase.purchaseProd.prodNo }/>
			����ϱ�
		</td>
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