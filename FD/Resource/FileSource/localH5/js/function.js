var inter;
function stop() {
	var myVideo = document.getElementsByTagName('video')[0];
	myVideo.pause();
	clearInterval(inter);
}

function initMission(json) {
	var $obj;
	if (json.cid == 1) {
		$obj = $(".video img");
	} else if (json.cid == 2) {
		$obj = $(".video video");
		//$obj.attr("autoplay", "autoplay");
	}
	
	$obj.attr("src", json.src);
	$obj.show();
	
	if (json.cid == 2) {
		var myVideo = document.getElementsByTagName('video')[0];
		myVideo.play();
	}
	
	var time = json.time
	var per = 100 / time;
	inter = setInterval(function(){
		if (time >= 0) {
			var percent = (100 - per * time) + "%";
			console.error(time);
			$(".xju").css("width", percent);
			$(".tips").text("剩余 "+time+" 秒");
		} else {
			$(".tips").text("任务已完成");
			location.href = "http://baidu.com";
			clearInterval(inter);
		}
		time--;
	}, 1000);
}


function initSpread(json) {
	$(".top img").attr("src", json.thumb);
	$(".title .div2").text(json.name);
	$(".title .div3").text(json.sub_name);
	
	$(".jli.org").text(json.profit);
	$(".list-box").eq(0).find("p.f-black").text(json.bond);
	$(".list-box").eq(1).find("p.f-black").text(json.fine);
	$(".list-box").eq(2).find("p.f-black").text(json.cycle + "天");
	
	$(".data-href").eq(0).find("a").attr("href", json.content_url);
	
	//
	var $html = "";
	$(".jion-top em").text(json.koiner_total);
	for (var i in json.joiner_list) {
		var $style = "";
		if (i >= 5) {
			$style = 'style="margin-right: 0px;"';
		}
		$html += '<span '+$style+'><img src="'+json.joiner_list[i].avatar+'" /></span>';
	}
	$(".user-pic").html($html);
	
	//
	var $html = "";
	for (var i in json.comment) {
		$html += '<div class="mes clearfix"><div class="use-pic"><img src="'+json.comment[i].avatar+'" /></div><div class="mes-txt"><p class="use-name">'+json.comment[i].username+'</p><div class="m-m"><div class="m-j"><img src="images/laug_03.png" /></div><div class="m-box"><p>'+json.comment[i].content+'</p></div><div class="fa-time">'+json.comment[i].insert_time+'</div></div></div></div>';
	}
	$(".jion-m").eq(1).append($html);
}

function initGoods() {
}

function initDraw() {
	
}