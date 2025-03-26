<%@page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<script>
function addProductCart(id) {
    let divs = document.getElementsByClassName("addCart");
    
    for (let i = 0; i < divs.length; i++) {
        let div = divs[i];
        let dataId = div.getAttribute("data-id");

        if (id == dataId) {
            let label = div.querySelector("label");
            let currentQuantity = parseInt(label ? label.innerHTML : "0"); // Lấy số lượng hiện tại

            var data = { 'id': id, 'quantity': currentQuantity + 1 }; // Tăng số lượng

            fetch('/store/product/addCart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(dataResp => {
                if (dataResp.errors != null) {
                    alert(dataResp.errors[0].message);
                    return;
                }

                let divBtn = div.querySelector(".btn-group");
                let divP2 = div.querySelector(".p-2");

                if (divBtn) {
                    divBtn.style.display = 'block'; // Hiển thị nút cập nhật số lượng
                }
                if (divP2) {
                    divP2.style.display = 'none'; // Ẩn nút giỏ hàng
                }
                if (label) {
                    label.innerHTML = dataResp.quantity; // Cập nhật số lượng hiển thị
                }

                // Cập nhật số lượng giỏ hàng tổng thể
                let myCart = document.getElementById("myCart");
                if (myCart) {
                    myCart.innerHTML = dataResp.getCount;
                }
            })
            .catch(error => {
                console.error("Lỗi khi thêm vào giỏ hàng:", error);
            });

            break; // Dừng vòng lặp khi tìm thấy sản phẩm
        }
    }
}


  
  function updateCart(input,disting) {
	  let id = input.parentNode.parentNode
	  let label = id.querySelector("label");
	  let value = parseInt(label.innerHTML);
	  if(disting === '+'){
		  value +=   1
	  }else{
		  value -=   1
	  }
	  if(value <0 || value > 5){
		  return;
	  }
		var data = { 'id': id.getAttribute("data-id"), 'quantity': value };
    
	  fetch('/store/product/cart/disting', {
		    method: 'POST', // Phương thức yêu cầu
		    headers: {
		        'Content-Type': 'application/json' // Loại dữ liệu gửi đi là JSON
		    },
		    body: JSON.stringify(data) // Chuyển đổi đối tượng JSON thành chuỗi JSON
		})
		.then(function(response) {
              return response.json(); // Chuyển đổi phản hồi thành đối tượng JSON nếu trạng thái là "Bad Request"
		})
		.then(function(dataResp) {
			if(dataResp.errors != null){
				alert(dataResp.errors[0].message)
				return
			}
			let divs = document.getElementsByClassName("addCart");
        	for (let i = 0; i < divs.length; i++) {
        	      let div = divs[i];
        	      let dataId = div.getAttribute("data-id")
        	      	if(id.getAttribute("data-id") == dataId){
        	      		
        	      		if(dataResp.quantity <= 0){
        	      			let divBtn = div.querySelector(".btn");
            	      		divBtn.style.display = 'none'
        	      			let divp2 = div.querySelector(".p-2");
            	      		divp2.style.display = 'block'
        	      		}
        	      		
        	      		let label = div.querySelector("label");
        	      		console.log(dataResp)
        	            label.innerHTML = dataResp.quantity;
        	      	}
        	      }
        	if(dataResp.getCount <= 0){
        		let myCart = document.getElementById("myCart");
	            myCart.innerHTML = ''
        	}else{
        		let myCart = document.getElementById("myCart");
	            myCart.innerHTML = dataResp.getCount
        	}
          })
		.catch(function(error) {
		});
    

    }
</script>