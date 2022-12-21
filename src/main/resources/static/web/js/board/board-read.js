var marker = null;
var latitude =$("#latitude").val();
var longitude =$("#longitude").val();
if(!latitude){
	latitude=37.57060;	
}
if(!longitude){
   longitude=126.97668;
}

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
		level: 4, // 지도의 확대 레벨
		mapTypeId: kakao.maps.MapTypeId.ROADMAP // 지도종류
	};
// 지도를 생성한다 
var map = new kakao.maps.Map(mapContainer, mapOption);


// 지도 타입 변경 컨트롤을 생성한다
var mapTypeControl = new kakao.maps.MapTypeControl();
// 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
// 지도에 확대 축소 컨트롤을 생성한다
var zoomControl = new kakao.maps.ZoomControl();
// 지도의 우측에 확대 축소 컨트롤을 추가한다
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
// 지도 중심 좌표 변화 이벤트를 등록한다
kakao.maps.event.addListener(map, 'center_changed', function() {
	//console.log('지도의 중심 좌표는 ' + map.getCenter().toString() +' 입니다.');
});
// 지도 확대 레벨 변화 이벤트를 등록한다
kakao.maps.event.addListener(map, 'zoom_changed', function() {
	//console.log('지도의 현재 확대레벨은 ' + map.getLevel() +'레벨 입니다.');
});
// 지도 영역 변화 이벤트를 등록한다
kakao.maps.event.addListener(map, 'bounds_changed', function() {
	var mapBounds = map.getBounds(),
		message = '지도의 남서쪽, 북동쪽 영역좌표는 ' +
			mapBounds.toString() + '입니다.';
	//console.log(message); 
});
// 지도 시점 변화 완료 이벤트를 등록한다
kakao.maps.event.addListener(map, 'idle', function() {
	var message = '지도의 중심좌표는 ' + map.getCenter().toString() + ' 이고,' +
		'확대 레벨은 ' + map.getLevel() + ' 레벨 입니다.';
	//console.log(message);
});
// 지도 클릭 이벤트를 등록한다 (좌클릭 : click, 우클릭 : rightclick, 더블클릭 : dblclick)
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
	//console.log('지도에서 클릭한 위치의 좌표는 ' + mouseEvent.latLng.toString() + ' 입니다.');
});
// 지도 드래깅 이벤트를 등록한다 (드래그 시작 : dragstart, 드래그 종료 : dragend)
kakao.maps.event.addListener(map, 'drag', function() {
	var message = '지도를 드래그 하고 있습니다. ' +
		'지도의 중심 좌표는 ' + map.getCenter().toString() + ' 입니다.';
	//console.log(message);
});

function myMap(myPosition, positionName) {

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(myPosition, function(result, status) {


		// 정상적으로 검색이 완료됐으면 
		if (status === kakao.maps.services.Status.OK) {

			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);


			var imageSrc = '/resources/web/images/marker_red.png', // 마커이미지의 주소입니다    
				imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
				imageOption = { offset: new kakao.maps.Point(27, 69) }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

			// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
				markerPosition = new kakao.maps.LatLng(result[0].y, result[0].x); // 마커가 표시될 위치입니다


			// 마커를 생성합니다
			marker = new kakao.maps.Marker({
				position: markerPosition,
				image: markerImage // 마커이미지 설정 
			});


			// 인포윈도우로 장소에 대한 설명을 표시합니다
			var infowindow = new kakao.maps.InfoWindow({
				content: '<div style="width:150px;text-align:center;padding:6px 0; border:3px solid #EB6868;font-size:16px;font-weight:bold">' + positionName + '</div>'
			});
			infowindow.open(map, marker);


			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);

			// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			map.setCenter(coords);
			// 마커를 결과값으로 받은 위치로 옮긴다.
			marker.setPosition(coords);
			
		
			
		}
	});

	

}

