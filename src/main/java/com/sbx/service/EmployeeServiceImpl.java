package com.sbx.service;

import com.sbx.bean.Employee;
import com.sbx.bean.EmployeeExample;
import com.sbx.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author :sbx
 * @date :2022/5/29 23:27
 * @description :
 * @version: :1.0.0
 */
@Service
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public List<Employee> getAll() {
        EmployeeExample employeeExample = new EmployeeExample();
        employeeExample.setOrderByClause("emp_id");
        return employeeMapper.selectByExampleWithDept(employeeExample);
    }

    @Override
    public Integer saveEmp(Employee employee) {
        return employeeMapper.insertSelective(employee);
    }

    @Override
    public boolean checkempName(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }
}
