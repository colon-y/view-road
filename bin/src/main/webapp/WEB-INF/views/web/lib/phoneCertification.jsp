<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko"><head>
<title>휴대폰 안심본인인증 - PASS - 통신사 선택</title>
<meta charset="UTF-8">
<meta http-equiv="Content-Language" content="ko-KR">
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, viewport-fit=cover">
<meta name="format-detection" content="telephone=no">
<link href="/resources/web/phoneCertification/common.css?z=11" media="screen" rel="stylesheet">
<link href="/resources/web/phoneCertification/site.css?z=11" media="screen" rel="stylesheet">
<script src="/resources/web/phoneCertification/jquery-1.11.3.min.js"></script>
<script src="/resources/web/phoneCertification/common.js?z=11"></script>
<script src="/resources/web/phoneCertification/design.js?z=11"></script>
<script src="/resources/web/phoneCertification/vanillaAjax.js?z=11"></script>

<script type="text/javascript">
	var authFormInputFocus = false;
	// 페이지 설정
/* 	document.oncontextmenu = function() {
		return false;
	} */
/* 	document.ondragstart = function() {
		return false;
	} */
	document.onkeydown = function() {
		var eventref = (typeof evt !== "undefined") ? evt : event;
		if (typeof eventref == "undefined") return false;
		var keyCode = eventref.keyCode;

		if (keyCode == "8"){
			//input창에 focus가 없는 경우 backspace키를 막는다
			if(!authFormInputFocus){
				keyCode = 0;
				//event.returnValue = false; 위의 event.keyCode=0셋팅으로도 event 무효화됨
				alert("뒤로가기 버튼은 사용할 수 없습니다");
				return false;
			}
		}
		else if (keyCode == 116) {	// F5
			keyCode = 0;
			return false;
		}
		else if (eventref.ctrlKey == true && (keyCode == 78 || keyCode == 82)) { // Ctrl+N, Ctrl+R
			keyCode = 0;
			return false;
		}
	}
