package com.sbx.service;

import com.sbx.bean.Employee;

import java.util.List;

/**
 * @author :sbx
 * @date :2022/5/29 23:25
 * @description :
 * @version: :1.0.0
 */
public interface EmployeeService {
    List<Employee> getAll();

    Integer saveEmp(Employee employee);

    boolean checkempName(String empName);

    Employee getEmpById(Integer empId);

    Integer UpdateEmp(Employee employee);
}
