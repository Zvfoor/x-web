package com.qsh.sys.mapper;

import com.qsh.sys.entity.Menu;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author qsh
 * @since 2023-05-04
 */
public interface MenuMapper extends BaseMapper<Menu> {
   public List<Menu> getMenuListByUserId(@Param("userId") Integer userId,@Param("pid") Integer pid);
}