if($("#latitude").val() && $("#longitude").val()){

			var coords = new kakao.maps.LatLng(latitude, longitude);

			var imageSrc = '/resources/web/images/marker_red.png', // 마커이미지의 주소입니다    
				imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
				imageOption = { offset: new kakao.maps.Point(27, 69) }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

			// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
				markerPosition = new kakao.maps.LatLng(latitude, longitude); // 마커가 표시될 위치입니다


			// 마커를 생성합니다
			marker = new kakao.maps.Marker({
				position: markerPosition,
				image: markerImage // 마커이미지 설정 
			});


			// 인포윈도우로 장소에 대한 설명을 표시합니다
			var infowindow = new kakao.maps.InfoWindow({
				content: '<div style="width:150px;text-align:center;padding:6px 0; border:3px solid #EB6868;font-size:16px;font-weight:bold">' + $("#place").val() + '</div>'
			});
			infowindow.open(map, marker);

const bno=$("#bno").val();
const title=$("#title").val();
const place=$("#place").val();
const fileName=$("#fileName").val();
const address=$("#address").val();
const username=$("#board_username").val();
const createdDate=$("#createdDate").val();
const customDate=$("#customDate").val();
const likeCnt=$("#likeCnt").val();
const viewCnt=$("#viewCnt").val();
const replyCnt=$("#replyCnt").val();



content = `<div class="overlaybox" id="overlaybox-${bno}" onmouseover="overlayboxOver('${bno}')">
        <div class="boxtitle"  onclick="openNewWindow('${address}')" >${place}</div>
        <div class="first" style="background:url('/displayFile?fileName=${fileName}') no-repeat;" >        
       
            <div class="triangle text">${bno}</div>
            <div class="movietitle text">${title}</div>
        </div>
        <ul>
            <li class="up">
            <span><i class="fa fa-map-marker"></i> : ${address}</span>             
            </li>
             <li class="up">
            	<span><i class="fa fa-user"></i> : ${username}</span>              
            </li>
             <li class="up" style="display:flex; justify-content: space-between;">
            	<span><i class="fa fa-calendar"></i> : ${createdDate}</span> 
            	<span><i class="fas fa-hourglass-end"></i>  : ${customDate}</span>             	          
            </li>  
            <li class="up" style="display:flex; justify-content: space-between;">
            	<span><img class="board-star-img" src="/resources/web/images/star_grey.png"> : ${likeCnt}</span> 
            	<span ><i class="fa fa-eye"></i> : ${viewCnt}</span>   
            	<span ><i class="fa fa-comments"></i> : ${replyCnt}</span>                	          
            </li> 
        </ul>
    </div>
    <div class="marker-img" id="markerImg-${bno}" style="display:none">
    	<img src="/resources/web/images/marker_red.png">
    </div>
    
    `;


// 커스텀 오버레이를 생성합니다
var customOverlay = new kakao.maps.CustomOverlay({
    position: markerPosition,
    content: content,
    xAnchor: 0.3,
    yAnchor: 0.91
});



	// 커스텀 오버레이를 지도에 표시합니다
	customOverlay.setMap(map);

			// 마커가 지도 위에 표시되도록 설정합니다
			//marker.setMap(map);

			// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			map.setCenter(coords);
			// 마커를 결과값으로 받은 위치로 옮긴다.
			marker.setPosition(coords);
			
			$("button[title='스카이뷰']").click();
		
		
		
				
}else{
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	myMap($("#address").val(), $("#place").val());	
	$("button[title='스카이뷰']").click();
}



////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

var mapTypes = {
	terrain: kakao.maps.MapTypeId.TERRAIN,
	traffic: kakao.maps.MapTypeId.TRAFFIC,
	bicycle: kakao.maps.MapTypeId.BICYCLE,
	useDistrict: kakao.maps.MapTypeId.USE_DISTRICT
};


function openNewWindow(q){
	var openNewWindow = window.open("about:blank");
	openNewWindow.location.href = "https://map.kakao.com/?q="+q;
}


