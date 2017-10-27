<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: dllo
  Date: 17/10/27
  Time: 上午10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>游戏</title>
    <script>
        function onChange(value) {
//            输出 value 的值
            console.log(value);
//            根据value的值发送请求,获取二级列表的json数据
            var data = new FormData();
            data.append("index", value);
            var xhr = new XMLHttpRequest();
            xhr.withCredentials = true;
            xhr.addEventListener("readystatechange", function () {
                if (this.readyState !== 4) {
                } else {
                    console.log(this.responseText);
                    //对请求会看来的数据进行解析
                    json = eval('(' + this.responseText + ')');
                    //获取标签
                    serverSelect = document.getElementById("servers");
                    //获取option标签
                    optionEle = serverSelect.getElementsByTagName("option");
                    //获取option的数量
                    length = optionEle.length;

                    //使用循环清空所有的option标签
                    for (var i = 0; i < length; i++) {
                        serverSelect.removeChild(optionEle[0])
                    }
//                    serverSelect.innerHTML = "<option value = '-1'>--选择服务器--</option>";
                    for (var i = 0; i < json.length; i++) {
                        //创建一个option标签
                        option = document.createElement("option");
                        //设置value属性
                        option.setAttribute("value", json[i].id);
                        //设置文本信息
                        text = document.createTextNode(json[i].sname);
                        //把文本信息添加到option标签中
                        option.appendChild(text);
                        //把option标签添加到servers的select中
                        serverSelect.appendChild(option);
                    }
                }
            });

            xhr.open("POST", "http://localhost:8080/getServer.action");

            xhr.send(data);
        }
    </script>
</head>
<body>
<h1>选择游戏大区</h1>
<%--显示Action中的大区数据--%>
<%--第一种方式--%>
<s:select list="areaList"
          label="大区"
          headerKey="0"
          headerValue="请选择大区"
          listKey="id"
          listvalue="aname" onchange="onChange(this.value)"/>
<%--第二种方式--%>
<select onchange="onChange(value)">
    <s:iterator value="areaList" var="area">
        <option value="${area.id}">${area.aname}</option>
    </s:iterator>
</select>
服务器:
<select id="servers">
    <option value="0\">--选择服务器--</option>
</select>
</body>
</html>
