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
    <title>修改用户 - 小戏骨俱乐部成员管理系统</title>
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
            $("#birthday").datetimepicker({
                minView: "month",
                language: 'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "bottom-left"
            });
        });

        //验证登录账号
        function checkLoginAct() {
            //获取用户输入的登录账号
            var account = $.trim($("#account").val());
            var oldAccount = $.trim($("#oldAccount").val());
            var flag = true;
            //登录账号不能为空
            if ("" === account) {
                $("#accountErrorMessage").html("请输入登录账号");
                return false;
            } else if (oldAccount === account) {
                return true;
            } else {
                $("#accountErrorMessage").html("");
                //登录账号不能重复
                $.ajax({
                    url: "user/checkLoginAct",
                    type: "post",
                    data: "account=" + account,
                    async: false,
                    success: function (data) {
                        if (data.success) {
                            //可以注册，说明该登录账号在系统中没有查询到信息
                            flag = true;
                        } else {
                            $("#accountErrorMessage").html("该账号已存在，请更换其他账号");
                            flag = false;
                        }
                    },
                    error: function () {
                        $("#accountErrorMessage").html("系统繁忙，请稍后重试...");
                        flag = false;
                    }
                });
            }
            return flag;
        }

        //验证手机号
        function checkPhone() {
            //获取用户输入的手机号
            var oldPhone = $.trim($("#oldPhone").val());
            var phone = $.trim($("#phone").val());
            var flag = true;
            //手机号不能为空
            if ("" === phone) {
                $("#phoneErrorMessage").html("请输入手机号码");
                return false;
            } else if (oldPhone === phone) {
                return true;
            } else if (!/^1[1-9]\d{9}$/.test(phone)) {
                //验证手机号的格式
                $("#phoneErrorMessage").html("请输入正确的手机号码");
                return false;
            } else {
                $("#phoneErrorMessage").html("");
            }
            return flag;
        }

        //保存修改
        function saveUser() {
            if (checkLoginAct() && checkPhone()) {
                $("#editUserForm").submit();
            }
        }

    </script>
</head>
<body>
<div>
    <div>
        <div>
            <div style="position: relative; left: 10px; top: -10px;text-align: center">
                <div class="page-header">
                    <h3>修改用户</h3>
                </div>
            </div>
        </div>
        <br>
        <div>
            <form id="editUserForm" class="form-horizontal" method="post" action="user/update">
                <div class="form-group">
                    <input id="id" name="id" type="text" hidden="hidden" value="${user.id}" title="">
                    <label for="name" class="col-sm-2 control-label">姓名</label>
                    <div class="col-sm-10" style="width: 300px;">
                        <input id="name" name="name" type="text" class="form-control" value="${user.name}"
                               autocomplete="off">
                    </div>
                    <label for="sex" class="col-sm-2 control-label">性别</label>
                    <div class="col-sm-10" style="width: 300px;">
                        <select id="sex" name="sex" class="form-control">
                            <option></option>
                            <c:choose>
                                <c:when test="${user.sex=='1'}">
                                    <option id="male" value="1" selected>男</option>
                                    <option id="female" value="0">女</option>
                                </c:when>
                                <c:otherwise>
                                    <option id="male" value="1">男</option>
                                    <option id="female" value="0" selected>女</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="account" class="col-sm-2 control-label">登录账号
                        <span style="font-size: 15px; color: red;">*</span>
                    </label>
                    <div class="col-sm-10" style="width: 300px;">
                        <input id="account" name="account" type="text" class="form-control"
                               onblur="checkLoginAct()" onfocus="$('#accountErrorMessage').html('');"
                               value="${user.account}" autocomplete="off">
                        <input id="oldAccount" type="hidden" value="${user.account}" disabled="disabled">
                        <span id="accountErrorMessage" style="color: red"></span>
                    </div>
                    <label for="password" class="col-sm-2 control-label">登陆密码</label>
                    <div class="col-sm-10" style="width: 300px;">
                        <input id="password" name="password" type="text" class="form-control" value="${user.password}"
                               autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label for="birthday" class="col-sm-2 control-label">出生日期</label>
                    <div class="col-sm-10" style="width: 300px;">
                        <input id="birthday" name="birthday" type="text" class="form-control" value="${user.birthday}">
                    </div>
                    <label for="phone" class="col-sm-2 control-label">联系方式</label>
                    <div class="col-sm-10" style="width: 300px;">
                        <input id="phone" name="phone" type="text" class="form-control"
                               onblur="checkPhone()" onfocus="$('#phoneErrorMessage').html('');"
                               value="${user.phone}" autocomplete="off">
                        <input type="hidden" id="oldPhone" value="${user.phone}" disabled="disabled">
                        <span id="phoneErrorMessage" style="color: red"></span>
                    </div>
                </div>
                <div style="text-align: center">
                    <button type="button" class="btn btn-default" onclick="window.location.href='user/list'">返回</button>
                    <button type="button" class="btn btn-primary" onclick="saveUser();">更新</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