// 체크 박스를 선택하면 호출되는 함수입니다
function setOverlayMapTypeId() {
	var chkTerrain = document.getElementById('chkTerrain'),
		chkTraffic = document.getElementById('chkTraffic'),
		chkBicycle = document.getElementById('chkBicycle'),
		chkUseDistrict = document.getElementById('chkUseDistrict');

	// 지도 타입을 제거합니다
	for (var type in mapTypes) {
		map.removeOverlayMapTypeId(mapTypes[type]);
	}

	// 지적편집도정보 체크박스가 체크되어있으면 지도에 지적편집도정보 지도타입을 추가합니다
	if (chkUseDistrict.checked) {
		map.addOverlayMapTypeId(mapTypes.useDistrict);
	}

	// 지형정보 체크박스가 체크되어있으면 지도에 지형정보 지도타입을 추가합니다
	if (chkTerrain.checked) {
		map.addOverlayMapTypeId(mapTypes.terrain);
	}

	// 교통정보 체크박스가 체크되어있으면 지도에 교통정보 지도타입을 추가합니다
	if (chkTraffic.checked) {
		map.addOverlayMapTypeId(mapTypes.traffic);
	}

	// 자전거도로정보 체크박스가 체크되어있으면 지도에 자전거도로정보 지도타입을 추가합니다
	if (chkBicycle.checked) {
		map.addOverlayMapTypeId(mapTypes.bicycle);
	}

}

////지도 끝



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////


