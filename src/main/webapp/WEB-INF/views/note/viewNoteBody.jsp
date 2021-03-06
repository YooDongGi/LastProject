<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>




<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<style type="text/css">

/*     i { */
/*     	width : 300px; */
/*     	height : 300px; */
/*     } */
/* #content { */
/* 	border: 1px solid black; */
/* 	width: 100%; */
/* } */

#firstDiv {
	float: left;
	width: 83%
}

#secondDiv {
	float: left;
	width: 16%
}

.site-footer {
	clear: both;
}

#sameHeight {
	display: flex;
}

#replyView {
	margin-left: 20px;
}

body {
	/*     	min-width : 2000px; */
	
}

/* size {
    	min-height : 1000px;
    } */
#title:hover {
	color: blue;
}

.labelCont {
	font-size: 16px;
}

#upperWork {
	background-color: #FBF301;
}

#replyWrite {
	width: 100%
}

.deleteIcon {
	height: auto;
	width: auto;
}

.updateIcon {
	height: auto;
	width: auto;
}

#replyBtnTd {
	padding-top: 170px;
	float: left;
}

#replyIcon {
	width: 10px;
	height: 10px;
}

.trashIcon {
	width: auto;
	height: auto;
}

#titlereplyReply {
	background-color: #FBF301;
	color: gray;
}

#GroupReplyInsertBtn {
	float: bottom;
}

.replyParentId {
	background-color: #A9D0F5;
}

.replyReply {
	background-color: #f4f4f4;
}

.changePink {
	background-color: #F6CEE3 !important;
}
.form-control{
	border: none;
}
.lab{
	line-height: 1.8;
	font-weight: bold;
}
.labelCont{
	margin-left: 1%;
}
</style>


