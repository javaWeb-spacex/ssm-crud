package com.sbx.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sbx.bean.Employee;
import com.sbx.bean.Msg;
import com.sbx.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author :sbx
 * @date :2022/5/29 23:20
 * @description :
 * @version: :1.0.0
 */
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //引入PageHelper分页插件
        //在查询之前只需要调用,传入页码,以及每页的大小
        PageHelper.startPage(pn, 5);
        //之后紧跟的这个查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果
        PageInfo<Employee> pageInfo = new PageInfo<>(emps,5);
       return  Msg.success().add("pageInfo",pageInfo);
    }

//    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
//        //引入PageHelper分页插件
//        //在查询之前只需要调用,传入页码,以及每页的大小
//        PageHelper.startPage(pn, 5);
//        //之后紧跟的这个查询就是分页查询
//        List<Employee> emps = employeeService.getAll();
//        //使用pageInfo包装查询后的结果
//        PageInfo<Employee> pageInfo = new PageInfo<>(emps,5);
//        model.addAttribute("pageInfo", pageInfo);
//        return "list";
//    }
}
