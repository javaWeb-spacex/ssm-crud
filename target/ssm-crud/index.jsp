<%--
  Created by IntelliJ IDEA.
  User: spacex
  Date: 2022/5/29
  Time: 23:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<!-- 员工修改模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <%--empName--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName:</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_update_input"
                                   disabled="disabled"
                                   onblur="checkEmpNameValidity('#empName_update_input')"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <%--email--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email:</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   onblur="checkEmailValidity('#email_update_input')"
                                   placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <%--gender--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender:</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <%--deptName--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName:</label>
                        <div class="col-sm-4">
                            <%--部门提交部门Id即可--%>
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <%--按钮--%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <%--empName--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName:</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   onblur="checkEmpNameValidity('#empName_add_input')"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <%--email--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email:</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   onblur="checkEmailValidity('#email_add_input')"
                                   placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <%--gender--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender:</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <%--deptName--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName:</label>
                        <div class="col-sm-4">
                            <%--部门提交部门Id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <%--按钮--%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

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
            <button class="btn btn-primary" id="emp_add_modal_btn">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button class="btn btn-danger">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>刪除
            </button>
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
    //页面总记录数
    var totalRecord = 0;
    //页面显示条数
    var pageSize = 5;
    //当前页
    var currentPage = null;

    //=======================================================查询页面=============================================================================
    //页面加载完成，直接发送一个ajax请求，要到分页数据
    $(function () {
        //去首页
        to_page(1);
    });

    /**
     * 跳转到指定页面
     * @param pn
     */
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

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义属性,来存放当前员工的Id
            editBtn.attr("emp-id", item.empId);
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义属性,来存放当前员工的Id
            deleteBtn.attr("emp-id", item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);

            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }


    /**
     * 解析并显示分页信息
     * @param result
     */
    function build_page_info(result) {
        //清空原来的数据
        $("#page_info_area").empty();
        var pageInfo = result.extend.pageInfo;
        totalRecord = pageInfo.total;
        pageSize = pageInfo.pageSize;
        currentPage = pageInfo.pageNum;
        $("#page_info_area").append("当前" + pageInfo.pageNum + "页，总共" + pageInfo.pages + "页，总共" + pageInfo.total + "条记录");
    }

    /**
     * 解析并显示分页条
     * @param result
     */
    function build_page_nav(result) {
        //清空原来的数据
        $("#page_nav_area").empty();

        var pageInfo = result.extend.pageInfo;
        //构建首页、上一页元素
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        if (pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加点击事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(pageInfo.pageNum - 1);
            });
        }

        //构建下一页、末页元素
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页"));

        if (pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            //为元素添加点击事件
            nextPageLi.click(function () {
                to_page(pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(pageInfo.pages);
            });
        }

        //将构建的元素添加到分页条中
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

    /**
     * 新增按钮触发事件
     */
    $("#emp_add_modal_btn").click(function () {
        //重置表单数据以及样式
        reset_form("#empAddModal form");
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#dept_add_select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop: 'static',
        });
    });

    //=======================================================新增页面=========================================================================================
    /**
     * 查出所有的部门信息并显示在下拉列表中
     */
    function getDepts(ele) {
        //清空原来数据
        $(ele).empty();

        $.ajax({
            url: "${APP_PATH}/depts",
            data: "",
            type: "GET",
            async: false,
            success: function (result) {
                //{"code":100,"msg":"处理成功","extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            },
        });
    }

    /**
     * 新增页面-点击保存按钮触发事件
     */
    $("#emp_save_btn").click(function () {
        //用户名数据校验
        if (checkEmpNameValidity('#empName_add_input') == false) {
            return false;
        }
        //邮箱数据正确性校验
        if (checkEmailValidity('#email_add_input') == false) {
            return false;
        }

        //将模态框中填写的表单数据提交给服务器进行保存
        $.ajax({
            url: "${APP_PATH}/emp",
            data: $("#empAddModal form").serialize(),
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    //关闭模态框
                    $("#empAddModal").modal("hide");
                    //来到最后一页，显示刚才的数据
                    to_page(Math.ceil((totalRecord + 1) / pageSize));
                } else {
                    //显示失败信息
                    if (result.extend.errorFields.email != undefined) {
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (result.extend.errorFields.empName != undefined) {
                        //显示用户名错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }
            },
        });
    });

    /**
     * 显示校验结果的提示信息
     * @param ele
     * @param status
     * @param msg
     */
    function show_validate_msg(ele, status, msg) {
        //清空当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");

        if ("success" == status) {
            $(ele).parent().addClass("has-success");
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
        }
        $(ele).next("span").text(msg);
    }


    /**
     * 重置表单
     */
    function reset_form(ele) {
        //清除表单数据(JQ没有该重置方法，该重置方法是document对象的)
        $(ele)[0].reset();
        //清空表单的样式
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }


    /**
     * 用户名重复性校验
     */
    function checkEmpName(ele) {
        //发送ajax请求校验用户名是否可用
        var flag = false;
        $.ajax({
            url: "${APP_PATH}/checkEmpName",
            data: "empName=" + $(ele).val(),
            type: "GET",
            async: false,
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg(ele, "success", "用户名可用");
                    flag = true;
                } else {
                    show_validate_msg(ele, "error", result.extend.va_msg);
                    flag = false;
                }
            },
        });
        return flag;
    }

    /**
     * 用户名数据校验(正确性、重复性)
     */
    function checkEmpNameValidity(ele) {
        //清空原來的样式
        $(ele).empty();
        //校验用户名信息正确性
        var empName = $(ele).val();
        var regName = /^[\u2E80-\u9FFFa-zA-Z0-9_-]{2,16}$/;
        if (!regName.test(empName)) {
            show_validate_msg(ele, "error", "用户名可以是2-16位英文，数字，下划线，减号，中文");
            return false;
        }
        show_validate_msg(ele, "success", "");
        //用户名重复性校验
        if (checkEmpName(ele) == false) {
            return false;
        }
        return true;
    }

    /**
     * 邮箱数据正确性校验
     */
    function checkEmailValidity(ele) {
        //清空原來的样式
        $(ele).empty();
        //校验用户名信息正确性
        var email = $(ele).val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg(ele, "error", "邮箱格式不正确");
            return false;
        }
        show_validate_msg(ele, "success", "");
        return true;
    }

    /* /!**
      * 前端数据正确性校验方法（新增）
      *!/

     function validata_add_from() {
         //校验用户名信息
         var empName = $("#empName_add_input").val();
         var regName = /^[\u2E80-\u9FFFa-zA-Z0-9_-]{2,16}$/;
         //清空
         $("#empName_add_input").empty();
         if (!regName.test(empName)) {
             // alert("用户名可以是2-16位英文，数字，下划线，减号，中文");
             show_validate_msg("#empName_add_input", "error", "用户名可以是2-16位英文，数字，下划线，减号，中文");
             return false;
         } else {
             show_validate_msg("#empName_add_input", "success", "");
         }

         //校验邮箱信息
         var email = $("#email_add_input").val();
         var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
         $("#email_add_input").empty();
         if (!regEmail.test(email)) {
             //alert("邮箱格式不正确");
             show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
             return false;
         } else {
             show_validate_msg("#email_add_input", "success", "");
         }
         return true;
     }*/

    //====================================================修改页面========================================================================
    /**
     * 编辑按钮绑定事件
     *
     * 我们是按钮创建之前就绑定了click,所以绑定不上，、
     * 1.在创建按钮的时候就绑定事件
     * 2.绑定点击事件 live() 新版的jquery没有live方法 使用on方法进行替代
     *
     */
    $(document).on("click", ".edit_btn", function () {
        //重置表单数据以及样式
        reset_form("#empUpdateModal form");
        //查出部门信息，并显示部门列表
        getDepts("#dept_update_select");
        //查出员工信息，并显示员工信息
        getEmpById($(this).attr("emp-id"));
        //将员工id传递给模态框更新按钮
        $('#emp_update_btn').attr("emp-id", $(this).attr("emp-id"))
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop: 'static',
        });

    });

    /**
     * 根据id查询员工信息
     */
    function getEmpById(empId) {
        $.ajax({
            url: "${APP_PATH}/emp/" + empId,
            data: "",
            type: "GET",
            success: function (result) {
                var employee = result.extend.employee;
                setFormValue(employee);
            },
        });

    }

    /**
     * 为更新模态框中的form表单赋值
     * @param employee
     */
    function setFormValue(employee) {
        $("#empName_update_input").text(employee.empName);
        $("#email_update_input").val(employee.email);
        $("#empUpdateModal input[name=gender]").val([employee.gender]);
        $("#dept_update_select").val([employee.dId]);
        console.log($("#empUpdateModal form").serialize())
    }

    /**
     * 点击更新按钮更新员工信息
     */
    $("#emp_update_btn").click(function () {
        //邮箱数据正确性校验
        if (checkEmailValidity('#email_update_input') == false) {
            return false;
        }
        /**
         * 发送ajax请求，保存更新的数据 (浏览器不支持发put,delete请求)
         * 1.如果发送post请求请求参数需要添加_method=PUT，并配置org.springframework.web.filter.HiddenHttpMethodFilter监听器
         * 2.如果直接发PUT,请求体中有数据，但是Employee对象封装不上；实际上是HttpServletRequest中没有值，即request.getParameter("XXX")是null
         *
         * 原因：
         * Tomcat：
         *        1、将请求体中的数据，封装一个map。
         *        2、request.getParameter("empName")就会从这个map中取值。
         *        3、SpringMVC封装POJO对象的时候。会通过request.getParamter("XXX")获取属性值;
         *
         * AJAX发送PUT请求引发的血案：
         *        PUT请求，请求体中的数据，request.getParameter("empName")拿不到
         *        Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
         * 源码：
         *      org.apache.catalina.connector.Request.parseParameters() (3111);
         *
         *          protected String parseBodyMethods = "POST";
         *          if( !getConnector().isParseBodyMethod(getMethod()) ) {
         *             success = true;
         *             return;
         *          }
         *
         */

        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("emp-id"),
            data: $("#empUpdateModal form").serialize(),
            type: "PUT",
            success: function (result) {
                console.log(result);

                if (result.code == 100) {
                    //关闭模态框
                    $("#empUpdateModal").modal("hide");
                    //来到最后一页，显示刚才的数据
                    to_page(currentPage);
                } else {
                    //显示失败信息
                    if (result.extend.errorFields.email != undefined) {
                        //显示邮箱错误信息
                        show_validate_msg("#email_update_input", "error", result.extend.errorFields.email);
                    }
                }
            },
        });

    })

</script>

</body>
</html>
