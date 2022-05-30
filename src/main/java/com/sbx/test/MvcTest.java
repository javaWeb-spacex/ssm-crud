package com.sbx.test;

import com.github.pagehelper.PageInfo;
import com.sbx.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.Arrays;
import java.util.List;

/**
 * @author :sbx
 * @date :2022/5/29 23:51
 * @description :使用Spring测试模块提供的请求功能,测试crud请求正确性
 * junit4测试的时候需要servlet3.0的支持
 * @version: :1.0.0
 */
@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:/src/main/webapp/WEB-NF/springMVC.xml"})
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:springMVC.xml"})
@WebAppConfiguration
public class MvcTest {

    //传入springMvc的ioc容器
    @Autowired
    private WebApplicationContext context;

    //虚拟的mvc请求,获取到处理结果
    private MockMvc mockMvc;

    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1"))
                .andReturn();

        //请求成功后,请求域中会有pageInfo,我们可以取出pageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码" + pageInfo.getPageNum());
        System.out.println("总页码" + pageInfo.getPages());
        System.out.println("总记录数" + pageInfo.getTotal());
        System.out.println("在页面需要连续显示的页码"+ Arrays.toString(pageInfo.getNavigatepageNums()));
//        int[] nums = pageInfo.getNavigatepageNums();
//
//        for (int i : nums) {
//            System.out.println(" " + i);
//        }


        //获取员工数据
        List<Employee> lists = pageInfo.getList();
        lists.forEach(list -> System.out.println(list.getEmpId()+" "+list.getEmpName()));

    }
}
