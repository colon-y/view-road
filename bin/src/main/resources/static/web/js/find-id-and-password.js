
/*휴대폰 체크 정규식*/
const autoHyphen = (target) => {
	target.value = target.value
		.replace(/[^0-9]/g, '')
		.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
}

/*휴대폰 번호로 아이디 찾기*/
function findPhoneId(){
	const phone=$("#phone");
	if (phone.val() == "") {
		alert("휴대폰 번호를 입력해 주세요.");		
		return;
	}
	
	const patternPhone = /01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/;	  
    if(!patternPhone.test(phone.val())){
    	alert("핸드폰 번호를 확인 해주세요.");		
        return;
    }
    	
	$.ajax({
			type: "POST",
			dataType: "text",
			data: {
				phone: phone.val()
			},
			url: "/findIdPassword/phoneDbCheck",
			success: function(result) {	
				var d = parseInt($.trim(result));
				if (d == 0) {
					alert('가입된 휴대전화 번호가 아닙니다.');
				} else if (d > 0) {
					phone.val("");
					alert('가입하신 휴대전화 번호로 아이디가 전송되었습니다.');
				}
			}
	});	
}



/*이메일로 아이디 찾기*/
function findEmailID(){
	const email=$("#email");
	if (email.val() == "") {
		alert("이메일을 입력해 주세요.");		
		return;
	}
	
	var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	if(!reg_email.test(email.val())) {		
		 alert("이메일을 형식이 맞지 않습니다.");		
	     return ;         
	}  
		
	$.ajax({
			type: "POST",
			dataType: "text",
			data: {
				email: email.val()
			},
			url: "/findIdPassword/emailDbCheck",
			success: function(result) {	
				const d = parseInt($.trim(result));
				if(d===0){
					alert("등록된 이메일이 아닙니다.");
					return;
				}				
				loading_pop_klover();
				emailSendId();			
			},
			error:function(error){
				console.log(" 에러 :", error);
			}
	});	
}

/*이메일로 아이디 정보 보내기*/
function emailSendId(){	
	$.ajax({
		type: "POST",
		dataType: "text",
		data: {
			email: $("#email").val()
		},
		url: "/findIdPassword/sendId",
		success: function(result) {	
			if(result==="success"){
				loadingnBtnLayerClose();
				$("#email").val("");
				alert("가입하신 이메일로 아이디가 전송되었습니다.");				
			}	
			
		},error:function(error){
			console.log(" 에러 :", error);
		}		
	});		
}




/************************************************************************************ */
/************************************************************************************ */
/************************************************************************************ */



/*아이디와 휴대폰으로 비밀번호 찾기*/
function findPhonePassword(){
	const userId=$("#userId1").val();
	if(!userId){
		$("#userId1").focus();
		alert("아이디를 입력해 주세요.");
		return ;
	}
	
	const phone=$("#phone");
	if (phone.val() == "") {
		alert("휴대폰 번호를 입력해 주세요.");		
		return;
	}
	
	const patternPhone = /01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/;	  
    if(!patternPhone.test(phone.val())){
    	alert("핸드폰 번호를 확인 해주세요.");		
        return;
    }
    	
	$.ajax({
			type: "POST",
			data: {
				userId:userId,
				phone: phone.val()
			},
			url: "/findIdPassword/idPhoneCheck",
			success: function(result) {	
				console.log(" result : ", result);				
				var d = parseInt($.trim(result));
				if (d == 0) {
					alert('아이디 또는 휴대전화 번호가 일치하지 않습니다.');
				} else if (d > 0) {
					alert('가입하신 휴대전화로 임시비밀번호가 전송되었습니다');
					$("#userId1").val("");
					$("#phone").val("");
				}
			}
	});	
}


/*아이디와 이메일로 비밀번호 찾기*/
function findEmailPassword(){
	const userId=$("#userId2").val();
	if(!userId){
		$("#userId2").focus();
		alert("아이디를 입력해 주세요.");
		return ;
	}
	
	const email=$("#email");
	if (email.val() == "") {
		alert("이메일을 입력해 주세요.");		
		return;
	}
	
	var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	if(!reg_email.test(email.val())) {		
		 alert("이메일을 형식이 맞지 않습니다.");		
	     return ;         
	}  
		
	$.ajax({
			type: "POST",
			data: {
				userId:userId,
				email: email.val()
			},
			url: "/findIdPassword/findEmailPassword",
			success: function(result) {	
				const d = parseInt($.trim(result));
				if(d===0){
					alert("아이디 또는 이메일이 일치하지 않습니다.");
					return;
				}				
				loading_pop_klover();
				emailSendPassword();			
			},
			error:function(error){
				console.log(" 에러 :", error);
			}
	});	
}


/*이메일로 임시 비밀번호 발송*/
function emailSendPassword(){	
	const userId=$("#userId2").val();
	if(!userId){
		$("#userId2").focus();
		alert("아이디를 입력해 주세요.");
		return ;
	}
	
	$.ajax({
		type: "POST",
		dataType: "text",
		data: {
			userId:userId,
			email: $("#email").val()
		},
		url: "/findIdPassword/emailSendPassword",
		success: function(result) {	
				
			if(result==="success"){
				loadingnBtnLayerClose();
				$("#userId2").val("");
				$("#email").val("");
				alert('가입하신 이메일로 임시비밀번호가 전송되었습니다');
				
			}	
			
		},error:function(error){
			console.log(" 에러 :", error);
		}		
	});		
}

   


                   