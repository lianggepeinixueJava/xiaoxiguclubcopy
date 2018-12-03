package com.lianggege.xiaoxigu.controller;

import com.lianggege.xiaoxigu.model.User;
import com.lianggege.xiaoxigu.service.UserService;
import com.lianggege.xiaoxigu.util.DateUtil;
import com.lianggege.xiaoxigu.util.UUIDGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author lianggepeinixueJava
 * @date 2018/11/30 17:13:19
 */
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 获取用户列表
     *
     * @param model
     * @return
     */
    @RequestMapping({"/user/list", "/"})
    public String list(Model model) {
        List<User> userList = userService.getAll();
        model.addAttribute("userList", userList);
        return "user/list";
    }

    /**
     * 条件查询用户
     *
     * @param nameOrAccount
     * @param age
     * @param startTime
     * @param endTime
     * @return
     */
    @RequestMapping("/user/getByCondition")
    @ResponseBody
    public Map<String, Object> getByCondition(@RequestParam(value = "nameOrAccount", required = false) String nameOrAccount,
                                              @RequestParam(value = "age", required = false) String age,
                                              @RequestParam(value = "startTime", required = false) String startTime,
                                              @RequestParam(value = "endTime", required = false) String endTime) {
        Map<String, Object> paramMap = new ConcurrentHashMap<>(16);
        paramMap.put("nameOrAccount", nameOrAccount);
        paramMap.put("age", age);
        paramMap.put("startTime", startTime);
        paramMap.put("endTime", endTime);
        Map<String, Object> retMap = new ConcurrentHashMap<>(16);
        try {
            List<User> userList = userService.getByCondition(paramMap);
            retMap.put("userList", userList);
            retMap.put("success", true);
        } catch (Exception e) {
            retMap.put("success", false);
            e.printStackTrace();
        }
        return retMap;
    }

    /**
     * 验证登录名
     *
     * @param account
     * @return
     */
    @RequestMapping("/user/checkLoginAct")
    @ResponseBody
    public Map<String, Object> checkLoginAct(@RequestParam("account") String account) {
        Map<String, Object> retMap = new ConcurrentHashMap<>(16);
        User user = userService.checkLoginAct(account);
        if (null != user) {
            retMap.put("success", false);
        } else {
            retMap.put("success", true);
        }
        return retMap;
    }

    /**
     * 跳转到添加用户页面
     *
     * @return
     */
    @RequestMapping("/user/toAdd")
    public String toAdd() {
        return "user/addUser";
    }

    /**
     * 添加用户
     *
     * @param name
     * @param sex
     * @param account
     * @param password
     * @param birthday
     * @param phone
     * @return
     */
    @RequestMapping("/user/add")
    public String add(
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "sex", required = false) String sex,
            @RequestParam(value = "account", required = false) String account,
            @RequestParam(value = "password", required = false) String password,
            @RequestParam(value = "birthday", required = false) String birthday,
            @RequestParam(value = "phone", required = false) String phone) {
        User user = new User();
        user.setId(UUIDGenerator.generate());
        if (null != name && !"".equals(name)) {
            user.setName(name);
        }
        if (null != sex && !"".equals(sex)) {
            user.setSex(sex);
        }
        if (null != birthday && !"".equals(birthday)) {
            user.setBirthday(birthday);
            user.setAge(String.valueOf(Integer.parseInt(DateUtil.getSysTime()) - Integer.parseInt(birthday.substring(0, 4))));
        }
        if (null != account && !"".equals(account)) {
            user.setAccount(account);
        }
        if (null != password && !"".equals(password)) {
            user.setPassword(password);
        }
        if (null != phone && !"".equals(phone)) {
            user.setPhone(phone);
        }
        try {
            int count = userService.add(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:list";
    }

    /**
     * 获取指定用户信息
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("/user/getById")
    public String getById(Model model, @RequestParam("id") String id) {
        User user = userService.getById(id);
        if (null == user) {
            return "redirect:list";
        }
        model.addAttribute("user", user);
        return "user/editUser";
    }

    /**
     * 更新用户信息
     *
     * @param id
     * @param name
     * @param sex
     * @param account
     * @param password
     * @param birthday
     * @param phone
     * @return
     */
    @RequestMapping("/user/update")
    public String update(@RequestParam("id") String id,
                         @RequestParam("name") String name,
                         @RequestParam("sex") String sex,
                         @RequestParam("account") String account,
                         @RequestParam("password") String password,
                         @RequestParam("birthday") String birthday,
                         @RequestParam("phone") String phone) {
        User user = new User();
        user.setId(id);
        user.setName(name);
        user.setSex(sex);
        user.setAccount(account);
        user.setPassword(password);
        user.setBirthday(birthday);
        user.setPhone(phone);
        user.setAge(String.valueOf(Integer.parseInt(DateUtil.getSysTime()) - Integer.parseInt(birthday.substring(0, 4))));
        userService.update(user);
        return "redirect:list";
    }

    /**
     * 删除用户
     *
     * @param request
     * @return
     */
    @RequestMapping("/user/delete")
    @ResponseBody
    public Map<String, Object> delete(HttpServletRequest request) {
        String[] ids = request.getParameterValues("id");
        int count = userService.delete(ids);
        Map<String, Object> retMap = new ConcurrentHashMap<>(16);
        if (count == ids.length) {
            retMap.put("success", true);
        } else {
            retMap.put("success", false);
        }
        return retMap;
    }
}