</script>


    




	<script type="text/javascript">
	<!--
	var __KCB_DISABLE_NX_KEY_INSTALL = 'null';
	//-->
	</script>

	<script type="text/javascript" src="/resources/web/phoneCertification/kcbkbd2.js?z=11"></script>


    <script type="text/javascript">
        var processFlag = true;

        function cannotUseMessage ( mblTelCmmCdTemp ){
            var NoSendMsg = new Array();
            NoSendMsg['01']=	"";
            NoSendMsg['02']=	"";
            NoSendMsg['03']=	"";
            NoSendMsg['04']=	"";
            NoSendMsg['05']=	"";
            NoSendMsg['06']=	"";
            if (NoSendMsg[mblTelCmmCdTemp] == null || NoSendMsg[mblTelCmmCdTemp] == "" || NoSendMsg[mblTelCmmCdTemp] == "undefined") {
                return false;
            }

            if( NoSendMsg[mblTelCmmCdTemp].length == 0 ) 	return false;

            alert( NoSendMsg[mblTelCmmCdTemp] );
            return true;
        }

        $(document).ready(function() {

            try {
                winResize();
            }
            catch(e) {}


            // 체크박스 셋팅
            var currAbleNxKeyUse = 'null';
            if('true' == currAbleNxKeyUse) $("#c_install").prop("checked", true);
            else                           $("#c_install").prop("checked", false);

            // 체크박스 클릭시 페이지 리로딩
            $("#c_install").change(function(){
                // 선택된값
                var nkKeyUse = $("#c_install").is(":checked");

                // 페이지 리로딩(통신사 선택화면 CMD)
                var f = document.authForm;
                f.ableNxKeyUse.value = nkKeyUse;
                f.tc.value	= "kcb.oknm.online.main.popup.cmd.P000_NxKeyRedirectCmd";
                f.target	= "_self";
                f.submit();
            });


            // PASS 인증 시작
            $('body').on('click', '#btnPass', function() {
                if(!processFlag) {
                    return;
                }

                // 통신사 선택 여부
                if (agencyCheck() === false) {
                    return;
                }

                // 동의 여부
                if (checkAgree() === false) {
                    return;
                }

                var f = document.authForm;
                var mobileco = getMobileco();

                if (mobileco == '01' || mobileco == '02' || mobileco == '03') {
                    f.tc.value	= "kcb.oknm.online.pass.popup.push.cmd.mno.PS02_PushMno011Cmd";
                }
                else if (mobileco == '04' || mobileco == '05' || mobileco == '06') {
                    f.tc.value	= "kcb.oknm.online.pass.popup.push.cmd.mvno.PS02_PushMvno011Cmd";
                }
                else {
                    alert("통신사를 선택해 주세요.");
                    return;
                }

                f.mbl_tel_cmm_cd.value = mobileco;
                f.target	= "_self";

                processFlag = false;
                f.submit();
            });

            // SMS 인증 시작
            $('body').on('click', '#btnSms', function() {

                // 통신사 선택 여부
                if (agencyCheck() === false) {
                    return;
                }

                // 동의 여부
                if (checkAgree() === false) {
                    return;
                }


                var f = document.authForm;
                var mobileco = getMobileco();

                if (mobileco === '01' || mobileco === '02' || mobileco === '03') {
                    f.tc.value	= "kcb.oknm.online.pass.popup.sms.cmd.mno.PS02_SmsMno011Cmd";
                }
                else if (mobileco === '04' || mobileco === '05' || mobileco === '06') {
                    f.tc.value	= "kcb.oknm.online.pass.popup.sms.cmd.mvno.PS02_SmsMvno011Cmd";
                }
                else {
                    alert("통신사를 선택해 주세요.");
                    return;
                }

                f.mbl_tel_cmm_cd.value = mobileco;
                f.target = "_self";

                processFlag = false;
                f.submit();
            });

            // 초기화
            $('input:radio[name=mobileco]').prop('checked', false);
            $('.check2 input').prop("checked", false).next('label').removeClass('checked');
            $('.btn_skip').removeClass('active');

            // 통신사 선택 + 약관 동의 둘다 체크됐을 경우 인증버튼 활성화
            $('body').on('click', function() {
                var mobilecoCheck = $('input:radio[name=mobileco]').is(':checked') === true;
                var agreeCheck = $('input:checkbox[name=agree]').is(':checked') === true;

                if (mobilecoCheck === true && agreeCheck === true) {
                    $('.btn_skip').addClass('active');
                } else {
                    $('.btn_skip').removeClass('active');
                }
            });

            // 약관 체크 시 통신사 선택 여부 체크
			$('.agreelist').on('change', 'input:checkbox',function(){
				if (agencyCheck() === false) {
					$('.check2 input').prop("checked", false).next('label').removeClass('checked');
				}
			});

            // 통신사 선택 시 (전송불가체크, 버튼셋팅, 약관체크 초기화)
            var checkedMobileco = "";
            $('body').on('click', 'input:radio[name=mobileco]', function(event) {
    
                var mobileco = getMobileco();

                // 통신사 전송불가 체크
                if(cannotUseMessage(mobileco)) {
                    event.preventDefault();
                	return;
                }

				// 버튼셋팅
                if (mobileco == "01" || mobileco == "02" || mobileco == "03") {
                    fnButton('P11390000000', mobileco);
                }

				// 통신사 변경하면 약관체크 초기화
                if (checkedMobileco !== mobileco) {
                    $('.check2 input').prop("checked", false).next('label').removeClass('checked');
                    checkedMobileco = mobileco;
                }

                // 제3자 정보제공 동의 약관 숨기기
                $('#mvnoAgree').hide();
            });

			// 알뜰폰 레이어팝업 선택 버튼
            $('body').on('click', '#mvnoCheck', function(event) {
                // 체크된 경우 값이 유효한지 확인
                var agencyCheck = $("input[type=radio][name=mobilecoPop]:checked").val();
                if (agencyCheck == null || agencyCheck == "" || agencyCheck == "undefined") {
                    alert("알뜰폰 통신사를 선택해주세요.");
                    $('.check2 input').prop("checked", false).next('label').removeClass('checked');
                    return;
                }

                // 통신사 전송불가 체크
                if(cannotUseMessage(agencyCheck)) {
                    event.preventDefault();
					$('body').find('input:radio[name=mobilecoPop]:checked').prop("checked", false);
					$('.check2 input').prop("checked", false).next('label').removeClass('checked');
                	return;
                }

                // 버튼 셋팅
                fnButton('P11390000000', agencyCheck);

                // 제3자 정보제공 동의 약관 보이기
                $('#mvnoAgree').show();

                $('.check2 input').prop("checked", false).next('label').removeClass('checked');
                $('#agency-and').siblings('label').focus();
            });

			// 알뜰폰 레이어팝업 취소 버튼
            $('body').on('click', '#mvnoCancel', function() {
                $('body').find('input:radio[name=mobilecoPop]:checked').prop("checked", false);
                $('.check2 input').prop("checked", false).next('label').removeClass('checked');
                $('#agency-and').siblings('label').focus();
            });

            // 동의문 레이어 팝업
            var btn_agree_popup_focus = '';
            $('body').on('click', '.btn_agree_popup', function() {
                var byId = $(this).attr("id");
                var mobileco = getMobileco();

                // 선택된 통신사가 없는 경우
                if (mobileco == null || mobileco == "" || mobileco == "undefined") {
                    alert('이용중이신 통신사를 선택해주세요.');
                    return false;
                }

                var mobilecoNm = "";
                if ("01" === mobileco || "04" === mobileco) {
                    mobilecoNm = "skt";
                }
                else if ("02" === mobileco || "05" === mobileco) {
                    mobilecoNm = "kt";
                }
                else if ("03" === mobileco || "06" === mobileco) {
                    mobilecoNm = "lgu";
                }

                var url = "";
                // 동의 타이틀 지정
                if (byId === 'agree1Pop') {
                    url = "/eterms/kcb_agrmt_hs_info_"+mobilecoNm+".jsp";
                    $("#agreeTitle").text("개인정보 수집/이용 동의");
                } else if (byId === 'agree2Pop') {
                    url = "/eterms/kcb_agrmt_hs_info.jsp";
                    $("#agreeTitle").text("고유식별정보처리 동의");
                } else if (byId === 'agree3Pop') {
                    url = "/eterms/kcb_agrmt_hs_tos.jsp";
                    $("#agreeTitle").text("서비스 이용약관");
                } else if (byId === 'agree4Pop') {
                    url = "/eterms/kcb_agrmt_hs_tos_"+mobilecoNm+".jsp";
                    $("#agreeTitle").text("통신사 이용약관");
                } else if (byId === 'agree5Pop') {
                    url = "/eterms/kcb_agrmt_hs_offer_"+mobilecoNm+"mvno.jsp";
                    $("#agreeTitle").text("제3자 정보제공 동의");
                }

                // 동의 내용
                $("#agreeIframe").attr("src", url);
                $("#agreeIframe").attr("title", $("#agreeTitle").text()); //iframe에 title을 넣어야함.
                setTimeout(function(){
                    $('#agreeIframe').contents().find('.agreeBox:first').attr('tabindex', '0');
                }, 100);

                // 레이어팝업
                $('.layer-pop.agreement').fadeIn().parent().find('.dim').show();;
                $(".layer-pop").attr('tabindex', '0').focus();


                // 약관버튼
                btn_agree_popup_focus = $(this);
            });

            // iframe 약관 레이어팝업 닫기 시
            $('body').on('click', '.pop-btn .agreeClose', function() {
              // pop_close();
                btn_agree_popup_focus.focus();
            });

            // iframe 약관 레이어팝업 탭 포커스 제어
            $('.layer-pop .agreeClose').keydown(function(event) {
                if (event.keyCode == '9' && !event.shiftKey) {
                    event.preventDefault();
                    $('.layer-pop.agreement').attr('tabindex', '0').focus();/* 2022-04-20 수정 : 웹접근성 */
                }
            });
            // iframe 약관 레이어팝업 탭 포커스 제어
            $('.layer-pop.agreement').keydown(function(event) {/* 2022-04-20 수정 : 웹접근성 */
                if (event.keyCode == '9' && event.shiftKey) {
                    event.preventDefault();
                    $('.layer-pop .agreeClose').attr('tabindex', '0').focus();
                }
            });
        });

        function getMobileco() {
            var mobileco = $('input:radio[name=mobileco]:checked').val();
            if (mobileco ===  "55") {
                mobileco = $('input:radio[name=mobilecoPop]:checked').val();
            }
            return mobileco;
        }

        // 통신사 체크 확인
        function agencyCheck() {
            // 체크 여부 확인
            if ($('input:radio[name=mobileco]').is(':checked') === true) {
                // 체크된 경우 값이 유효한지 확인
                var mobileco = $("input[type=radio][name=mobileco]:checked").val();
                if (mobileco == null || mobileco == "" || mobileco == "undefined") {
                    alert("통신사를 선택해주세요.");
                    return false;
                }

                // 알뜰폰일경우
                if (mobileco === '55') {
                	var mobilecoPop = $("input[type=radio][name=mobilecoPop]:checked").val();
					if (mobilecoPop == null || mobilecoPop == "" || mobilecoPop == "undefined") {
						alert("통신사를 선택해주세요.");
						return false;
					}
                }

                return true;
            } else {
                alert("통신사를 선택해주세요.");
                return false;
            }
        }

        //동의문 체크
        function checkAgree() {
            if ($("#agree1").is(":checked") === false) {
                alert('개인정보이용 동의에 동의해 주십시오.');
                $("#agree1").focus();
                return false;
            }

            if ($("#agree2").is(":checked") === false) {
                alert('고유식별정보 처리 동의에 동의해 주십시오.');
                $("#agree2").focus();
                return false;
            }

            if ($("#agree3").is(":checked") === false) {
                alert('서비스 이용약관 동의에 동의해 주십시오.');
                $("#agree3").focus();
                return false;
            }

            if ($("#agree4").is(":checked") === false) {
                alert('통신사 이용약관 동의에 동의해 주십시오.');
                $("#agree4").focus();
                return false;
            }

            // 알뜰폰인 경우
            var mobileco = getMobileco();
            if (mobileco === '04' || mobileco === '05' || mobileco === '06') {
				if ($("#agree5").is(":checked") === false) {
					alert('제3자 정보제공 동의에 동의해 주십시오.');
					$("#agree5").focus();
					return false;
				}
			}

            return true;
        }

		$(window).load(function(){

		});

    </script>
