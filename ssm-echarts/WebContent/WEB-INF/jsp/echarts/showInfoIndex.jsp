<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <title>- 观测数据 -</title>
</head>
		<base href="<%=basePath%>">
		<script type="text/javascript" src="static/echarts/jquery-1.8.3.js"></script>
		<script type="text/javascript" src="static/echarts/echarts.js"></script>

	<body>

		<!-- 显示Echarts图表 -->
		<div style="height:410px;min-height:100px;margin:0 auto;" id="main"></div>						
            		
  	
  
		<script type="text/javascript">
			
		// 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
        var option = {
            title: {	//图表标题
                text: 'test数据图表'
            },
            tooltip: {
                trigger: 'axis', //坐标轴触发提示框，多用于柱状、折线图中
                /*
 				控制提示框内容输出格式
                formatter: '{b0}<br/><font color=#FF3333>&nbsp;●&nbsp;</font>{a0} : {c0} ℃ ' + 
               				'<br/><font color=#53FF53>●&nbsp;</font>{a1} : {c1} % ' +          
               				'<br/><font color=#68CFE8>&nbsp;●&nbsp;</font>{a3} : {c3} mm ' +
               				'<br/><font color=#FFDC35>&nbsp;●&nbsp;</font>{a4} : {c4} m/s ' +
               				'<br/><font color=#B15BFF>&nbsp;&nbsp;&nbsp;&nbsp;●&nbsp;</font>{a2} : {c2} hPa ' 
                */
            },
            dataZoom: [
                 {
                     type: 'slider',	//支持鼠标滚轮缩放
                     start: 0,			//默认数据初始缩放范围为10%到90%
                     end: 100
                 },
                 {
                     type: 'inside',	//支持单独的滑动条缩放
                     start: 0,			//默认数据初始缩放范围为10%到90%
                     end: 100
                 }
            ],
            legend: {	//图表上方的类别显示           	
            	show:true,
            	data:['温度（℃）','湿度（%）','雨量（mm）','风速（m/s）','压强（hPa）']
            },
            color:[
                   '#FF3333',	//温度曲线颜色
                   '#53FF53',	//湿度曲线颜色
                   '#B15BFF',	//压强图颜色
                   '#68CFE8',	//雨量图颜色
                   '#FFDC35'	//风速曲线颜色
                   ],
           toolbox: {
               feature: {
                 dataView: {show: true, readOnly: false},
                 magicType: {show: true, type: ['line', 'bar']},
                 restore: {show: true},
                 saveAsImage: {show: true}
               }
             },
            xAxis:  {	//X轴       	
                type : 'category',
                data : []	//先设置数据值为空，后面用Ajax获取动态数据填入
            },
            yAxis : [	//Y轴（这里我设置了两个Y轴，左右各一个）
						{
            				//第一个（左边）Y轴，yAxisIndex为0
	                         type : 'value',
	                         name : '温度',
	                         /* max: 120,
	                         min: -40, */
	                         axisLabel : {
	                             formatter: '{value} ℃'	//控制输出格式
	                         }
	                     },
	                     {
	                    	//第二个（右边）Y轴，yAxisIndex为1
	                         type : 'value',
	                         name : '压强',
	                         scale: true,
	                         axisLabel : {
	                             formatter: '{value} hPa'
	                         }
	                     }
	                 
            ],
            series : [	//系列（内容）列表                      
						{
		                    name:'温度（℃）',
		                    type:'line',	//折线图表示（生成温度曲线）
		                    symbol:'emptycircle',	//设置折线图中表示每个坐标点的符号；emptycircle：空心圆；emptyrect：空心矩形；circle：实心圆；emptydiamond：菱形	                    
		                    data:[]		//数据值通过Ajax动态获取
		                },
		                
		                {
		                    name:'湿度（%）',
		                    type:'line',
		                    symbol:'emptyrect',
		                    data:[]
		                },
		                
		                {
		                    name:'压强（hPa）',
		                    type:'line',
		                    symbol:'circle',	//标识符号为实心圆
		                    yAxisIndex: 1,		//与第二y轴有关
		                    data:[]
		                },
		                
		                {
		                    name:'雨量（mm）',
		                    type:'bar',		//柱状图表示
		                    //barMinHeight: 10,	//柱条最小高度，可用于防止某数据项的值过小而影响交互
		                    /* label: {	//显示值
		                        normal: {
		                            show: true,
		                            position: 'top'
		                        }
		                    }, */
		                    data:[]
		                },
		                
		                {
		                    name:'风速（m/s）',
		                    type:'line',
		                    symbol:'emptydiamond',
		                    data:[]
		                }	            
            ]
        };
		 
		myChart.showLoading();	//数据加载完之前先显示一段简单的loading动画
		 
		 var tems=[];		//温度数组（存放服务器返回的所有温度值）
		 var hums=[];		//湿度数组
		 var pas=[];		//压强数组
		 var rains=[];		//雨量数组
		 var win_sps=[];	//风速数组
		 var dates=[];		//时间数组
		 
         $.ajax({	//使用JQuery内置的Ajax方法
         type : "post",		//post请求方式
         async : true,		//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
         url : "echarts/record.action",	//请求发送到ShowInfoIndexServlet处
         data : {name:"A0001"},		//请求内包含一个key为name，value为A0001的参数；服务器接收到客户端请求时通过request.getParameter方法获取该参数值
         dataType : "json",		//返回数据形式为json
         success : function(result) {
        	 //请求成功时执行该函数内容，result即为服务器返回的json对象
	         if (result != null && result.length > 0) {
	                for(var i=0;i<result.length;i++){       
	                   tems.push(result[i].tem);		//挨个取出温度、湿度、压强等值并填入前面声明的温度、湿度、压强等数组
	                   hums.push(result[i].hum);
	                   pas.push(result[i].pa);
	                   rains.push(result[i].rain);
	                   win_sps.push(result[i].win_sp);
	                   dates.push(result[i].date);
	                }
	                myChart.hideLoading();	//隐藏加载动画
	                
	                myChart.setOption({		//载入数据
	   		         xAxis: {
	   		             data: dates	//填入X轴数据
	   		         },
	   		         series: [	//填入系列（内容）数据
	   		               		{
			   		             // 根据名字对应到相应的系列
			   		             name: '温度',
			   		             data: tems
	   		         		},
	   		               		{
			   		             name: '湿度',
			   		             data: hums
	   		         		},
	   		         			{
			   		             name: '压强',
			   		             data: pas
	   		         		},
	   		         			{
			   		             name: '雨量',
			   		             data: rains
	   		         		},
	   		         			{
		   		             name: '风速',
		   		             data: win_sps
  		         			}
	   		        ]
	   		     });
	                
	         }
	         else {
	        	 //返回的数据为空时显示提示信息
	        	 alert("图表请求数据为空，可能服务器暂未录入近五天的观测数据，您可以稍后再试！");
	          	 myChart.hideLoading();
	         }
         
		},
     	error : function(errorMsg) {
     		//请求失败时执行该函数
         	alert("图表请求数据失败，可能是服务器开小差了");
         	myChart.hideLoading();    	
     	}
    })

    myChart.setOption(option);	//载入图表
		 
    </script>
		
	</body>
</html>