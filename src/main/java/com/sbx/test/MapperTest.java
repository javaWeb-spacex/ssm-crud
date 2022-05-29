package com.sbx.test;

import com.sbx.bean.Department;
import com.sbx.bean.Employee;
import com.sbx.dao.DepartmentMapper;
import com.sbx.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author :sbx
 * @date :2022/5/29 10:11
 * @description :
 * @version: :1.0.0
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private SqlSession sqlSession;

    /**
     * 传统方式：
     *      ApplicationContext applicationContext=new ClassPathXmlApplicationContext("applicationContext.xml");
     *      applicationContext.getBean(DepartmentMapper.class);
     *
     * 推荐spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
     *      1、导入spring-test测试依赖
     *      2、@ContextConfiguration()指定配置文件的位置
     *      3、指定junit的版本
     *      4、直接@Autowired获取需要的组件
     */
    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);
        //插入部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
//        departmentMapper.insertSelective(new Department(null,"人事部"));

        //插入员工数据
//        employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@qq.com",1));

        //批量插入多个员工：批量操作可以使用批量操作的sqlSession

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i=0;i<1000;i++){
            String uuid = UUID.randomUUID().toString().substring(0, 5)+i;
            mapper.insertSelective(new Employee(null,uuid,"M",uuid+"@qq.com",1));
        }

        System.out.println("批量完成");
    }
}
