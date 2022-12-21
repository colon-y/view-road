/****************************************************************************************************** */
/****************************************************************************************************** */
/****************************************************************************************************** */
/*이에밀 인증 처리 */
let $emailAuthKey;
function emailAuthentication() {
	if ($emailAuthKey === $("#emailAuthKey").val()) {
		alert("인증처리 되었습니다.");
		$("#emailState").val("success");
		$(".emailValidation").html("이메일 인증 완료");
		$("#email").attr("readonly" , true);
		$(".btn-layerClose").click();
		 
        document.getElementById("emailKeySendBtn").setAttribute('onclick', 'alert("인증처리 되었습니다.");'); 
	    document.getElementById("emailKeySendBtn").style.background="#9e9e9e";  
		
	} else {
		alert("인증키가 맞지 않습니다.");
	}
}
function emailKeySend() {

	const email = $("#email");
	if (!email.val()) {
		alert("이메일을 입력해 주세요.");
		$("#email").focus();
		return;
	}
	if (parseInt(email.attr("check")) !== 0) {
		alert("사용할 수 없는 이메일 입니다.");
		return;
	}

	//로딩 바 시작
	loading_pop_klover();
	
	$.ajax({
		url: "/emailAuthentication/send",
		type: "post",
		data: { email: email.val() },
		success: function(res) {
			if (res.code === "success") {
				$emailAuthKey = res.emailAuthKey;
				alert("인증번호가 이메일로 발송처리 되었습니다.");
				loadingnBtnLayerClose();
				pop_klover();
			} else {
				alert("이메일 인증키 전송에 실패하였습니다.");
			}
		},
		error: function(error) {
			console.log("error :", error);
		}
	})
}

function pop_klover() {
	$("#emailAuthKey").val("");

	var $el = $('#klover-layer');        //레이어의 id를 $el 변수에 저장
	var isDim = $el.prev().hasClass('klover-dimBg');    //dimmed 레이어를 감지하기 위한 boolean 변수

	isDim ? $('.klover-dim-layer').fadeIn() : $el.fadeIn();

	var $elWidth = ~~($el.outerWidth()),
		$elHeight = ~~($el.outerHeight()),
		docWidth = $(document).width(),
		docHeight = $(document).height();

	// 화면의 중앙에 레이어를 띄운다.
	if ($elHeight < docHeight || $elWidth < docWidth) {
		$el.css({
			marginTop: -$elHeight / 2,
			marginLeft: -$elWidth / 2
		})
	} else {
		$el.css({ top: 0, left: 0 });
	}

	$el.find('a.btn-layerClose').click(function() {
		isDim ? $('.klover-dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
		return false;
	});

	$('.pop-klover .klover-dimBg').click(function() {
		$('.klover-dim-layer').fadeOut();
		return false;
	});

	return false;
}



/****************************************************************************************************** */
/****************************************************************************************************** */
/****************************************************************************************************** */
/*전화번호 인증*/
function phoneCertification() {
	const phone = $("#phone").val();
	if (!phone) {
		alert("전화번호를 입력해 주세요.");
		$("#phone").focus();
		return;
	}
	const phoneValidation =$("#phoneValidation").text();
	if(phoneValidation==="핸드폰 번호를 확인 해주세요."){
		alert(phoneValidation);	
		$("#phone").focus();
		return;
	}
	
	if(phoneValidation==="이미 사용중인 번호입니다."){
		alert(phoneValidation);	
		$("#phone").focus();
		return;
	}
	
	
	
	window.open("/phoneCertification", "auth_popup", "width=450,height=640,scrollbar=yes");
}







/****************************************************************************************************** */
/****************************************************************************************************** */
/****************************************************************************************************** */
/** 다음 주소 처리 */
var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	mapOption = {
		center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
		level: 5 // 지도의 확대 레벨
	};

//지도를 미리 생성
var map = new daum.maps.Map(mapContainer, mapOption);
//주소-좌표 변환 객체를 생성
var geocoder = new daum.maps.services.Geocoder();
//마커를 미리 생성
var marker = new daum.maps.Marker({
	position: new daum.maps.LatLng(37.537187, 127.005476),
	map: map
});


function sample5_execDaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {

			var zoneCode = data.zonecode;

			var addr = data.address; // 최종 주소 변수

			// 주소 정보를 해당 필드에 넣는다.
			document.getElementById("address").value = addr;

			document.getElementById("zoneCode").value = zoneCode;

			// 주소로 상세 정보를 검색
			geocoder.addressSearch(data.address, function(results, status) {
				// 정상적으로 검색이 완료됐으면
				if (status === daum.maps.services.Status.OK) {

					var result = results[0]; //첫번째 결과의 값을 활용

					// 해당 주소에 대한 좌표를 받아서
					var coords = new daum.maps.LatLng(result.y, result.x);
					// 지도를 보여준다.
					mapContainer.style.display = "block";
					map.relayout();
					// 지도 중심을 변경한다.
					map.setCenter(coords);
					// 마커를 결과값으로 받은 위치로 옮긴다.
					marker.setPosition(coords)
				}
			});


			address.addClass("checkedValue");
			address.attr("check", "0");
			addressValidation.text("주소를 입력해주세요.");
			addressValidation.css("color", checkedValueColor);

		}
	}).open();
}

