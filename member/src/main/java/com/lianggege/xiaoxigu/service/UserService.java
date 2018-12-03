package com.lianggege.xiaoxigu.service;

import com.lianggege.xiaoxigu.model.User;

import java.util.List;
import java.util.Map;

/**
 * @author lianggepeinixueJava
 * @date 2018/11/30 17:18:38
 */
public interface UserService {

    /**
     * 获取用户列表
     *
     * @return
     */
    List<User> getAll();

    /**
     * 条件查询用户
     *
     * @param paramMap
     * @return
     */
    List<User> getByCondition(Map<String, Object> paramMap);

    /**
     * 验证登录名
     *
     * @param account
     * @return
     */
    User checkLoginAct(String account);

    /**
     * 添加用戶
     *
     * @param user
     * @return
     */
    int add(User user);

    /**
     * 获取指定用户信息
     *
     * @param id
     * @return
     */
    User getById(String id);

    /**
     * 更新用户信息
     *
     * @param user
     * @return
     */
    int update(User user);

    /**
     * 删除用户
     *
     * @param ids
     * @return
     */
    int delete(String[] ids);
}