</head>

<body>
    <div id="wrap" style="padding-bottom: 53px;">
        <header id="header" class="step1header">
            <h1>
                <a href="#"
                style="width: 78px;height: 25px;"
                
                ><img src="/resources/web/phoneCertification/logo_pass.png" alt="PASS"></a>
            </h1>
        </header>

        <section id="ct">
            <form name="authForm" action="#" method="post" onsubmit="return false;" autocomplete="off">
                <input type="hidden" name="tc">
                <input type="hidden" name="idcf_mbr_com_cd" value="P11390000000">	
                <input type="hidden" name="rqst_data" value="6RGc24x4t543To3A48FtI2HObjBhfchkOi8UA5j5B2EDug//W9G8p+G0MCZG+VcoMD45qvLZk9L8ysaTIh60W6hUsmj1IaYpEAlfSX/I/tZrf38Ocr289HAucbTaoWi++rkt/7YODiDnAGjXF48U8qBM7TuDYTLIR38nr+lGhfU=">		
                <input type="hidden" name="target_id" value="">		
                <input type="hidden" name="mbl_tel_cmm_cd" value="">					
                <!-- 키보드보안 페이지 리로딩용으로 추가함 -->
                <input type="hidden" name="ableNxKeyUse" value="">					
                <fieldset class="ui_cover agency_select">
                    <p>이용중이신 통신사를 선택해주세요.</p>
                    <legend>통신사 선택</legend>
                    <ul class="agency_select__items">
                        <li>
                            <input type="radio" name="mobileco" id="agency-sk" value="01" title="SK telecom">
                            <label for="agency-sk" class="ui_align_mid checked">
                                <span class="blind">SK telecom</span><!-- 2022-02-03 추가 : 웹접근성 -->
                                <span class="ele">
                                    <img src="/resources/web/phoneCertification/logo_sk.png" alt="SK telecom" class="active firstChild">
                                    <img src="/resources/web/phoneCertification/logo_sk_gray.png" alt="SK telecom " class="lastChild">
                                </span>
                            </label>
                        </li>
                        <li>
                            <input type="radio" name="mobileco" id="agency-kt" value="02" title="KT">
                            <label for="agency-kt" class="ui_align_mid checked">
                                <span class="blind">kt</span><!-- 2022-02-03 추가 : 웹접근성 -->
                                <span class="ele">
                                    <img src="/resources/web/phoneCertification/logo_kt.png" alt="kt" class="active firstChild">
                                    <img src="/resources/web/phoneCertification/logo_kt_gray.png" alt="kt " class="lastChild">
                                </span>
                            </label>
                        </li>
                        <li>
                            <input type="radio" name="mobileco" id="agency-lgu" value="03" title="LG U+">
                            <label for="agency-lgu" class="ui_align_mid checked">
                                <span class="blind">LG U+</span><!-- 2022-02-03 추가 : 웹접근성 -->
                                <span class="ele">
                                    <img src="/resources/web/phoneCertification/logo_lgu.png" alt="LG U+" class="active firstChild">
                                    <img src="/resources/web/phoneCertification/logo_lgu_gray.png" alt="LG U+ " class="lastChild">
                                </span>
                            </label>
                        </li>
                        <li>
                            <input type="radio" name="mobileco" id="agency-and" value="55" title="알뜰폰 레이어 팝업 열기" class="pop-btn">
                            <label for="agency-and" class="ui_align_mid checked">
                                <span class="blind">알뜰폰</span><!-- 2022-02-03 추가 : 웹접근성 -->
                                <span class="ele">
                                    <img src="/resources/web/phoneCertification/logo_and.png" alt="알뜰폰" class="active firstChild">
                                    <img src="/resources/web/phoneCertification/logo_and_gray.png" alt="알뜰폰" class="lastChild">
                                </span>
                            </label>
                        </li>
                    </ul>

                    <!-- 전체동의 -->
                    <ul class="agreelist all">
                        <li><span class="checkbox check2"><input type="checkbox" name="agree" id="agree_all">
                        <label for="agree_all" id="agree_all_label">전체 동의하기</label><label for="agree_all">전체 동의</label></span></li>
                    </ul>

                    <!-- 필수항목 -->
                    <ul class="agreelist required">
                        <li>
                            <span class="checkbox check2">
                                <input type="checkbox" name="agree1" id="agree1" value="Y">
                                <label for="agree1">개인정보이용동의</label>
                                <button type="button"  title="개인정보이용동의 레이어 팝업 열기">개인정보이용동의</button>
                            </span>
                        </li>
                        <li>
                            <span class="checkbox check2">
                                <input type="checkbox" name="agree2" id="agree2" value="Y"><label for="agree2">고유식별정보처리동의</label>
                                <button type="button"   title="고유식별정보처리동의 레이어 팝업 열기">고유식별정보처리동의</button>
                            </span>
                        </li>
                        <li>
                            <span class="checkbox check2">
                                <input type="checkbox" name="agree3" id="agree3" value="Y"><label for="agree3">서비스이용약관동의</label>
                                <button type="button"  title="서비스이용약관동의 레이어 팝업 열기">서비스이용약관동의</button>
                            </span>
                        </li>
                        <li>
                            <span class="checkbox check2">
                                <input type="checkbox" name="agree4" id="agree4" value="Y"><label for="agree4">통신사이용약관동의</label>
                                <button type="button"  id="agree4Pop" title="통신사이용약관동의 레이어 팝업 열기">통신사이용약관동의</button>
                            </span>
                        </li>
                        <!-- 2022-10-04 추가 s -->
                        <li id="mvnoAgree" hidden="hidden">
                            <span class="checkbox check2">
                                <input type="checkbox" name="agree5" id="agree5" value="Y"><label for="agree5">제3자 정보제공 동의</label>
                                <button type="button"  id="agree5Pop" title="제3자 정보제공 동의 레이어 팝업 열기">제3자 정보제공 동의</button>
                            </span>
                        </li>
                        <!-- //2022-10-04 추가 e -->
                    </ul>

                    <span ><!--  class="_button_area_" -->
                        <button type="button"  class="btn_r btn_type6 btn_r btn_skip"
                        	onclick="authConfirm()"
                        >인증하기</button>
                        
                    </span>
                    
                    <script type="text/javascript">
                    	function authConfirm(){  
                    		const agreeAllLabel=document.getElementById("agree_all_label");
                    		const checkClassName=agreeAllLabel.className;

                    		
                    		if(checkClassName!="checked"){
                    			alert("전체 동의를 체크해 주세요.");
                    			return;	
                    		}
                    		
                    		alert("인증번호가 발송 되었습니다.");                    		
                    		setTimeout(()=>{
                        		alert("인증 처리 되었습니다.");                    		
                        		opener.document.getElementById("phone").setAttribute('readonly', 'ture');
                        		opener.document.getElementById("phoneValidation").innerText="전화번호 인증 완료";
                        		opener.document.getElementById("phoneValidation").style.color="rgb(76, 175, 80)";  
                        		opener.document.getElementById("phoneValidation").setAttribute("auth", true);  
                        		opener.document.getElementById("phoneCertification-btn").setAttribute('onclick', 'alert("인증처리 되었습니다.");'); 
                        		opener.document.getElementById("phoneCertification-btn").style.background="#9e9e9e";  
                        		self.close();
                    		},1000);
                    		
                    	}
                    	
                    </script>
                    
                </fieldset>
            </form>
