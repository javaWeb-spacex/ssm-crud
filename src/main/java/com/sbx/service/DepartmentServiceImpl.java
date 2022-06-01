package com.sbx.service;

import com.sbx.bean.Department;
import com.sbx.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author :sbx
 * @date :2022/5/31 11:22
 * @description :
 * @version: :1.0.0
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> getDepts() {
        return departmentMapper.selectByExample(null);
    }
}