<script type="text/javascript">
		$(document).ready(function(){
			
			
			$('#summernote').summernote({
		            height: 250,
		            popover: {
		               image:[],
		               link:[],
		               air:[]
		            },
		            toolbar: [
		                 ['style', ['style']],
		                 ['font', ['bold', 'underline', 'clear']],
		                 ['fontname', ['fontname']],
		                 ['color', ['color']],
		                 ['para', ['ul', 'ol', 'paragraph']],
		                 ['table', ['table']],
		                 ['view', ['fullscreen', 'codeview']],
		               ]
		         });
			
			
			
			//???????????? ???????????? ??????
	
			
			$('#cancel').on('click' , function(){
				location.href="${cp}/note/viewMain?p_code=${noteVo.p_code }"
				
			})
			
			//?????? ?????? (????????? : ?????????????????? ?????? ?????? ????????? ?????? , ???????????? : ?????? ?????? ??????)
			$('#insertNoteReply').on('click' , function(){
	
				$('#insertForm').submit();			
			})
			
			
			//??? ???????????? 
			
			$('#update').on('click' , function(){
				var n_no = $('#n_parent').val();
				location.href="${cp}/note/viewUpdate?n_no=" + n_no;
			})
			
			
			// ?????? ?????? ?????? (????????? ???????????? ??????????????? ????????? ???????????? ???????????? ?????? ???????????? ??? ??????)

			$('.ajaxReplyBlock').on('mouseover' , '.eachReplyTr'  , function(){
				var r_parent = $(this).data('pno');
				if(r_parent == 0 ){
					return false;
				}
				//?????? ?????? ?????? ????????? ?????? 
				var r_no = $(this).data('rnumber');
				
				
				$('#replyBody').children('#' + r_parent ).addClass('changePink');
				
				
					
			})
			
			$('.ajaxReplyBlock').on('mouseleave' , '.eachReplyTr'  , function(){
				
				var r_parent = $(this).data('pno');
				if(r_parent == 0 ){
					return false;
				}
				var r_no = $(this).data('rnumber');
				$('#replyBody').children('#' + r_parent ).removeClass('changePink');	
				
			})
			/*?????? ???????????? */
			
			
			// ????????? ?????? ?????? ???????????? 
			
			$('#GroupReplyInsertBtn').on('click' , function(){
				
				//????????? ?????? ?????? ??????
				//?????? ????????? 
				var form = {
					n_no : $('#n_no').val(),
				//?????????
					user_id : $('#user_id').val(),
				//??????
					r_cont : $('#replyWrite').val()
				}
				
				//???????????? ???????????? 
				$.ajax({
					url : "${cp}/note/insertReply",
					type : "GET", 
					cache : false, 
					data : form,
					success : function(data){
						$('#replyTable').html(data);
						$('#replyWrite').val("");
					},
					error : function(){
						swal({
							title: "Error",
							text: "????????????",
							type: "error",
							showCancelButton: false,
							/* cancelButtonClass: 'btn-danger', */
							confirmButtonClass: 'btn-danger',
							confirmButtonText: '??????'
						});
					}
				})
				
			})
			
			//?????? ????????? ?????? ??????
		 	$('.ajaxReplyBlock').on('click' , '.ChildReplyViewBtn'  , function(){
		 		
		 		//??????????????? ???????????? ??? ????????? ??????????????? ?????? ??? ?????? ????????? ???????????? ?????????. r_parentNum ??? ?????? ????????? ?????????????????? ????????? ?????? ????????? ?????????????????? ??????????????????????????? insert ?????????.
		 		var r_parentNum = $(this).data('up'); 
		  		var plusTr = "";
			 		plusTr += "<tr style='height: 150px;'>"
			 		plusTr += 	"<th></th>"
			 		plusTr += 	"<th colspan='4' style='width: 200px; height: 50px;'><span>?????? ??????</span><br><textarea rows='3' cols='130' class='replyReplyCont'></textarea>"
			 		plusTr += 		"<input type='button' class='btn float-right btn-primary insertReplyReply' " + "id='" + r_parentNum + "'" + "value='????????????'>"
			 		plusTr += 	"</th>"
			 		plusTr += 	"<th style='width: 200px;' scope='col'></th>"
			 		plusTr += 	"<th style='width: 180px;' scope='col'></th>"
			 		plusTr += "</tr>"
		 		
		 		$(this).parent().parent().after(plusTr); 
		 		
			})
			
			//?????? ?????? ????????? ????????????
			$('.ajaxReplyBlock').on('click' , '.insertReplyReply'  , function(){
			
				//?????? ????????? ?????? 
				var r_parent =  $(this).attr('id');
				var r_cont = $(this).parent().find('.replyReplyCont').val().trim();
				
				var form = {
				//?????? ????????? 
					n_no : $('#n_no').val(),
				//?????? ?????? ??????
					r_parent : r_parent,
				//?????????
					user_id : $('#user_id').val(),
				//??????
					r_cont : r_cont 
				}
				
				//???????????? ???????????? 
				$.ajax({
					url : "${cp}/note/insertReply",
					type : "GET", 
					cache : false, 
					data : form,
					success : function(data){
						$('#replyTable').html(data);
					},
					error : function(){
					}
				});
			})
			
			
			//?????? ??????
			$('.ajaxReplyBlock').on('click' ,'.deleteReply', function(){
				//?????? ????????? id ??? ????????? ?????? r_no ??? ????????? ??????(r_no ???????????? ??????)
				var r_no = $(this).data('delete');
				//var cont = $(this).parent().parent().find(".deletedCont");
				var n_no = $('#n_no').val();
				$.ajax({
					url : "${cp}/note/deleteReply", 
					type : "GET" , 
					cache : false ,
					data : { r_no : r_no ,
							n_no : n_no
							}, 
					success : function(data){
						$('#replyTable').html(data);
						}, 
					error : function(){
						swal({
							title: "Error",
							text: "????????????",
							type: "error",
							showCancelButton: false,
							/* cancelButtonClass: 'btn-danger', */
							confirmButtonClass: 'btn-danger',
							confirmButtonText: '??????'
						});
					}
					
				})
			})
			
			
			
			//?????? ????????? ?????? ??????
			$('.ajaxReplyBlock').on('click' , '.updateReplyView'  , function(){
				var updateCont = $(this).data('rno')
				//????????? ?????? no 
				var updateReplyNo = $(this).data('rnono');
				var plusTr = "";
		 		 plusTr += "<tr style='height: 150px;'><th></th>"
		 		 plusTr +=     "<th colspan='4' style='width: 200px; height: 50px;'><span>?????? ??????</span><br><textarea rows='3' cols='130' class='replyReplyCont'>" + updateCont + "</textarea>"
		 		 plusTr += 	       "<input type='button' class='btn float-right btn-primary updateReply' " + "id='" + updateReplyNo  + "'" + "value='??????'>"
		 		plusTr  +=     "</th>"
		 		 plusTr += 	   "<th style='width: 200px;' scope='col'></th>"
		 		 plusTr += 	   "<th style='width: 180px;' scope='col'></th>"
		 		 plusTr += "</tr>"
		 		$(this).parent().parent().after(plusTr); 
			});
			
			
			//?????? ?????? ?????? (?????? ????????????)
			
			
			
			$('.ajaxReplyBlock').on('click' ,'.updateReply', function(){
				var r_no = $(this).attr('id');
				var n_no = $('#n_no').val();
				var r_cont = $(this).parent().find('.replyReplyCont').val()
				$.ajax({
					url : "${cp}/note/updateReply", 
					type : "GET" , 
					cache : false ,
					data : { r_no : r_no ,
							n_no : n_no , 
							r_cont : r_cont 
							}, 
					success : function(data){
						$('#replyTable').html(data);
						}, 
					error : function(){
						swal({
							title: "Error",
							text: "????????????",
							type: "error",
							showCancelButton: false,
							/* cancelButtonClass: 'btn-danger', */
							confirmButtonClass: 'btn-danger',
							confirmButtonText: '??????'
						});
					}
				});
			});
			//?????? ?????? ?????? ???
		});
