<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
			<input type="hidden" id="NOTICE_COUNT_SETINTERVAL" value="5000" >
                    <div class="row">
                        <!-- 사이트홈 -->
                        <div class="col-xl-3 col-md-6 mb-4 top-menu-warning" >
                            <div class="card border-left-warning shadow h-100 py-2 ${menuName eq '' ?  'active' :''}">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                          <a href="/members" class="text-warning ${menuName eq '' ?  'active' :''}">마이페이지</a>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                          <a href="/" class="text-warning"><i class="fas fa-home fa-2x text-gray-300"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <!-- 회원정보 보기 -->
                        <div class="col-xl-3 col-md-6 mb-4 top-menu-primary">
                            <div class="card border-left-primary shadow h-100 py-2  ${menuName eq 'member' ?  'active' :''}">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                              <a href="/members/profile" class="text-primary  ${menuName eq 'member' ?  'active' :''}">  회원정보 보기</a>
                                                
                                                </div>                                           
                                        </div>
                                        <div class="col-auto">
                                            
                                            <a href="/members/profile" class="text-warning"><i class="fas fa-user-tie fa-2x text-gray-300"></i></a>
                                        </div>
                                    </div>
                                </div>	
                            </div>
                        </div>



                        <!-- 스크랩 보기 -->
                        <div class="col-xl-3 col-md-6 mb-4 top-menu-success">
                            <div class="card border-left-success shadow h-100 py-2  ${menuName eq 'scrap' ?  'active' :''}">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                              
                                           <a href="/members/scrap/list" class="text-success ${menuName eq 'scrap' ?  'active' :''}">   스크랩 보기</a>  
                                             </div>                                          
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-fw fa-thumbtack fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 쪽지함 -->
                        <div class="col-xl-3 col-md-6 mb-4  top-menu-info">
                            <div class="card border-left-info shadow h-100 py-2  ${menuName eq 'note' ?  'active' :''}">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                         <a href="/members/note/receiveList" class="text-info ${menuName eq 'note' ?  'active' :''}"> 쪽지함</a>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="far fa-paper-plane fa-2x text-gray-300" ></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        
                        
                        
                    </div>

