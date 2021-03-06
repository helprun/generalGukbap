<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container">  
                <div class="row">
                    <div class="col-12">
                        <div class="table_desc">
                            <div class="cart_page">
                                <table>
                            <thead>
                                <tr>
                                    <th class="product_remove">삭제</th>
                                    <th class="product_thumb">이미지</th>
                                    <th class="product_name">제품</th>
                                    <th class="product-price">가격</th>
                                    <th class="product_quantity">수량</th>
                                    <th class="product_total">합계</th>
                                </tr>
                            </thead>
                            <c:choose>
									<c:when test="${orderDetailList[0].o_d_no == '0'}">
	                            	</c:when>
								<c:otherwise>
		                            <c:if test="${orderDetailList!=null}">
		                          <c:forEach items="${orderDetailList}" var="orderDetail">  
		                            <tbody>
		                                <tr>
		                                   <td class="product_remove"><a><button style="border: none; background: transparent;" name="cart_delete" value="${orderDetail.o_d_no}"><i class="fa fa-trash-o"></i></button></a></td>
		                                    <td class="product_thumb"><a><img src="assets/img/product/${orderDetail.product.product_image}"></a></td>
		                                    <td class="product_name"><a>${orderDetail.product.product_name}</a></td>
		                                    <td class="product-price">${orderDetail.product.product_price}</td>
		                                    <td class="product_quantity"><label>${orderDetail.o_d_product_count}</label></td>
		                                    <td class="product_total">${orderDetail.product.product_price*orderDetail.o_d_product_count}</td>
		                                </tr>
		                            </tbody>
		                            </c:forEach>
		                            </c:if>
								</c:otherwise>                           	
                            </c:choose>
                        </table>   
                            </div>  
                            <!-- 
                            <div class="cart_submit">
                                <button type="submit">update cart</button>
                            </div> 
                              -->   
                        </div>
                     </div>
                 </div>
                 <!--coupon code area start-->
                <div class="coupon_area">
                         <div class="col-md-6 offset-md-6"></div>
                            <div class="coupon_code right">
                                <h3>Cart Totals</h3>
                                <div class="coupon_inner">
                                   <div class="cart_subtotal">
                                       <p>소계</p>
                                     <!--  -->  <p class="cart_amount">총합:${order.order_total_price}원</p>
                                   </div>
                                   <div class="cart_subtotal ">
                                       <p>배송비</p>
                                       <p class="cart_amount">3000원</p>
                                   </div>
                                   <a ></a>

                                   <div class="cart_subtotal">
                                       <p>주문금액</p>
                                       <c:if test="${order.order_total_price>0}">
                                       <p class="cart_amount">${order.order_total_price+3000}원</p>
                                       </c:if>
                                   </div>
                                   <c:choose>
                                   		<c:when test="${order.order_total_price == null || order.order_total_price == '0' }">
                                   		</c:when>
                                   		<c:otherwise>
		                                   <c:choose>
		                                   		<c:when test="${orderDetailList == null }">
		                                   		</c:when>
		                                   		<c:otherwise>
				                                   <div class="checkout_btn">
				                                       <a href="checkout">주문하기</a>
				                                   </div>
		                                   		</c:otherwise>
		                                   </c:choose>
                                   		</c:otherwise>
                                   </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
             
<script type="text/javascript" src="assets/js/custom/cart.js"></script>