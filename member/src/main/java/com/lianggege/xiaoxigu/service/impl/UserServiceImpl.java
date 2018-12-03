package com.lianggege.xiaoxigu.service.impl;

import com.lianggege.xiaoxigu.dao.UserMapper;
import com.lianggege.xiaoxigu.model.User;
import com.lianggege.xiaoxigu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author lianggepeinixueJava
 * @date 2018/11/30 17:19:30
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 获取用户列表
     *
     * @return
     */
    @Override
    public List<User> getAll() {
        return userMapper.getAll();
    }

    /**
     * 条件查询用户
     *
     * @param paramMap
     * @return
     */
    @Override
    public List<User> getByCondition(Map<String, Object> paramMap) {
        return userMapper.getByCondition(paramMap);
    }

    /**
     * 验证登录名
     *
     * @param account
     * @return
     */
    @Override
    public User checkLoginAct(String account) {
        return userMapper.checkLoginAct(account);
    }

    /**
     * 添加用户
     *
     * @param user
     */
    @Override
    public int add(User user) {
        return userMapper.insertSelective(user);
//        return userMapper.add(user);
    }

    /**
     * 获取指定用户信息
     *
     * @param id
     * @return
     */
    @Override
    public User getById(String id) {
        return userMapper.getById(id);
    }

    /**
     * 更新用户信息
     *
     * @param user
     * @return
     */
    @Override
    public int update(User user) {
        return userMapper.updateByPrimaryKeySelective(user);
    }

    /**
     * 删除用户
     *
     * @param ids
     * @return
     */
    @Override
    public int delete(String[] ids) {
        return userMapper.delete(ids);
    }
}