<div style="margin-bottom: 30px"></div>
<!--             <div class="ceri_last_wrap security_guide_txt" id="touchEnKeyBox">
                <p class="cau">
                    <label for="c_install">안전한 본인 확인을 위해 키보드 보안 프로그램을 설치해주세요.</label>
                    <input type="checkbox" name="" id="c_install">
                    <label for="c_install"></label>
                </p>
            </div> -->
        </section>


		<!-- 푸터 영역 -->
		


        <div id="footer">
            <div class="copyright">
                <div class="certifyBox">
                    <img src="/resources/web/phoneCertification/certify_mark.png" alt="한국 웹접근성 인증평가원 SOFTWARE ACCESSIBILITY 마크(소프트웨어 접근성 품질인증 마크)" title="한국 웹접근성 인증평가원 : KIWAC">
                </div>
                <div class="copyrightInner">
                    <!-- 이용약관 -->
                    <a href="#" class="footerAgreePop" id="footerAgree01" data-cd="006020003" title="이용약관 레이어 팝업 열기"><span>이용약관</span></a>

                    <!-- 개인정보취급방침 -->
                    <a href="#" class="footerAgreePop" id="footerAgree02" data-cd="006070003" title="개인정보처리방침 레이어 팝업 열기"><span class="bold">개인정보처리방침</span></a>

                    <br>

                    VeriSign 256-bit SSL 암호화 적용
                </div>
                <div class="footer_logo">
                    <img src="/resources/web/phoneCertification/copyright_small.png" alt="KCB">
                </div>
            </div>
        </div>

        <!-- 약관 레이어-->
        <div class="layerPopupWrap" id="layerAgreePopFooter">
            <div class="dim"></div>
            <div class="layer-pop agreementFooter">

            </div>
        </div>
        <!-- // 약관 레이어-->

		<!-- // 푸터 영역 -->

        <!-- 알뜰폰 레이어 팝업 -->
        <div class="layerPopupWrap">
            <div class="dim"></div>
            <div class="layer-pop agency_select__popup">
                <div class="pop-tit">알뜰폰 사업자를 선택해주세요.</div>
                <div class="pop-con_02">
                    <ul class="licensee-list">
                        <li class="first-item">
                            <div class="licensee_title">
                                <a href="#">
                                    <input type="radio" name="mobilecoPop" id="agency-popup-sk" value="04" title="SKT(알뜰폰) 선택">
                                    <label for="agency-popup-sk" class="checked">
                                        <span class="ele sk"><img src="/resources/web/phoneCertification/logo_sk.png" alt="SK telecom"></span>
                                        <span class="ele_title">사업자목록 <i class="icon_arrow down"></i> </span>
                                    </label>
                                </a>
                            </div>
                            <div class="licensee_info">
                                <p>티플러스, 아이즈모바일, 모빙, 이야기모바일, 스마텔, SK세븐모바일, 이마트알뜰폰, 안심모바일, 프리티, 헬로모바일, 조이텔, 마이월드, 리브모바일</p>
                            </div>
                        </li>
                        <li class="">
                            <div class="licensee_title">
                                <a href="#">
                                    <input type="radio" name="mobilecoPop" id="agency-popup-kt" value="05" title="KT(알뜰폰) 선택">
                                    <label for="agency-popup-kt" class="checked">
                                        <span class="ele kt"><img src="/resources/web/phoneCertification/logo_kt.png" alt="KT"></span>
                                        <span class="ele_title">사업자목록 <i class="icon_arrow down"></i> </span>
                                    </label>
                                </a>
                            </div>
                            <div class="licensee_info">
                                <p>LG헬로비전(헬로모바일), 세종텔레콤(스노우맨), 씨앤커뮤니케이션(WMVNO), 에넥스텔레콤(A mobile), 프리텔레콤(프리티), 코드모바일(이지모바일), KT파워텔, 위너스텔(Well), ACN코리아(플래시모바일), 앤알커뮤니케이션(앤텔레콤), 에스원(안심모바일), 아이즈비전(아이즈모바일), KT M모바일(M모바일), 유니컴즈(모빙), 더원플랫폼(IplusU), 스테이지파이브(핀플레이), 드림라인(드림모바일), 한국케이블텔레콤(TPLUS), 와이엘랜드(여유알뜰폰), 큰사람커넥트(이야기모바일), 니즈텔레콤(니즈텔레콤), KT스카이라이프(스카이라이프모바일), 에이프러스(아시아모바일), 한국피엠오(주)(밸류컴), (주)스마텔, 토스모바일</p>
                            </div>
                        </li>
                        <li class="">
                            <div class="licensee_title">
                                <a href="#">
                                    <input type="radio" name="mobilecoPop" id="agency-popup-lgu" value="06" title="LGU+(알뜰폰) 선택">
                                    <label for="agency-popup-lgu" class="checked">
                                        <span class="ele lgu"><img src="/resources/web/phoneCertification/logo_lgu.png" alt="LG U+"></span>
                                        <span class="ele_title">사업자목록 <i class="icon_arrow down"></i> </span>
                                    </label>
                                </a>
                            </div>
                            <div class="licensee_info">
                                <p>프리티, 서경모바일, 여유텔레콤, 플래시모바일, 이지톡, 모빙, 이야기모바일, 스마텔, A모바일, 온국민폰, 셀모바일, 조이텔, 아이즈모바일, 에스원안심모바일, 원텔레콤, 리브엠 (Liiv M), 헬로모바일, 밸류컴, 엔티온텔레콤, 스노우맨, 앤텔레콤, 제주방송, 이마트, 도시락모바일, 인스코리아, 니즈텔레콤, 아시아모바일, 슈가모바일, 코나아이, 토스모바일(주), (주)미디어로그(U+유모바일)</p>
                            </div>
                        </li>
                    </ul>
                </div>

                <div class="pop-btn pop-btn_02">
                    <ul>
                        <li class="firstChild activeLightGray">
                        <button type="button" id="mvnoCancel" onclick="pop_close()">취소</button></li>
                        <li class="lastChild activeDarkGray">
                        <button type="button" id="mvnoCheck" onclick="pop_close()">선택</button></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 약관 레이어-->
        <div class="layerPopupWrap" id="layerAgreePop">
            <div class="dim"></div>
            <div class="layer-pop agreement">
                <div class="pop-tit" id="agreeTitle"></div>
                <div class="pop-con">
                    <!-- 약관 S -->
                    <iframe id="agreeIframe" name="agreeIfram" src="" frameborder="0" style="width:100%;height:340px"></iframe>
                    <!-- //약관 E -->
                </div>
                <div class="pop-btn wide">
                    <ul>
                        <li class="lastChild defaultBtn DefaultBtn">
                            <button class="close agreeClose">닫기</button>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>