const mmToDate=new Date();
const mmYear=mmToDate.getFullYear()-15;
const mmMonth=mmToDate.getMonth()+1;
const mmDay =mmToDate.getDate();
//document.getElementById('birth').value = new Date().toISOString().substring(0, 10);
document.getElementById('birth').value = mmYear+"-"+(("00"+mmMonth.toString()).slice(-2))+"-"+(("00"+mmDay.toString()).slice(-2));
//`${year}-${month}-${day}`






/****************************************************************************************************** */
/****************************************************************************************************** */
/****************************************************************************************************** */
/*회원가입 input 유효성 체크*/
const autoHyphen = (target) => {
	target.value = target.value
		.replace(/[^0-9]/g, '')
		.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
}
var userIdValidation = $('.userIdValidation');
var emailValidation = $('.emailValidation');
var usernameValidation = $('.usernameValidation');
var birthValidation = $('.birthValidation');
var addressValidation = $('.addressValidation');


var phoneValidation = $('.phoneValidation');

var passwordValidation = $('.passwordValidation');
var passwordReValidation = $('.passwordReValidation');

var userId = $('#userId');
var email = $('#email');
var username = $('#username');
var zoneCode = $('#zoneCode');
var address = $('#address');
var birth = $('#birth');

var phone = $('#phone');
var password = $('#password');
var passwordCheck = $('#passwordCheck');
var checkedValueColor = "#4CAF50";
var usedValueColor = "#ff1744";
var defaultColor = "#aaa";


