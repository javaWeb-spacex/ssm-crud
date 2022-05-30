<%--
  Created by IntelliJ IDEA.
  User: spacex
  Date: 2022/5/29
  Time: 23:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <%--web路径:
        不以/开始的相对lu'j路劲,找资源以当前资源的路径为基准,经常容易出问题
         以/开始的相对路径找资源,以服务器的路径为标准( http://localhost:3306);
            http://localhost:3306/crud
    --%>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css"
          integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">

    <!-- jQuery -->
    <script src="${APP_PATH}/static/js/jquery-1.12.4.min.js" type="text/javascript"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"
            integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd"
            crossorigin="anonymous"></script>

</head>
<body>

<%--搭建显示页面--%>
<div class="container">

    <%--标题行--%>
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-8">
            <h1>SSM-CRUD</h1>
        </div>
    </div>

    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">刪除</button>
        </div>
    </div>

    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table-bordered" id="emps_table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>

    <%--显示分页信息--%>
    <div class="row">

        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area"></div>

        <%--分页条--%>
        <div class="col-md-5 col-md-offset-7" id="page_nav_area"></div>
    </div>
</div>
<script type="text/javascript">
    //页面加载完成，直接发送一个ajax请求，要到分页数据
    $(function () {
        //去首页
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //1.解析并显示员工数据
                build_emps_table(result)

                //2.解析并显示分页信息
                build_page_info(result);

                //3.解析并显示分页条
                build_page_nav(result);
            }

        });
    }

    /**
     * 1.解析并显示员工数据
     * @param result
     */
    function build_emps_table(result) {
        //清空原来的数据
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {

            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var gender = item.gender == 'M' ? '男' : '女';
            var genderTd = $("<td></td>").append(gender);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);

            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }


    /**
     * 解析并显示分页信息
     * @param result
     */
    function build_page_info(result) {
        //清空原来的数据
        $("#page_info_area").empty();
        var pageInfo = result.extend.pageInfo;
        $("#page_info_area").append("当前" + pageInfo.pageNum + "页，总共" + pageInfo.pages + "页，总共" + pageInfo.total + "条记录")
    }

    /**
     * 解析并显示分页条
     * @param result
     */
    function build_page_nav(result) {
        //清空原来的数据
        $("#page_nav_area").empty();
        var pageInfo = result.extend.pageInfo;

        //构建元素
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled")
            prePageLi.addClass("disabled")
        }else{
            //为元素添加点击事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(pageInfo.pageNum - 1);
            });
        }

        //构建元素
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页"));

        if (pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled")
            lastPageLi.addClass("disabled")
        }else{
            //为元素添加点击事件
            nextPageLi.click(function () {
                to_page(pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(pageInfo.pages);
            });
        }



        ul.append(firstPageLi).append(prePageLi);

        $.each(pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (pageInfo.pageNum == item) {
                numLi.addClass("active")
            }
            numLi.click(function () {
                to_page(item)
            })
            ul.append(numLi);
        });

        ul.append(nextPageLi).append(lastPageLi);
        var nav = $("<nav></nav>").append(ul).attr("aria-label", "Page navigation").appendTo("#page_nav_area");
    }

</script>

</body>
</html>