<script>
    $(function() {
        /* 알뜰폰 선택 시 레이어팝업 */
        $('#agency-and').click(function() {
			

            $('.dim').show();
            $('.agency_select__popup').fadeIn();
            $('.layer-pop').attr('tabIndex', '0').focus();/* 2022-04-20 수정 : 웹접근성 */
        });

        $('.agency_select__popup .close').click(function() {
			$('.licensee-list li').removeClass('active');
			$('.licensee_info').stop().slideUp();
			$(this).find('.icon_arrow').removeClass('up');
			$(this).find('.icon_arrow').addClass('down');
			$(this).find('input:radio[name=mobilecoPop]').prop("checked", false);
        });

        /* 통신사 슬라이드UP/DOWN */
        $('.licensee_title').on('click', function(e) {
            e.preventDefault();

            var licenseeActive = $('.licensee-list li').hasClass('active');
            var licenseeInfo = $(this).siblings('.licensee_info');

			$('.licensee_info').attr('tabindex', '0')
            $('.licensee_info').stop().slideUp().parent().siblings('li').find('a').removeAttr('title');
            $('.icon_arrow').removeClass('up');
            $('.icon_arrow').addClass('down');

            if (licenseeActive == true) {
                if ($(this).parent('li').hasClass('active')) {
                    $('.licensee-list li').removeClass('active');
                    $('.licensee_info').stop().slideUp().parent().siblings('li').find('a').removeAttr('title');
                    $(this).find('.icon_arrow').removeClass('up');
                    $(this).find('.icon_arrow').addClass('down');
                    $(this).find('input:radio[name=mobilecoPop]').prop("checked", false);
                } else {
                    $('.licensee-list li').removeClass('active');
                    $('.licensee_info').stop().slideUp().parent().siblings('li').find('a').removeAttr('title');
                    $(this).parent('li').addClass('active');
                    licenseeInfo.stop().slideDown().parent().find('a').attr('title' , '선택됨');
                    $(this).find('.icon_arrow').removeClass('down');
                    $(this).find('.icon_arrow').addClass('up');
                    $(this).find('input:radio[name=mobilecoPop]').prop("checked", true);
                }
            } else if (licenseeActive == false) {
                $(this).parent('li').addClass('active');
                licenseeInfo.stop().slideDown().parent().find('a').attr('title' , '선택됨');

                $(this).find('.icon_arrow').removeClass('down');
                $(this).find('.icon_arrow').addClass('up');

                if (licenseeActive == true) {
                    $('.licensee_title').on('click', function(e) {
                        e.preventDefault();
                        $('.licensee-list li').removeClass('active');
                        $('.licensee_info').stop().slideUp().parent().siblings('li').find('a').removeAttr('title');
                        $(this).find('.icon_arrow').removeClass('up');
                        $(this).find('.icon_arrow').addClass('down');
                    });
                    return false;
                }
                $(this).find('input:radio[name=mobilecoPop]').prop("checked", true);
            }
        })
    });

	function fnButton(idcfMbrComCd, mblTelCmmCd, e){
		$.ajax({
			method: "POST",
			url: "/CommonSvl",
			data: "idcf_mbr_com_cd="+idcfMbrComCd+"&mbl_tel_cmm_cd="+mblTelCmmCd+"&device_type=pc&tc=kcb.oknm.online.main.popup.cmd.P811_ButtonCmd"
		})
		.done(function(html) {
			$('._button_area_').html(html);
		});
	}

</script>
</body></html>