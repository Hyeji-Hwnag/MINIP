<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    


<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

function fncCheckStockCnt() {
	// Form ��ȿ�� ����
	//var name=document.detailForm.userName.value;
	var stockCnt=$("input[name='stockCnt']").val();
	
	if (stockCnt<=0){
		alert("������ �����Ͽ� ���Ÿ� �� �� �����ϴ�. ");
		return;
	}else{
		
		$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchaseView?prodNo=${product.prodNo}").submit();

	}
	
}

$(function() {
	//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
	 $( "td.ct_btn01:contains('����')" ).on("click" , function() {
		//Debug..
		//alert(  $( "td.ct_btn01:contains('����')" ).html() );
		fncCheckStockCnt();
	});
	
	 $( "td.ct_btn01:contains('Ȯ��')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('����')" ).html() );
			self.location = "/purchase/addPurchase?prodNo=${product.prodNo}"
		});
	 $( "td.ct_btn01:contains('����')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('Ȯ��')" ).html() );
			history.go(-1);
		});
	 $( "td.ct_btn01:contains('��ٱ����߰�')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('Ȯ��')" ).html() );
			self.location = "/product/addCart?prodNo=${product.prodNo}&userId=${user.userId}"
		});
	 
});	

/* 
function fncCheckStockCnt(stockCnt){
	//document.getElementById("stockCnt").value = stockCnt;
	
	if (stockCnt<=0){
		alert("������ �����Ͽ� ���Ÿ� �� �� �����ϴ�. ");
		return;
	}else{
		//document.getElementById("prodNo").value = ${product.prodNo};
		//alert(${product.prodNo});
		document.detailForm.submit();		
	}
	
}
 */
</script>
<title>Insert title here</title>
</head>

<body bgcolor="#ffffff" text="#000000">
<!-- 
<form name="detailForm" method="post" action="/purchase/addPurchaseView?prodNo=${product.prodNo}">
 -->
 <form name="detailForm">
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"	width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">��ǰ����ȸ</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif"  width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ��ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">${product.prodNo}</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.prodName}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ�̹��� <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<img src="/images/uploadFiles/${product.fileName}" width="100" height="100" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ������ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.prodDetail}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">��������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.manuDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">����</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.price}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.regDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>
<input type="hidden" id="stockCnt" name="stockCnt" value="${product.stockCnt }"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">

		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
		
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
				<%--
				<% if(menu.equals("manage")){%>
					<a href="/addPurchaseView.do?prod_no=<%=product.getProdNo() %>">Ȯ��</a>
					<%}else {%>
					<a href="/addPurchaseView.do?prod_no=<%=product.getProdNo() %>">����</a>
					<%} %> 
				--%>
				<c:if test="${param.menu eq 'manage'}">
				<!-- 
				<a href="/purchase/addPurchase?prodNo=${product.prodNo}">Ȯ��</a>
				 -->
				 Ȯ��
				</c:if>
				<c:if test="${param.menu eq 'search'}">
				<!-- 
				<a href="javascript:fncCheckStockCnt('${product.stockCnt }')">����</a>
				 -->
				 ����
				</c:if>
				
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23">
				</td>
				<td width="30"></td>
		
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					<!-- <a href="javascript:history.go(-1)">����</a> -->
					����
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23">
				</td>
				<td width="30"></td>
		
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					<!-- <a href="/product/addCart?prodNo=${product.prodNo}&userId=${user.userId}">��ٱ����߰�</a>
				 -->
				 ��ٱ����߰�
				 </td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23">
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

</form>

</body>
</html>