</script>




<form id="insertForm" action="${cp}/note/viewInsertChildNote" method="get">
	<!-- ??????????????? ?????? ??????????????? ??????????????? ??????. -->
	<input type="hidden" value="${noteVo.n_no}" name="n_parent" id="n_parent">
	<!-- ???????????? ????????? ?????? -->
	<input type="hidden" value="${noteVo.n_gno}" name="n_gno" id="n_gno">
	<!-- ?????? p_code -->
	<input type="hidden" value="${noteVo.p_code }" name="p_code">
</form>


<%@ include file="/WEB-INF/views/common/noteSidebar.jsp" %>

<!-- START: Main Content-->
<main>



	<div id="allMain" class="container-fluid site-width">


		<!-- START: Breadcrumbs-->
		<div class="row ">
			<div class="col-12  align-self-center">
				<div class="sub-header mt-3 py-3 align-self-center d-sm-flex w-100 rounded">
					<div class="w-sm-100 mr-auto">
						<h4 class="mb-0">????????????</h4>
					</div>
				</div>
			</div>
		</div>
		<!-- END: Breadcrumbs-->

		<!-- START: Card Data-->

		<!-- ?????? ?????? ???????????? ????????? div -->
		<div id="sameHeight">
			<div class="card" id="firstDiv">
				<div class="card-body">
					<div class="wizard mb-4">



						<div class="connecting-line"></div>
						<ul class="nav nav-tabs d-flex mb-3">
							<li class="nav-item mr-auto"><a class="nav-link position-relative round-tab text-left p-0 active border-0" data-toggle="tab" href="#id1"> <i class="icon-book-open position-relative text-white h5 mb-3"></i> <br>
							</a></li>


						</ul>

						<c:choose>
							<c:when test="${noteVo.n_import == 01 }">
								<input type="button" value="???" style="font-size: large; border: none; background: transparent; cursor: default;">
							</c:when>
							<c:otherwise>
								<input type="button" value="???" style="font-size: large; border: none; background: transparent; cursor: default;">
							</c:otherwise>

						</c:choose>
						<input type="hidden" name="starCheck" id="starCheck" value="">
						<div class="tab-content">
							<div class="tab-pane fade active show" id="id1">
								<div class="form">
									<span id="starText"></span> <br>
									
									<div class="form-row">
										<label class="labelCont form-control col-1"><i class="icon-doc icons"></i>?????????</label> <br> <label class="lab form-control col-2">${noteVo.n_title }</label>
									</div>

									<c:if test="${parentTitle != null }">
										<div class="form-row">
											<label class="labelCont form-control col-1" id="upperWork"><i class="icon-action-redo"></i>???????????? </label> <label class="lab form-control col-2" id="upperWork">${parentTitle}</label>
										</div>
									</c:if>

									<div class="form-row">
										<label class="labelCont form-control col-1"><i class="icon-people icons"></i>????????? </label> <label class="lab form-control col-2">${noteVo.user_id}</label>
									</div>

									<div class="form-row">
										<label class="labelCont form-control col-1"><i class="icon-docs icons"></i>???????????? </label> <label class="lab form-control col-2">${noteVo.category}</label>
									</div>

									<div class="form-row">
										<label class="labelCont form-control col-1"><i class="icon-chart icons"></i>?????? </label> <label class="lab form-control col-2">${noteVo.code_name}</label>
									</div>

									<div class="form-row">
										<label class="labelCont form-control col-1"><i class="icon-chart icons"></i>????????? </label> <label class="lab form-control col-2">${noteVo.progress}%</label>
									</div>


									<div class="form-row">
										<label class="labelCont form-control col-1"><i class="icon-calendar icons"></i>???????????? </label> <label class="lab form-control col-2">${noteVo.n_sdt}</label>
									</div>
									<div class="form-row">
										<label class="labelCont form-control col-1"><i class="icon-calendar icons"></i>???????????? </label> <label class="lab form-control col-2">${noteVo.n_edt}</label>
									</div>


									<div class="form-row" style="height: auto;">
										<label class="labelCont form-control col-1"><i class="icon-speech icons"></i>????????????</label><br> 
										<div class="form-control col-8" style="height: auto;">
											<label class="lab" id="content">${noteVo.n_cont}</label>
										</div>
										<br>
									</div>
								</div>

							</div>


							<!-- session ?????? ????????? ??????????????? -->
								<button type="button" id="cancel" class="btn float-right btn-secondary" style="margin-left: 3px;" value="">??????</button>
								 <c:if test="${noteVo.user_id == S_USER.user_id }"> 
								<button type="button" id="update" class="btn float-right btn-primary" value="">??????</button>
								 </c:if>  
							<!-- <button type="button" id="insertNoteReply"  class="btn float-right btn-primary" value="">????????????</button> -->

							<!-- ????????? -->
							<br> <br> <br> <i id="replyIcon" class="fas fa-pen-square"></i>
							<div>??????</div>
							<div class="ajaxReplyBlock">
								<!-- ?????? ??? ?????? -->
								<input type="hidden" value="${noteVo.n_no}" id="n_no">
								<!-- ????????? -->
								<input type="hidden" value="${S_USER.user_id}" id="user_id">
								<div class="card-body">
									<div class="table-responsive size">
										<table class="table layout-primary" id="replyTable">
											<thead>
												<tr>
													<th scope="col" style="width: 200px;">?????????</th>
													<th colspan="4" scope="col">????????????</th>
													<th style="width: 200px;" scope="col">????????????</th>
													<th style="width: 180px;" scope="col"></th>
												</tr>
											</thead>
											<tbody id="replyBody">
												<c:forEach items="${replyVoList}" var="replyVo">

													<c:choose>
														<c:when test="${replyVo.r_parent_name != null }">
															<tr class="eachReplyTr replyReply" id="${replyVo.r_no}" data-rnumber="${replyVo.r_no}" data-pno="${replyVo.r_parent}">
														</c:when>
														<c:otherwise>
															<tr class="eachReplyTr" id="${replyVo.r_no}" data-rnumber="${replyVo.r_no}" data-pno="${replyVo.r_parent}">
														</c:otherwise>
													</c:choose>
													<th scope="row" style="width: 200px;">${replyVo.user_id }</th>
													<c:choose>
														<c:when test="${replyVo.r_parent_name != null }">
															<td class="Cont" id="${replyVo.r_no}" colspan="4">&emsp;&emsp;&emsp;&emsp;<c:if test="${replyVo.r_cont == '????????? ???????????????.'}">
																	<i id="trashIcon" class="fas fa-trash-alt trashIcon"></i>
																</c:if> <span class="replyParentId">${replyVo.r_parent_name}</span> ?????? :<br>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<span class="replyContSpan">${replyVo.r_cont }</span></td>
														</c:when>

														<c:otherwise>
															<td class="Cont" id="${replyVo.r_no}" colspan="4"><c:if test="${replyVo.r_cont == '????????? ???????????????.'}">
																	<i id="trashIcon" class="fas fa-trash-alt trashIcon"></i>
																</c:if> <span class="replyParentId">${replyVo.r_parent_name}</span><span class="replyContSpan">${replyVo.r_cont }</span></td>
														</c:otherwise>
													</c:choose>

													<td style="width: 200px;">${replyVo.r_regdt }</td>
													<td class="deleteAjaxTd" style="width: 180px;"><c:choose>
															<c:when test="${replyVo.r_cont == '????????? ???????????????.'}">
															</c:when>
															<c:otherwise>
																<!-- ???????????? ????????? id data??? ???????????? -->
																<c:if test="${ S_USER.user_id == replyVo.user_id  }">
																	<button class="btn btn-outline-primary deleteReply" data-delete="${replyVo.r_no }">
																		<i class="fa fa-trash deleteIcon"></i>
																	</button>
																	<!-- ?????? ???????????? ?????? -->
																	<button class="btn btn-outline-primary updateReplyView" data-rno="${replyVo.r_cont }" data-rnono="${replyVo.r_no}">
																		<i class="far fa-edit updateIcon"></i>
																	</button>
																</c:if>
																<!-- ????????? ???????????? ?????? -->
																<!-- ???????????? ????????? id data??? ???????????? -->
																<button class="btn btn-outline-primary ChildReplyViewBtn" data-up="${replyVo.r_no }">
																	+ <i class="far fa-edit updateIcon"></i>
																</button>
															</c:otherwise>
														</c:choose></td>

												</c:forEach>
											</tbody>
										</table>
										<table>
											<!-- ????????? ?????? ?????? -->
											<tr>
												<th>?????? ??????</th>
											</tr>
											<tr>

												<th scope="col" style="width: 200px;">????????? : ${S_USER.user_id}</th>
												<td colspan="4" scope="col"></td>
												<td colspan="4"><textarea rows="3" cols="150" name="r_cont" id="replyWrite"></textarea></td>
												<td></td>
												<td style="width: 180px;" scope="col" id="replyBtnTd"><input type="button" class="btn float-right btn-primary" id="GroupReplyInsertBtn" value="????????????"></td>
											</tr>
										</table>
									</div>
								</div>
							</div>
							<!-- ?????? ??? -->



						</div>








					</div>
				</div>
			</div>

			<!-- ???????????????  -->
			<div class="card" id="secondDiv">
				<button type="button" id="insertNoteReply" class="btn float-right btn-primary" value="">????????????</button>
				<div class="card-body">
					<div class="wizard mb-4">

						<!-- <div class="nav-item mr-auto" id="replyView"> -->
						<a class="nav-link position-relative round-tab text-left p-0 active border-0" data-toggle="tab" href="#id1"> <i class="icon-event icons position-relative text-white h6 mb-2"></i> <span id="replySpan"> ???????????? ?????? ?????????</span> <br> <br>
						</a>
						<!--  </div> -->
						<br>
						<!-- ?????? ????????? ???????????? -->

						<c:forEach items="${noteReplyVoList}" var="noteReplyVo">

							<a href="${cp}/note/viewOneNote?n_no=${noteReplyVo.n_no}"><i class=icon-tag></i><span id="title"> ${noteReplyVo.n_title}</span><br></a>


						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>



