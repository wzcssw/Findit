<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/Pages/manager/head_part.jsp"%>

<script type="text/javascript">
	jQuery(document)
			.ready(
					function($) {
						// Notifications
						setTimeout(
								function() {
									var opts = {	
										"closeButton" : true,
										"debug" : false,
										"positionClass" : "toast-top-right toast-default",
										"toastClass" : "black",
										"onclick" : null,
										"showDuration" : "100",
										"hideDuration" : "1000",
										"timeOut" : "5000",
										"extendedTimeOut" : "1000",
										"showEasing" : "swing",
										"hideEasing" : "linear",
										"showMethod" : "fadeIn",
										"hideMethod" : "fadeOut"
									};

									toastr.info("投放网站数据", "下一步",

									opts);
								}, 3000);
					// cpu_usage_data	
					var gaugesPalette = ['#8dc63f', '#40bbea', '#ffba00', '#cc3f44'];
					var cpu_usage_data = [
						<s:iterator value="loginUsers" var="u" status="vs">
							{ time: new Date("<s:property value="loginUsers[#vs.index][1]"/>"), usage: <s:property value="loginUsers[#vs.index][0]"/> },
						</s:iterator>
					];
					
					// CPU Usage
					$('#cpu-usage').dxCircularGauge({
						scale: {
							startValue: 0,
							endValue: 100,
							majorTick: {
								tickInterval: 25
							}
						},
						rangeContainer: {
							palette: 'pastel',
							width: 3,
							ranges: [
								{
									startValue: 0,
									endValue: 25,
									color: gaugesPalette[0]
								}, {
									startValue: 25,
									endValue: 50,
									color: gaugesPalette[1]
								}, {
									startValue: 50,
									endValue: 75,
									color: gaugesPalette[2]
								}, {
									startValue: 75,
									endValue: 100,
									color: gaugesPalette[3]
								}
							],
						},
						value: <s:property value="todayLoginUsers"/>,
						valueIndicator: {
							offset: 10,
							color: '#2c2e2f',
							spindleSize: 12
						}
					});
					
					// CPU Usage chart
					$("#cpu-usage-chart").dxChart({
						dataSource: cpu_usage_data,
						commonPaneSettings: {
							border: {
								visible: true,
								color: '#f5f5f5'
							}
						},
						commonSeriesSettings: {
							type: "area",
							argumentField: "time",
							border: {
								color: '#7c38bc',
								width: 1,
								visible: true
							}
						},
						series: [
							{ valueField: "usage", name: "Capacity used", color: '#7c38bc', opacity: .5 },
						],
						commonAxisSettings: {
							label: {
								visible: true
							},
							grid: {
								visible: true,
								color: '#f5f5f5'
							}
						},
						argumentAxis: {
							valueMarginsEnabled: false,
							label: {
								customizeText: function (arg) {
									return date('Y-m-d', arg.value);
								}
							},
						},
						legend: {
							visible: false
						}
					});
								
								
					});
</script>

<div class="row">

	<div class="col-sm-3" style="margin-left:-1.5%">
		<!-- 注册用户数 -->
		<div class="col-sm-12">
			<div class="xe-widget xe-counter xe-counter-purple" data-count=".num" data-from="0" data-to="<s:property value="totalUser"/>" data-suffix="名" data-duration="1" data-easing="false">
				<div class="xe-icon">
					<i class="linecons-user"></i>
				</div>
				<div class="xe-label">
					<strong class="num">117k</strong>
					<span>注册用户数</span>
				</div>
			</div>
		</div>
		
		
		<!-- 总文件个数 -->
		<div class="col-sm-12">
			<div class="xe-widget xe-counter xe-counter-info" data-count=".num" data-from="0" data-to="<s:property value="fileCount"/>" data-suffix="个" data-duration="4" data-easing="false">
				<div class="xe-icon">
					<i class="linecons-doc"></i>
				</div>
				<div class="xe-label">
					<strong class="num">2,470</strong>
					<span>总文件个数</span>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 上传图片数 -->
	<div class="col-sm-3">
		<div class="xe-widget xe-progress-counter xe-progress-counter-turquoise" data-count=".num" data-from="0" data-to="<s:property value="sharedPictures"/>" data-suffix="张" data-duration="3">
			<div class="xe-background" >
				<i class="linecons-camera"></i>
			</div>
			<div class="xe-upper">
				<div class="xe-icon" >
					<i class="linecons-camera"></i>
				</div>
				<div class="xe-label">
					<span>公开相片总计</span>
					<strong class="num">520k</strong>
				</div>
			</div>
			<div class="xe-progress">
				<span class="xe-progress-fill" data-fill-from="0" data-fill-to="<s:property value="privateRate"/>" data-fill-unit="%" data-fill-property="width" data-fill-duration="3" data-fill-easing="true" style="width: 82%;"></span>
			</div>
			
			<div class="xe-lower">
				<span><s:property value="privateRate"/>% 的相片是私有的</span>
				<strong>全部图片<s:property value="allPictures"/>张</strong>
			</div>
			
		</div>
	</div>
	
	
	
	<!-- 服务器启动时间 -->
	<div class="col-sm-4">
		<div class="xe-widget xe-counter" >
			<div class="xe-icon">
				<i class="linecons-cloud"></i>
			</div>
			<div class="xe-label">
				<strong class="num"><s:property value="lastTime_str"/></strong>
				<span>服务器已启动时间</span>
				<hr/>
				<span><span><s:property value="startTime_str"/></span><h5>上次启动</h5></span>
			</div>
		</div>
	</div>
	
	<!-- 总文件数 -->
	<div class="col-sm-2">
		<div class="xe-widget xe-vertical-counter xe-vertical-counter-primary" data-count=".num" data-from="0" data-to="<s:property value="fileSize_MB"/>" data-suffix=" MB" data-duration="5">
			<div class="xe-icon" style="margin-top:-30%; margin-bottom:-30%">
				<i class="linecons-truck"></i>
			</div>
			
			<div class="xe-label">
				<strong class="num">442 TB</strong>
				<span>总上传文件大小</span>
			</div>
		</div>
	</div>
	
	
	
	<!-- 用户登录情况 -->
	<div class="col-sm-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				用户登录情况
			</div>
			<div class="panel-body">
				
				<div class="row">
					<div class="col-sm-2">
						<p class="text-medium">今日上线用户人数</p>
						<div class="super-large text-purple" data-count="this" data-from="0" data-to="<s:property value="todayLoginUsers"/>" data-duration="2">0</div>
					</div>
					<div class="col-sm-4">
						<div id="cpu-usage" style="height: 150px;"></div>
					</div>
					<div class="col-sm-6">
						<div id="cpu-usage-chart" style="height: 150px;"></div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
				
</div>


<!-- Bottom Scripts -->
<script
	src="${pageContext.request.contextPath}/common/assets/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/TweenMax.min.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/resizeable.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/joinable.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/xenon-api.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/xenon-toggles.js"></script>


<!-- Imported scripts on this page -->
<script
	src="${pageContext.request.contextPath}/common/assets/js/xenon-widgets.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/devexpress-web-14.1/js/globalize.min.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/devexpress-web-14.1/js/dx.chartjs.js"></script>
<script
	src="${pageContext.request.contextPath}/common/assets/js/toastr/toastr.min.js"></script>

<%@ include file="/WEB-INF/Pages/manager/foot_part.jsp"%>