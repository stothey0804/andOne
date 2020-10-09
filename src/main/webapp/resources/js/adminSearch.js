/**
 * 
 */
$(document).ready(function(){
	$(".searchDetail").click(function(){
		$("#popup-container").toggle();
		// ajax
		let _q_id = (event.target).parentNode.parentNode.getAttribute("id");
		$.ajax({
            type: "post",
            async: "true",
            dataType: "json",
            data: {
                q_id: _q_id //data로 넘겨주기
            },
            url: "popupQnADetail.do",
            success: function (data, textStatus) {
            	$("#detail_q_id").html(data.q_id);
            	$("#detail_q_type").html(data.q_type);
            	$("#detail_q_state").html(data.q_state);
            	$("#detail_m_id").html(data.m_id);
            	$("#detail_q_subject").html(data.q_subject);
            	$("#detail_q_content").html(data.q_content);
            	$("#detail_q_date").html(data.q_date);
				CKEDITOR.instances.detail_q_reply.setData(data.q_reply);
//            	$("#detail_q_reply").val(data.q_reply);
            }
		});
		
});
	
	$("#popup-close").click(function(){
		$("#popup-container").toggle();
	});
	
	//상태변경
	$("#editState").click(function(){
		// ajax
		let _q_id = $("#detail_q_id").text();
		let _q_state = $("#edit_q_state").val();
		$.ajax({
            type: "post",
            async: "true",
            dataType: "text",
            data: {
                //data로 넘겨주기
                q_id: _q_id,
                q_state: _q_state
            },
            url: "saveQnAState.do",
            success: function (data, textStatus) {
            	alert("변경완료");
            	location.reload();	// 새로고침
            }
		});
	});
	//답변작성
	$("#saveReply").click(function(){
		// ajax
		let _q_id = $("#detail_q_id").text();
		let _q_reply =	CKEDITOR.instances.detail_q_reply.getData();
		$.ajax({
			type: "post",
			async: "true",
			dataType: "text",
			data: {
				//data로 넘겨주기
				q_id: _q_id,
				q_reply: _q_reply
			},
			url: "sendReplyQnA.do",
			success: function (data, textStatus) {
				alert(data);
			}
		});
		// let frmDetail = document.frmDetail;
		// let q_idVal = $("#detail_q_id").text();
		// let q_id = document.createElement('input');
		// q_id.setAttribute("type","hidden");
		// q_id.setAttribute("name","q_id");
		// q_id.setAttribute("value",q_idVal);
		// frmDetail.appendChild(q_id);
		// frmDetail.action = "sendReplyQnA.do";
		// frmDetail.submit();
	});
	
});