$(document).ready(function(){	
	//추천 like 불러오기
	 getLike();
	 //댓글 불러오기
	 replyList();
	
	$('.board-edit-input').focusin(function() {
		$(this).css("border", "1px solid #607d8b");
	});

	$('.board-edit-input').focusout(function() {
		$(this).css("border", "1px solid #ececec");
	});

	
//////////////////////////////
	//로그인 후 게시판 작성한 한 유저
//////////////////////////////
	
		$('.editBoardLoginedUser').click(function(){	
			var sId =$("#USER_userId").val();
			var bId=$("#board_userId").val();
			var isAdmin=$("#isAdmin").val();
			if(sId != bId && isAdmin=="false") {			
				alert("관리자 또는 글작성자만 게시글만 삭제 가능합니다.");	
				return;
				
			}else {		
				$("#directForm").submit();
			}
		});

		
		$('.deleteBoardLoginedUser').click(function(){
			var sId =$("#USER_userId").val();
			var bId=$("#board_userId").val();
			var isAdmin=$("#isAdmin").val();
			if(sId != bId && isAdmin=="false") {
				alert("관리자 또는 글작성자만 게시글만 삭제 가능합니다.");	
				return;
			}else {					
				if (confirm("정말 삭제하시겠습니까?")) {
					$.ajax({
						type: "POST",
						dataType: "text",
						url: $("#board_url").val()+"/removeDirect",
						data: {
							bno: $("#bno").val()
						},
						success: function (result) {		
							if ($.trim(result) == "SUCCESS") {
								//tSuccess("삭제 처리 되었습니다.");
								location.href=$("#board_url").val()+"/list";
							} else 
								alert(msg);
						}
					});
				}			
			}			
		});

//////////////////////////////
			//비밀번호로 게시판 작성한  유저
//////////////////////////////

		var modal = $('#boardModal');
		var tip = $('.board-edit-tip');
		var title = $('.modal-title');
		var body = $('.modal-body');
		var editType = $('.editType');
		
		$('.editBoard').click(function() {
			editType.text("1");
			title.text("게시글 수정");
			$("#modalSubmit").val("수정");
			$(".board-edit-input").val("");
			tip.empty();
			tip.append("<p class='board-edit-tip'>* 작성 시 입력하신 비밀번호를 입력해주세요.</p>");
		});

		$('.deleteBoard').click(function() {
			editType.text("2");
			title.text("게시글 삭제");
			$("#modalSubmit").val("삭제");
			$(".board-edit-input").val("");
			tip.empty();
			tip.append("<p class='board-edit-tip'>* 작성 시 입력하신 비밀번호를 입력해주세요.</p>");
		});
		
		
		
		
		

		$('.board-edit-submit').click(function() {
			var boardPassword = $('.board-edit-input').val();
			var type = $('.editType').text();
			var section = $('#editType').text();

			if(boardPassword==""){
				alert("비밀번호를 입력해 주세요.");
				$('.board-edit-input').focus();
				return;
			}
			
			if(type=='1'){				
				$.ajax({
					url:"/board/passwordConfirm",
					type:"post",
					dataType:"text",
					data:{
						bno:$("#bno").val(),
						boardPassword:boardPassword			
					},
					success:function(result){	
						console.log(result);
						var re= $.trim(result);	
						if(re==0){
							alert("비밀번호가 일치하지 않습니다.");
							$('.board-edit-input').val("");
							return;
						}
						
						if(re==1){
							$("#directForm").attr("action", "/board/boardEdit");
							$("#formPw").val(boardPassword);
							$("#directForm").submit();
						}
						
					},error:function(result){
						console.log(result);
						
					}
				});									
				
			}
			
			
			if(type=='2'){
				$.ajax({
					url:"/board/passwordConfirm",
					type:"post",
					dataType:"text",
					data:{
						bno:$("#bno").val(),
						boardPassword:boardPassword			
					},
					success:function(result){	
						console.log(result);
						var re= $.trim(result);	
						if(re==0){
							alert("비밀번호가 일치하지 않습니다.");
							return;
						}
						
						
						if(re==1){
							$.ajax({
								type: "POST",
								dataType: "text",
								url: $("#board_url").val()+"/remove",
								data: {
									bno: $("#bno").val(),
									boardPassword:boardPassword
								},
								success: function (result) {		
									if ($.trim(result) == "SUCCESS") {
										alert("삭제되었습니다.");
										location.href="/board/list";
									} else 
										alert(msg);
								}
							});
						}
						
					},error:function(result){
						console.log(result);
						
					}
				});									
				
				
			}
			
			
		});	

		
//////////////////////////////
//////////////////////////////
		
	// 추천/추천취소 버튼 클릭 시 이벤트 
	$('#boardThumb').click(function (e) {
		e.preventDefault();
		
		const uid=$("#USER_uid").val();
		if(!uid){
			alert("로그인후 이용 가능합니다.")
			return; 
		}
		
		$.ajax({
			type: "POST",
			dataType: "text",
			data:{
				bno:$("#bno").val(),
				uid:uid
			},
	        url: "/like/update",
	        success:function(result){	        	
	        	let cnt =Number($("#likeCount").val());
	        	console.log(" result : ", result,  cnt);
	        	let html ='';
	        	if(Number(result)===1){
	        		cnt=cnt+1;
	        		html +='<img class="board-star-img" src="/resources/web/images/star.png">';
	        		html +='<div style="color: #999; display: inline;">추천 취소</div> ';
	        		html +='<input type="hidden" id="likeCount" value="'+cnt+'">';
	        		
	        	}else if(Number(result)===0){
	        		cnt=cnt-1;	        		
	        		html +='<img class="board-star-img" src="/resources/web/images/star_grey.png">'; 
	        		html +='<span style="color: #999;">추천</span>';     
	        		html +='<input type="hidden" id="likeCount" value="'+cnt+'">';		        		
	        	}
	        	$('#boardThumb').html(html);
	        	$("#topLikeCount").html("<img class='board-star-img' src='/resources/web/images/star_grey.png'>"+cnt+"</span>");
	        	
	        }, error: function (result) {
	        	console.log(result);
	        }
		});
	});
		

	
//////////////////////////////
//////////////////////////////댓글 



  //댓글 등록
  $("#clicktoshow3").on("click", function(e){
	   var sessionCheck=$("#USER_userId").val();
		console.log(sessionCheck);
	   var bno =$("#bno").val();
	   var content=$("#submitbtn").val();

		   
	  if(content==""){
		  alert("내용을 입력해 주세요.");
		  return;
	  }
		
	   if(sessionCheck==""){
		   var username=$("#clicktoshow1").val();
		   var replyPassword=$("#clicktoshow2").val();
		   
		   if(username==""){
			   alert("작성자를 입력해 주세요.");
			   return;
		   }
		   
		   if(replyPassword==""){
			   alert("비밀번호를 입력해 주세요.");
			   return;
		   }
	   }
	  
	  
		$.ajax({
			url:"/board/replies/create",
	        type:"post",
			data :{
				bno:  bno,
				content: content,
				username:username,
				replyPassword:replyPassword
			},
			dataType:'text',		
			success:function(result){
				if(result=="success"){
					replyList();
					tSuccess("등록 되었습니다.");
					$("#submitbtn").val("");
					$("#clicktoshow1").val("");
					$("#clicktoshow2").val("");
					
				}else{
					console.dir(result);	
				}
			},
			error:function(result){
				console.dir(result);
			}
		});
	  
  });





	$('.board-view-desc img').css('cursor', 'pointer');
	$('.board-view-desc img').click(function() {
		var url = $(this).attr('src');

		if (url.indexOf("http") != -1) {
			window.open(url, '_blank');
		} else { 
			window.open("/"+url, '_blank');
		}
	});




	$("#modalSubmit2").on("click", function(){
		var rno=$("#modalRno").val();
		var replyPassword=$("#modalPassword").val();		
		if(replyPassword==""){
			alert("비밀번호를 입력해 주세요.");
			return;
		}
		$.ajax({
			url:"/board/replies/removePassowrd/"+rno,
			type:"post",
			dataTye:"text",
			data:{
				rno:rno,
				replyPassword:replyPassword
			},
			success:function(result){
				if($.trim(result)=="SUCCESS"){
					alert("삭제 했습니다.");
					location.reload();
				}else{
					alert("비밀번호가 일치하지 않습니다.");
					$("#modalPassword").val("");
				}
			},
			error:function(result){
				alert("비밀번호가 일치하지 않습니다.");
				$("#modalPassword").val("");
			}			
		});		
		
	});
	
	
	
	//쪽지 보내기
	$(".noteModal").on("click", function(){
			$("#note-title").val("");
			$("#note-textarea").val("");
			$("#note-uid").val($("#board_uid").val());
			$("#note-username").val($("#board_username").val());				
	});
	
	$("#note-send-btn").on("click", function(){
		const receiveId =$("#note-uid").val();
		const title =$("#note-title").val();
		const content=$("#note-textarea").val();
/*		if(!title){			
			tWarning("제목을 입력해 주세요.");
			$("#note-title").focus();
			return;
		}*/
		if(!content){			
			tWarning("내용을 입력해 주세요.");
			$("#note-textarea").focus();
			return;
		}
		$.ajax({
			url:"/note/send",
			type:"post",
			data:{receiveId,title,content},
			success:function(res){
				console.log("res");
				if(res==="success"){
					tSuccess("전송 처리 되었습니다.");
					$("#noteModal").modal("hide");
				}
			},
			error:function(error){
				tError("에러  : ",error);
				$("#noteModal").modal("hide");	
			}			
		})			
		
	});
	
	
	
	

});

