<%--
  Author: lianggepeinixueJava
  Date: 2018/11/28 8:56
--%>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>添加用户 - 小戏骨俱乐部成员管理系统</title>
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
            var flag = true;

            //登录账号不能为空
            if ("" === account) {
                $("#accountErrorMessage").html("请输入登录账号");
                return false;
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
            var phone = $.trim($("#phone").val());
            var flag = true;
            //手机号不能为空
            if ("" === phone) {
                $("#phoneErrorMessage").html("请输入手机号码");
                return false;
            } else if (!/^1[1-9]\d{9}$/.test(phone)) {
                //验证手机号的格式
                $("#phoneErrorMessage").html("请输入正确的手机号码");
                return false;
            } else {
                $("#phoneErrorMessage").html("");
            }
            return flag;
        }

        //保存
        function saveUser() {
            if (checkLoginAct() && checkPhone()) {
                $("#addUserForm").submit();
            }
        }

    </script>
</head>
<body>
<div>
    <div>
        <div style="text-align: center">
            <h4>添加用户</h4>
        </div>
        <br>
        <div>
            <form id="addUserForm" class="form-horizontal" action="user/add" method="post">
                <div class="form-group">
                    <label for="name" class="col-sm-2 control-label">姓名</label>
                    <div class="col-sm-10" style="width: 300px;">
                        <input id="name" name="name" type="text" class="form-control" autocomplete="off">
                    </div>
                    <label for="sex" class="col-sm-2 control-label">性别</label>
                    <div class="col-sm-10" style="width: 300px;">
                        <select id="sex" name="sex" class="form-control">
                            <option></option>
                            <option value="1">男</option>
                            <option value="0">女</option>
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
                               autocomplete="off">
                        <span id="accountErrorMessage" style="color: red"></span>
                    </div>
                    <label for="password" class="col-sm-2 control-label">登陆密码</label>
                    <div class="col-sm-10" style="width: 300px;">
                        <input id="password" name="password" type="text" class="form-control" autocomplete="off">
                    </div>
                </div>
                <div class="form-group">
                    <label for="birthday" class="col-sm-2 control-label">出生日期</label>
                    <div class="col-sm-10" style="width: 300px;">
                        <input id="birthday" name="birthday" type="text" class="form-control" autocomplete="off">
                    </div>
                    <label for="phone" class="col-sm-2 control-label">联系方式</label>
                    <div class="col-sm-10" style="width: 300px;">
                        <input id="phone" name="phone" type="text" class="form-control"
                               onblur="checkPhone()" onfocus="$('#phoneErrorMessage').html('');"
                               autocomplete="off">
                        <span id="phoneErrorMessage" style="color: red"></span>
                    </div>
                </div>
                <div style="text-align: center">
                    <button id="clearBtn" type="button" class="btn btn-default"
                            onclick="$('#addUserForm')[0].reset();
                                     $('#phoneErrorMessage').html('');
                                     $('#accountErrorMessage').html('');">
                        重置
                    </button>
                    <button id="saveBtn" type="button" class="btn btn-primary" onclick="saveUser();">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
