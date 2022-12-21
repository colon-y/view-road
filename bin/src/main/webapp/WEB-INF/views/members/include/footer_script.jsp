<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    

    <script src="/resources/members/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/members/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/resources/members/vendor/jquery-easing/jquery.easing.min.js"></script>
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="/resources/members/js/sb-admin-2.min.js"></script>
   	<script src="/resources/web/js/common.js"></script>
   
   
    <!-- 
    <script src="/resources/members/vendor/chart.js/Chart.min.js"></script>
    <script src="/resources/members/js/demo/chart-area-demo.js"></script>
    <script src="/resources/members/js/demo/chart-pie-demo.js"></script>
     -->
     
     
     <script>
     $(function(){    		
			
	 		noticeCount();		
			setTimeout(function(){
				let NOTICE_COUNT_SETINTERVAL=parseInt($("#NOTICE_COUNT_SETINTERVAL").val());			
				//console.log("NOTICE_COUNT_SETINTERVAL : " ,NOTICE_COUNT_SETINTERVAL);
				
				noticeCountlearTimeout=setInterval(function(){				
					noticeCount();
				}, NOTICE_COUNT_SETINTERVAL);							
			}, 2000);
			
			$("#alertsDropdown").on("click", function(e){
				$.ajax({
					url:"/note/notificationMyPage",
					type:"POST",
					success:function(res){
						$("#dropdown-list").html(res);					
					},
					error:function(error){
						console.log("error : ", error);
					}
				});	
			})
     });   
     
     function noticeCount(){
    		$.ajax({
    			url:"/note/noticeCount",
    			type:"POST",			
    			success:function(res){
    				$("#NOTICE_COUNT_SETINTERVAL").val(res.NOTICE_COUNT_SETINTERVAL);			    				
    				if(parseInt(res.noticeCount)>0){				
						$("#alertsDropdown").html('<i class="fas fa-bell fa-fw"></i><span class="badge badge-danger badge-counter">'+res.noticeCount+'+</span>');    						
    				}else{    					
    					$("#alertsDropdown").html('<i class="fas fa-bell fa-fw"></i>');  
    				}					
    			},
    			error:function(error){
    				console.log("error : ", error);
    			}
    		});		
    	}
     </script>
     
     
     
     
     
     
     
     
     
     
     
     
     