let page=$("#page").val();
getInList(page);
function getInList(page){
	if(page==undefined || page==""){
		page=1;
	}
	$.ajax({
		type: "GET",
		dataType: "html",
		data:{
			bno:$("#bno").val(),
			page:page
		},
        url: $("#board_url").val()+"/inlist",
        success: function (result) {
        	$(".board-container").html(result);
        	
    		//갤러리형 리스트형 전환 버튼
    		const listType =window.localStorage.getItem("listType");
    		//갤러리형 리스트형
  
    		if(listType===null|| listType==="gallery"){
    			$("#btn-listView").removeClass("right-board");
    			$("#btn-listView").addClass("default");    		
    			$("#listView").hide();
    			
    			$("#btn-galleryView").removeClass("default");
    			$("#btn-galleryView").addClass("right-board");
    			$("#galleryView").show();
    		}else{
    			$("#btn-galleryView").removeClass("right-board");
    			$("#btn-galleryView").addClass("default"); 
    			$("#galleryView").hide();
    			
    			$("#btn-listView").removeClass("default");
    			$("#btn-listView").addClass("right-board");
    			$("#listView").show();	
    		}
        	
        	//페이지 네이션
    		$(".board-paging li a").on("click", function(e){
				e.preventDefault();
				getInList(e.target.dataset.page);	
			})
        },
        error:function(result){
		  console.log( "error :  " ,result);
		  
        }        
	});	
}

