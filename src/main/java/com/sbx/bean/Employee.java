package com.sbx.bean;


import org.hibernate.validator.constraints.Email;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;


public class Employee {
    private Integer empId;

    @Pattern(regexp = "^[\\u2E80-\\u9FFFa-zA-Z0-9_-]{2,16}$", message = "用户名必须是2-16位英文，数字，下划线，减号，中文")
    private String empName;

    private String gender;

    /**
     * '\' 将下一个字符标为一个特殊字符、或者一个原义字符，但Java中'\'是需要转义的，所以要用'\\'替换'\'
     */
    //@Email
    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$", message = "邮箱格式不正确")
    private String email;

    private Integer dId;

    private Department department;

    public Employee() {
    }

    public Employee(Integer empId, String empName, String gender, String email, Integer dId) {
        this.empId = empId;
        this.empName = empName;
        this.gender = gender;
        this.email = email;
        this.dId = dId;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
}