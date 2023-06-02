package com.qsh.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.qsh.sys.entity.Menu;
import com.qsh.sys.mapper.MenuMapper;
import com.qsh.sys.service.IMenuService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author qsh
 * @since 2023-05-04
 */
@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements IMenuService {

    @Override
    public List<Menu> getAllMenu() {
        LambdaQueryWrapper<Menu> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Menu::getParentId,0);
        List<Menu> menuList = this.list(wrapper);
        setMenuChildren(menuList);
        return menuList;
    }

    @Override
    public List<Menu> getMenuListBuUserId(Integer userId) {

        List<Menu> menuList = this.baseMapper.getMenuListByUserId(userId, 0);
        serMenuChildrenByUserId(userId, menuList);
        return menuList;
    }

    private void serMenuChildrenByUserId(Integer userId, List<Menu> menuList) {
        if (menuList !=null){
            for(Menu menu: menuList){
                List<Menu> subMenuList = this.baseMapper.getMenuListByUserId(userId, menu.getMenuId());
                menu.setChildren(subMenuList);
                serMenuChildrenByUserId(userId,subMenuList);
            }
        }
    }

    private void setMenuChildren( List<Menu> menuList) {
        if (menuList !=null){
            for(Menu menu: menuList){
                LambdaQueryWrapper<Menu> subWrapper = new LambdaQueryWrapper<>();
                subWrapper.eq(Menu::getParentId,menu.getMenuId());
                List<Menu> subMenuList = this.list(subWrapper);
                menu.setChildren(subMenuList);
                setMenuChildren(subMenuList);
            }
        }
    }
}
