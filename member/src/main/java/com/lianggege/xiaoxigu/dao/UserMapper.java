package com.lianggege.xiaoxigu.dao;

import com.lianggege.xiaoxigu.model.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @author lianggepeinixueJava
 * @date 2018/11/30 17：09：28
 */
@Repository
public interface UserMapper {

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user
     *
     * @param id
     * @return
     * @mbggenerated Thu Nov 29 09:06:00 CST 2018
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user
     *
     * @param record
     * @return
     * @mbggenerated Thu Nov 29 09:06:00 CST 2018
     */
    int insert(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user
     *
     * @param record
     * @return
     * @mbggenerated Thu Nov 29 09:06:00 CST 2018
     */
    int insertSelective(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user
     *
     * @param id
     * @return
     * @mbggenerated Thu Nov 29 09:06:00 CST 2018
     */
    User selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user
     *
     * @param record
     * @return
     * @mbggenerated Thu Nov 29 09:06:00 CST 2018
     */
    int updateByPrimaryKeySelective(User record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user
     *
     * @param record
     * @return
     * @mbggenerated Thu Nov 29 09:06:00 CST 2018
     */
    int updateByPrimaryKey(User record);

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
     * 添加用户
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
     * 删除用户
     *
     * @param ids
     * @return
     */
    int delete(String[] ids);
}