function getLike(){
	$.ajax({
		type: "GET",
		data:{bno:$("#bno").val()},
        url: "/like/list",
        success: function (res) {			
        	$("#topLikeCount").html("<img class='board-star-img' src='/resources/web/images/star_grey.png'><i class='topLikeCount-i'>"+res+"</i></span>");
        },
        error:function(result){
        	console.log(result);
        }        
	});	
}


//댓글 불러오기
function replyList(page){
	if(page=="" || page==undefined){
		page=1;
	}	
	var boardType=$("#board_type").val();
	
	var bno=$("#bno").val();
	var sessionCheck=$("#USER_username").val();		
	$.get("/board/replies/all/"+bno +"?page="+page+"&boardType="+boardType, function(data){
		$("#replyList").html(data);
		
		if(sessionCheck!=""){
			$("#clicktoshow1").val(sessionCheck);
		}
		dateFormat();
		
		var replyCount=$("#replyListSize").val();
		$("#boardComment2").html("댓글 "+replyCount);
		

		//페이지 네이션
		$(".reply-pagination a").on("click", function(e){
			e.preventDefault();
			replyList(e.target.dataset.page);	
		})
	});
		
}

//댓글 폼 열기
function updateReplyForm(rno){	
	$("#comment-board-"+rno).hide();
	$("#reply-textarea-div-"+rno).show();	
}

function updateCancle(rno){
	replyList(1);
}



//댓글 업데이트 하기
function updateReply(rno){
	const content=$("#reply-textarea-"+rno).val();
	if(!content){
		alert("내용을 입력해 주세요.");
		$("#reply-textarea-"+rno).foucs();
		return;
	}
	$.ajax({
		url:"/board/replies/update",
		type:"put",
		data:{
			rno,
			content
		},
		success:function(res){
			if ($.trim(res)=="success") {					
				replyList(1);
			}
		},
		error:function(error){
			console.log("에러 : ", error);
		}
	})
}



//로그인 한 유저 댓글 삭제
function replyDelete(rno){
	if (confirm("정말 삭제하시겠습니까?") == true) {
		$.ajax({
			type: "DELETE",
			url: "/board/replies/delete/" + rno,
			success: function (result) {
				if ($.trim(result) == "SUCCESS") {					
					replyList(1);
				}
			}, error: function (d) {
				alert(d.error);
			}
		});
	}
}

//비밀번호로 댓글 삭제
function deleteComment(rno){
	$("#modalRno").val(rno);
}		




dateFormat1();
function dateFormat(){
	var moments = document.getElementsByClassName('moment');
	for (var i = 0; i < moments.length; ++i) {
	    var item = moments[i];  
	    item.innerHTML = moment(item.textContent, "YYYY-MM-DD hh:mm:ss").fromNow();
	}
}	

function dateFormat1(){
	var moments = document.getElementsByClassName('moment1');
	for (var i = 0; i < moments.length; ++i) {
	    var item = moments[i];  
	    item.innerHTML = moment(item.textContent, "YYYY-MM-DD hh:mm:ss").fromNow();
	}
}


function listView(){
	$("#btn-galleryView").removeClass("right-board");
	$("#btn-galleryView").addClass("default"); 
	$("#galleryView").hide();
	
	
	$("#btn-listView").removeClass("default");
	$("#btn-listView").addClass("right-board"); 
	$("#listView").show();	
	window.localStorage.setItem("listType", "list");
}

function galleryView(){
	$("#btn-listView").removeClass("right-board");
	$("#btn-listView").addClass("default");    		
	$("#listView").hide();
	
	$("#btn-galleryView").removeClass("default");
	$("#btn-galleryView").addClass("right-board");
	$("#galleryView").show();
	
	window.localStorage.setItem("listType", "gallery");
}