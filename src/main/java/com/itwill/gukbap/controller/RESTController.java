package com.itwill.gukbap.controller;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.itwill.gukbap.domain.AddressDomain;
import com.itwill.gukbap.domain.OrderDomain;
import com.itwill.gukbap.domain.ProductDomain;
import com.itwill.gukbap.domain.ReviewDomain;
import com.itwill.gukbap.domain.UserDomain;
import com.itwill.gukbap.service.AddressService;
import com.itwill.gukbap.service.OrderService;
import com.itwill.gukbap.service.ProductService;
import com.itwill.gukbap.service.ReviewService;
import com.itwill.gukbap.service.UserService;

@RestController
public class RESTController {

	@Autowired
	UserService userService;
	@Autowired
	ProductService productService;
	@Autowired
	OrderService orderService;
	@Autowired
	AddressService addressService;
	@Autowired
	ReviewService reviewService;
	
	@RequestMapping(value = "checkout_action", method = RequestMethod.POST)
	public void checkout_action(@RequestParam String order_note, 
								@RequestParam String order_no, HttpSession session) {
		OrderDomain currentOrder = orderService.selectOrderByNo(Integer.parseInt(order_no));
		currentOrder.setOrder_note(order_note);
		currentOrder.setOrder_status("shipped");
		orderService.updateOrder(currentOrder);
		
		UserDomain user = (UserDomain) session.getAttribute("loginUser");
		orderService.createEmptyOrder(user.getUser_id());
		
	}
	
	@RequestMapping(value = "write_review", method = RequestMethod.POST)
	public void write_review(@RequestParam MultipartFile image_file,
							 @RequestParam String review_title, @RequestParam String review_content,
							 @RequestParam String product_no, @RequestParam String o_d_no) {
		
		ReviewDomain review = 
				new ReviewDomain(0, image_file.getOriginalFilename(), 
								review_title, review_content, 
								null, 0, 0, 0, Integer.parseInt(product_no), Integer.parseInt(o_d_no));
		
		
		try (FileOutputStream fos = new FileOutputStream(
				"C:\\java-python\\generalGukbap\\src\\main\\webapp\\assets\\img\\review\\"
						+ image_file.getOriginalFilename());
				InputStream is = image_file.getInputStream();
		) 
		{
			int readCount = 0;
			byte[] buffer = new byte[1024];
			while ((readCount = is.read(buffer)) != -1) {
				fos.write(buffer, 0, readCount);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		reviewService.insertReview(review);
	}

	@RequestMapping(value = "delete_address_action", method = RequestMethod.POST)
	public void delete_address_action(@RequestParam String address_no, HttpSession session) {
		addressService.deleteAddress(Integer.parseInt(address_no), GukbapController.get_user_id_from_session(session));
	}

	@RequestMapping(value = "add_new_address", method = RequestMethod.POST)
	public void add_new_address(@ModelAttribute AddressDomain address, HttpSession session) {
		String user_id = GukbapController.get_user_id_from_session(session);
		addressService.insertAddress(address, user_id);
	}

	@RequestMapping(value = "modal_prodcut_detail", produces = "application/json;charset=UTF-8")
	public ProductDomain get_product_detail(@RequestParam String product_no) {
		ProductDomain product = productService.selectProductByProductNo(Integer.parseInt(product_no));
		return product;
	}

	@RequestMapping(value = "prodcut_list", produces = "application/json;charset=UTF-8")
	public List<ProductDomain> prodcut_list(@RequestParam int c_no, HttpServletRequest request) {
		List<ProductDomain> productList = productService.selectProductByCategoryNo(c_no);
		// request.setAttribute("productList",productList);
		return productList;
	}

	@RequestMapping(value = "update_user_info", method = RequestMethod.POST)
	public void update_user_info(@ModelAttribute UserDomain update_user, HttpSession session) {
		userService.updateUserInfo(update_user);
		UserDomain user = userService.selectUserById(update_user.getUser_id());
		session.setAttribute("loginUser", user);
		
	}

	@RequestMapping(value = "user_existed_id_check", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public String user_exist_check(@RequestParam String user_id) {
		String isExist = "false";
		UserDomain user = userService.selectUserById(user_id);
		if (user == null) {
			isExist = "true";
		}
		return isExist;
	}

}
