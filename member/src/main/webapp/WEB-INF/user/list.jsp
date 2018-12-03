<%--
  Author: lianggepeinixueJava
  Date: 2018/11/28 14:07
--%>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>用户列表 - 小戏骨俱乐部成员管理系统</title>
    <meta charset="UTF-8">
    <link href="../../jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="../../jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>

    <script type="text/javascript" src="../../jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="../../jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="../../jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript"
            src="../../jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <script type="text/javascript">

        $(function () {

            //以下日历插件在FF中存在兼容问题，在IE浏览器中可以正常使用。

            $("#startTime").datetimepicker({
                minView: "month",
                language: 'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "bottom-left"
            });

            $("#endTime").datetimepicker({
                minView: "month",
                language: 'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "bottom-left"
            });

            //定制字段
            $("#definedColumns > li").click(function (e) {
                //防止下拉菜单消失
                e.stopPropagation();
            });

            //条件查询
            $("#queryBtn").click(function () {
                var nameOrAccount = $.trim($("#nameOrAccount").val());
                var age = $.trim($("#age").val());
                var startTime = $("#startTime").val();
                var endTime = $("#endTime").val();
                $.ajax({
                    url: 'user/getByCondition',
                    data: {
                        'nameOrAccount': nameOrAccount,
                        'age': age,
                        'startTime': startTime,
                        'endTime': endTime
                    },
                    type: 'get',
                    success: function (data) {
                        if (data.success) {
                            var html = "";
                            $.each(data.userList, function (index, obj) {
                                html += "<tr class='active'>";
                                html += "<td><input type='checkbox' name='id' value='" + obj.id + "'/></td>";
                                html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'user/getById?id=' + obj.id + '\';">' + obj.name + '</a></td>';
                                html += "<td>" + obj.account + "</td>";
                                if ("1" === obj.sex) {
                                    html += "<td>男</td>";
                                } else if ("0" === obj.sex) {
                                    html += "<td>女</td>";
                                }
                                html += "<td>" + obj.age + "</td>";
                                html += "<td>" + obj.birthday + "</td>";
                                html += "<td>" + obj.phone + "</td>";
                                html += "</tr>";
                            })
                            $("#userList").html(html);
                        } else {
                            $("#userList").html("<span style='color: red;'>系统繁忙,请稍后再试!</span>");
                        }
                    }
                })
            });

            $("#firstChk").click(function () {
                $(":checkbox[name='id']").prop("checked", this.checked);
            });

            $("#userList").on("click", ":checkbox[name='id']", function () {
                $("#firstChk").prop("checked", $(":checkbox[name='id']").size() == $(":checkbox[name='id']:checked").size());
            });

            //编辑用户
            $("#editBtn").click(function () {
                if ($(":checkbox[name='id']:checked").size() === 0) {
                    alert("请选择要编辑的用户！");
                } else if ($(":checkbox[name='id']:checked").size() > 1) {
                    alert("一次只能修改一个用户！");
                } else {
                    window.location.href = "user/getById?id=" + $(":checkbox[name='id']:checked").val();
                }
            });

            //删除用户
            $("#deleteBtn").click(function () {
                if ($(":checkbox[name='id']:checked").size() == 0) {
                    alert("请选择要删除的数据！");
                } else {
                    if (window.confirm("您确定要删除该数据吗？")) {
                        var sendData = "";
                        $.each($(":checkbox[name='id']:checked"), function (i, n) {
                            sendData += "&id=" + n.value;
                        });
                        sendData = sendData.substr(1);
                        $.ajax({
                            type: "post",
                            url: "user/delete",
                            data: sendData,
                            success: function (data) {
                                if (!data.success) {
                                    alert("部分数据删除失败");
                                }
                                window.location.href = "user/list";
                                $("#firstChk").prop("checked", false);
                            }
                        });
                    }
                }
            });
        });

    </script>
</head>
<body>

<div>
    <div style="position: relative; left: 10px; top: -10px;text-align: center">
        <div class="page-header">
            <h3>用户列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 60px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group" style="position:relative;left: 15px">
                    <div class="input-group">
                        <div class="input-group-addon">姓名或登录账号</div>
                        <input id="nameOrAccount" class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group" style="position:relative;left: 30px">
                    <div class="input-group">
                        <div class="input-group-addon">年龄</div>
                        <input id="age" class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group" style="position:relative;left: 45px">
                    <div class="input-group">
                        <div style="padding: 6px 12px;font-size: 14px;font-weight: 400;color: #555;text-align: center;background-color: #eee;border: 1px solid #ccc">
                            出生日期
                        </div>
                    </div>
                </div>

                <div class="form-group" style="position:relative;left: 60px">
                    <div class="input-group">
                        <div class="input-group-addon">起</div>
                        <input id="startTime" class="form-control" type="text">
                    </div>
                </div>
                <div class="form-group" style="position:relative;left: 75px">-</div>
                <div class="form-group">
                    <div class="input-group" style="position:relative;left: 90px">
                        <div class="input-group-addon">止</div>
                        <input class="form-control" type="text" id="endTime">
                    </div>
                </div>

                <button id="queryBtn" type="button" class="btn btn-default" style="position:relative;left: 105px">查询
                </button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%; margin-left: 20px;">
                <button type="button" class="btn btn-primary" onclick="window.location.href='user/toAdd'">
                    <span class="glyphicon glyphicon-plus"></span> 添加
                </button>
                <button id="editBtn" type="button" class="btn btn-default">
                    <span class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button id="deleteBtn" type="button" class="btn btn-danger">
                    <span class="glyphicon glyphicon-minus"></span> 删除
                </button>
            </div>
        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input id="firstChk" type="checkbox"/></td>
                    <td>姓名</td>
                    <td>登录账号</td>
                    <td>性别</td>
                    <td>年龄</td>
                    <td>出生日期</td>
                    <td>联系方式</td>
                </tr>
                </thead>
                <tbody id="userList">
                <%--<tr class='active'>
                    <td><input type='checkbox'/></td>
                    <td>王明亮</td>
                    <td>lianggepeinixueJava</td>
                    <td>男</td>
                    <td>23</td>
                    <td>1995-01-01</td>
                    <td>15313300000</td>
                </tr>--%>
                <c:forEach items="${userList}" var="user">
                    <tr class='active'>
                        <td>
                            <input type="checkbox" name="id" value="${user.id}"/>
                        </td>
                        <td>
                            <a style="text-decoration: none; cursor: pointer;"
                               onclick="window.location.href='user/getById?id=${user.id}'">${user.name}</a>
                        </td>
                        <td>${user.account}</td>
                        <c:choose>
                            <c:when test="${user.sex=='1'}">
                                <td>男</td>
                            </c:when>
                            <c:otherwise>
                                <td>女</td>
                            </c:otherwise>
                        </c:choose>
                        <td>${user.age}</td>
                        <td>${user.birthday}</td>
                        <td>${user.phone}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>