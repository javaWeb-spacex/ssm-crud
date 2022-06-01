package com.sbx.controller;

import com.sbx.bean.Department;
import com.sbx.bean.Msg;
import com.sbx.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * @author :sbx
 * @date :2022/5/31 11:19
 * @description :处理和部门有关的请求
 * @version: :1.0.0
 */
@Controller
public class DeptmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 获取部门信息
     * @return
     * @throws InterruptedException
     */
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts() throws InterruptedException {
//        Thread.sleep(1000);
        List<Department> depts=departmentService.getDepts();
        return Msg.success().add("depts",depts);
    }
}