$(function() {
	$('#userId').on('keyup', function() {
		userId.removeClass("checkedValue");
		userId.removeClass("usedValue");
		userId.attr("check", "1");

		if (userId.val() == "") {
			userIdValidation.text("아이디를 입력해주세요.");
			userIdValidation.css("color", defaultColor);
			return;
		}

		var regType1 = /^[A-Za-z0-9+]*$/;
		if (!regType1.test(userId.val()) || userId.val().length < 4) {
			userId.addClass("usedValue");
			userIdValidation.text("아이디를 영문 숫자 4자이상 12자 이하로 입력해주세요.");
			userIdValidation.css("color", usedValueColor);
			return;
		}


		$.ajax({
			type: "POST",
			dataType: "text",
			data: {
				userId: userId.val()
			},
			url: "/join/checkUserId",
			success: function(result) {
				var d = parseInt($.trim(result));
				if (d == 0) {
					if (userId.val() == "") {
						userIdValidation.text("아이디를 입력해주세요.");
						userIdValidation.css("color", defaultColor);
					} else {
						// 중복 없음
						userId.addClass("checkedValue");
						userId.attr("check", "0");
						userIdValidation.text("사용 가능한 아이디입니다.");
						userIdValidation.css("color", checkedValueColor);
					}
				} else if (d > 0) {
					// 중복 있음
					userId.addClass("usedValue");
					userIdValidation.text("이미 사용 중인 아이디입니다.");
					userIdValidation.css("color", usedValueColor);
				}
			}
		});
	});

	$('#email').on('keyup', function() {
		email.removeClass("checkedValue");
		email.removeClass("usedValue");
		email.attr("check", "1");


		if (email.val() == "") {
			emailValidation.text("이메일을 입력해주세요.");
			emailValidation.css("color", defaultColor);
			return;
		}

		if (CheckEmail(email.val())) {
			emailValidation.text("사용 가능한 이메일입니다.");
			emailValidation.css("color", checkedValueColor);
		} else {
			emailValidation.text("이메일 형식에 맞지 않습니다.");
			emailValidation.css("color", usedValueColor);
			return;
		}

		$.ajax({
			type: "POST",
			dataType: "text",
			data: {
				email: email.val()
			},
			url: "/join/emailDbCheck",
			success: function(result) {
				//console.log(result);

				var d = parseInt($.trim(result));

				if (d == 0) {

					if (email.val() == "") {
						emailValidation.text("이메일을 입력해주세요.");
						emailValidation.css("color", defaultColor);
					} else {
						// 중복 없음
						email.addClass("checkedValue");
						email.attr("check", "0");
						//console.log("사용 가능한 이메일입니다.");
						emailValidation.text("사용 가능한 이메일입니다.");
						emailValidation.css("color", checkedValueColor);
					}

				} else if (d > 0) {
					// 중복 있음
					email.addClass("usedValue");
					emailValidation.text("이미 사용중인 이메일입니다.");
					emailValidation.css("color", usedValueColor);
				}
			}
		});

	});



	$('#phone').on('keyup', function() {
		phone.removeClass("checkedValue");
		phone.removeClass("usedValue");
		phone.attr("check", "1");

		if (phone.val() == "") {
			phoneValidation.text("휴대폰 번호를 입력해 주세요.");
			phoneValidation.css("color", defaultColor);
			return;
		}
		
		
		if(phone.val().length<13){
			phoneValidation.text("휴대폰 번호를 입력해 주세요.");
			phoneValidation.css("color", defaultColor);
			return;
		}
		
		const patternPhone = /01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/;	  
	    if(!patternPhone.test(phone.val())){
		    phoneValidation.text("핸드폰 번호를 확인 해주세요.");
			phoneValidation.css("color", usedValueColor);
	        return;
	    }  
		
		


		

		$.ajax({
			type: "POST",
			dataType: "text",
			data: {
				phone: phone.val()
			},
			url: "/join/phoneDbCheck",
			success: function(result) {
				//console.log(result);

				var d = parseInt($.trim(result));

				if (d == 0) {

					if (phone.val() == "") {
						phoneValidation.text("휴대폰 번호를 입력해 주세요.");
						phoneValidation.css("color", defaultColor);
					} else {
						// 중복 없음
						phone.addClass("checkedValue");
						phone.attr("check", "0");						
						phoneValidation.text("등록 가능한 번호입니다.");
						phoneValidation.css("color", checkedValueColor);
					}

				} else if (d > 0) {
					// 중복 있음
					phone.addClass("usedValue");
					phoneValidation.text("이미 사용중인 번호입니다.");
					phoneValidation.css("color", usedValueColor);
				}
			}
		});

	});




	$('#username').on('keyup', function() {
		username.removeClass("checkedValue");
		username.removeClass("usedValue");
		username.attr("check", "1");

		if (username.val() == "") {
			usernameValidation.text("닉네임을 입력해주세요.");
			usernameValidation.css("color", defaultColor);
			return;
		}
		


/*		username.addClass("checkedValue");
		username.attr("check", "0");
		usernameValidation.text("닉네임을 입력해주세요.");
		usernameValidation.css("color", checkedValueColor);
		*/
			

		$.ajax({
			type: "POST",
			dataType: "text",
			data: {
				username: username.val()
			},
			url: "/join/usernameDbCheck",
			success: function(result) {

				var d = parseInt($.trim(result));

				if (d == 0) {
					if (username.val() == "") {
						usernameValidation.text("닉네임을 입력해주세요.");
						usernameValidation.css("color", defaultColor);
					} else {
						// 중복 없음
						username.addClass("checkedValue");
						username.attr("check", "0");						
						usernameValidation.text("등록 가능한 닉네임 입니다.");
						usernameValidation.css("color", checkedValueColor);
					}

				} else if (d > 0) {
					// 중복 있음
					username.addClass("usedValue");
					usernameValidation.text("이미 사용중인 닉네임 입니다.");
					usernameValidation.css("color", usedValueColor);
				}
			}
		});

		
	});




	$("#address").on("keyup", function() {
		address.removeClass("checkedValue");
		address.removeClass("usedValue");
		address.attr("check", "1");

		if (address.val() == "") {
			addressValidation.text("주소를 입력해주세요.");
			addressValidation.css("color", usedValueColor);
			return;
		}

		address.addClass("checkedValue");
		address.attr("check", "0");
		addressValidation.text("주소를 입력해주세요.");
		addressValidation.css("color", checkedValueColor);
	});


	$("#birth").on("keyup", function() {
		birth.removeClass("checkedValue");
		birth.removeClass("usedValue");
		birth.attr("check", "1");

		if (birth.val() == "") {
			birthValidation.text("생년월일을 입력해주세요.");
			birthValidation.css("color", usedValueColor);
			return;
		}

		birth.addClass("checkedValue");
		birth.attr("check", "0");
		birthValidation.text("생년월일을 입력해주세요.");
		birthValidation.css("color", checkedValueColor);
	});

	$('#password').on('keyup', function() {
		password.removeClass("checkedValue");
		password.removeClass("usedValue");
		password.attr("check", "1");

		if (password.val() == "") {
			passwordValidation.text("비밀번호를 입력해주세요.");
			passwordValidation.css("color", defaultColor);
		} else {

			if (password.val().length < 4) {
				password.addClass("usedValue");
				password.attr("check", "1");
				passwordValidation.text("입력값이 4자리 미만입니다.");
				passwordValidation.css("color", usedValueColor);
			} else {
				password.addClass("checkedValue");
				password.attr("check", "0");
				passwordValidation.text("사용 가능한 비밀번호입니다.");
				passwordValidation.css("color", checkedValueColor);
			}
		}
	});

	$('#passwordCheck').on(
		'keyup',
		function() {
			passwordCheck.removeClass("checkedValue");
			passwordCheck.removeClass("usedValue");
			passwordCheck.attr("check", "1");

			if (passwordCheck.val() == "") {
				passwordReValidation.text("비밀번호를 재확인해주세요.");
				passwordReValidation.css("color", defaultColor);
			}

			if (password.val() != passwordCheck.val()) {
				passwordCheck.addClass("usedValue");
				passwordCheck.attr("check", "1");
				passwordReValidation.text("입력값이 비밀번호와 다릅니다.");
				passwordReValidation.css("color", usedValueColor);
			} else {
				if ((password.val().length >= 4 && passwordCheck
					.val().length >= 4)
					&& (password.val() != "" && passwordCheck
						.val() != "")) {
					passwordCheck.addClass("checkedValue");
					passwordCheck.attr("check", "0");
					passwordReValidation.text("입력값이 일치합니다.");
					passwordReValidation.css("color", checkedValueColor);
				}
			}
		});

})









