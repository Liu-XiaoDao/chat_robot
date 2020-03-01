/**
	// editor create之后调用
	init: function(editorSelector){
		$(editorSelector + " .w-e-toolbar").append('<div class="w-e-menu"><a class="_wangEditor_btn_fullscreen" href="javascript:void(0);" onclick="window.wangEditor.fullscreen.toggleFullscreen(\'' + editorSelector + '\')">全屏</a></div>');
	},
	toggleFullscreen: function(editorSelector){
		$(editorSelector).toggleClass('fullscreen-editor');
		if($(editorSelector + ' ._wangEditor_btn_fullscreen').text() == '全屏'){
			$(editorSelector + ' ._wangEditor_btn_fullscreen').text('退出全屏');
		}else{
			$(editorSelector + ' ._wangEditor_btn_fullscreen').text('全屏');
		}
	}
};
 */
window.wangEditor.fullscreen = {
	// editor create之后调用
	init: function(editorSelector){
		$(editorSelector + " .w-e-toolbar").append('<div class="w-e-menu"><a class="_wangEditor_btn_fullscreen" href="javascript:window.wangEditor.fullscreen.toggleFullscreen(\'' + editorSelector + '\')">全屏</a></div>');
		$(editorSelector + " .w-e-toolbar").append('<div class="w-e-menu"><a class="_wangEditor_btn_preview" href="javascript:window.wangEditor.fullscreen.preview()">预览</a></div>');
	},
	toggleFullscreen: function(editorSelector){
		$(editorSelector).toggleClass('fullscreen-editor');
		if($(editorSelector + ' ._wangEditor_btn_fullscreen').text() == '全屏'){
			$(editorSelector + ' ._wangEditor_btn_fullscreen').text('退出全屏');
		}else{
			$(editorSelector + ' ._wangEditor_btn_fullscreen').text('全屏');
		}
	},
	preview: function(){
    $('#preview_content').html($('#golden_idea_idea_content').val());
    $('#preview').modal('show');
	}
};
