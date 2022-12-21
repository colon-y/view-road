<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
  <script src="${home}/resources/admin/vendors/js/vendor.bundle.base.js"></script>
  <script src="${home}/resources/admin/vendors/chart.js/Chart.min.js"></script>
  <script src="${home}/resources/admin/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script> 
  
  <script src="${home}/resources/admin/vendors/progressbar.js/progressbar.min.js"></script>

  <script src="${home}/resources/admin/js/off-canvas.js"></script>
  <script src="${home}/resources/admin/js/hoverable-collapse.js"></script>
  <script src="${home}/resources/admin/js/template.js"></script>
  <script src="${home}/resources/admin/js/settings.js"></script>
  <script src="${home}/resources/admin/js/todolist.js"></script>

  <script src="${home}/resources/admin/js/jquery.cookie.js" type="text/javascript"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  
  <script src="${home}/resources/admin/js/dashboard.js"></script>
  <script src="${home}/resources/admin/js/Chart.roundedBarCharts.js"></script>
<script src="/resources/web/js/common.js"></script>

     
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
			
			
			$("#countDropdown").on("click", function(e){
				$.ajax({
					url:"/note/notificationAdminPage",
					type:"POST",
					success:function(res){
						$("#alertHtml").html(res);					
					},
					error:function(error){
						console.log("error : ", error);
					}
				});	
			});
			
     });   
    

     function noticeCount(){
    		$.ajax({
    			url:"/note/noticeCount",
    			type:"POST",			
    			success:function(res){
    				$("#NOTICE_COUNT_SETINTERVAL").val(res.NOTICE_COUNT_SETINTERVAL);	
    				if(parseInt(res.noticeCount)>0){				
						$("#countDropdown").html('<i class="icon-bell"></i><span class="count badge badge-danger badge-counter" style=" width: auto;height: 30px;top: -22px;">'+(res.noticeCount)+'+</span>');    						
    				}else{    					
    					$("#countDropdown").html('<i class="icon-bell"></i>');  
    				}					
    			},
    			error:function(error){
    				console.log("error : ", error);
    			}
    		});		
    	}
     </script>



     