/****************************************************************************************************** */
/****************************************************************************************************** */
/****************************************************************************************************** */
/*회원가입 버튼 클릭*/
function registerSubmit() {
	
	
	var gender = document.getElementsByName("gender");
	var genderChoice;
	for (var i = 0; i < gender.length; i++) {
		if (gender[i].checked) {
			genderChoice = gender[i].value;
		}
	}

	var membership = document.getElementsByName("membership");
	var membershipChoice;
	for (var i = 0; i < membership.length; i++) {
		if (membership[i].checked) {
			membershipChoice = membership[i].value;
		}
	}


	if (!userId.val()) {
		alert("아이디를 입력해 주세요.");
		userIdValidation.css("color", usedValueColor);
		userId.focus();
		return;
	}

	// id check값 확인
	if (userId.attr("check") == "0") {

		if (email.attr("check") == "1") {
			alert("이메일을 입력해 주세요.");
			emailValidation.css("color", usedValueColor);
			email.focus();
			return;
		}

		if ($("#emailState").val() != "success") {
			alert("이메일 인증처리를 해주세요.");
			return;
		}



		// email check값 확인
		if (email.attr("check") == "0") {
			if (!username.val()) {
				alert("이름을 입력해주세요.");
				usernameValidation.css("color", usedValueColor);
				username.focus();
				return;
			}



			if (!address.val()) {
				alert("주소를 입력해주세요.");
				addressValidation.css("color", usedValueColor);
				address.focus();
				return;
			}


			const phoneAuth=$("#phoneValidation").attr("auth");
			if(phoneAuth!="true"){
				alert("휴대폰 번호를 인증해 주세요.");
				return;		
			}

	

			if (!password.val()) {
				alert("비밀번호를 입력해주세요.");
				passwordValidation.css("color", usedValueColor);
				password.focus();
				return;
			}

			if (!passwordCheck.val()) {
				alert("비밀번호 확인을 입력해주세요.");
				passwordReValidation.css("color", usedValueColor);
				passwordCheck.focus();
				return;
			}


			// 비밀번호 4자 이상 확인
			if (password.attr("check") == "0") {

				//비밀번호 일치여부 확인
				if (passwordCheck.attr("check") == "0") {


					// 회원가입 api ajax 통신
					// 태그에서 check값만 바꾸고 넘길 수도 있으니 api단에서 validation 또 해야함.
					const paramData = {
						userId: userId.val(),
						email: email.val(),
						username: $('#username').val(),
						membership: membershipChoice,
						gender: genderChoice,
						birth: birth.val(),
						zoneCode: zoneCode.val(),
						address: address.val(),
						phone: $('#phone').val(),
						password: password.val(),
						passwordCheck: passwordCheck.val(),
						emailAuthKey:$("#emailAuthKey").val()
					}


					$.ajax({
						type: "POST",
						url: "/join/signup",
						contentType: "application/json",
						data: JSON.stringify(paramData),
						success: function(d) {
							console.log(d);
							// 환영 페이지 이동 				        	
							if ($.trim(d) == "success") {
								//alert("이메일로 인증 코드가 발송 되었습니다.\n이메일 인증후 이용가능합니다.");
								alert("회원 가입을 축하합니다.");
								location.href = "/loginForm";
							} else {
								alert(d);
							}
						},
						error: function(res) {
							console.log("에러");
							//alert("이메일 인증코드 전송에 실패 하였습니다.\n이메일 정보를 확인 바랍니다.");
							console.log(res);
							alert(res.responseText);

						}

					}).done(function(data) {
						console.log("done");
						console.log(data);
					});

				}
			}
		}

	}

	return false;
}


function CheckEmail(str) {
	var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	if (!reg_email.test(str)) {
		return false;
	} else {
		return true;
	}
}









