package com.sbx.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sbx.bean.Employee;
import com.sbx.bean.Msg;
import com.sbx.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
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
        PageInfo<Employee> pageInfo = new PageInfo<>(emps, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

    /**
     * 新增员工信息
     * 1.支持JSR303校验
     * 2.导入Hibernate-Validator
     * 3.在封装的对象需要校验是属性上添加注解
     * 4.@Valid表示封装的对象数据要进行校验，BindingResult来封装校验的结果
     *
     * @return
     */
    @ResponseBody
    @PostMapping("/emp")
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        //如果有数据校验失败
        if(result.hasErrors()){
            //校验失败以后应该返回失败，在模态框中显示校验失败的错误信息
            HashMap<String, Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError:fieldErrors) {
                System.out.println("错误的字段名"+fieldError.getField());
                System.out.println("错误信息"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            Integer count = employeeService.saveEmp(employee);
            return Msg.success();
        }

    }

    /**
     * 检查用户名是否重复
     *
     * @return
     */
    @ResponseBody
    @GetMapping("/checkEmpName")
    public Msg checkempName(@RequestParam("empName") String empName) {
        //先判断用户名是否是合法的表达式
        String regempName="^[\u2E80-\u9FFFa-zA-Z0-9_-]{2,16}$";
        if(!empName.matches(regempName)){
            return Msg.fail().add("va_msg","用户名可以是2-16位英文，数字，下划线，减号，中文");
        }
        if(employeeService.checkempName(empName)){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }

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
