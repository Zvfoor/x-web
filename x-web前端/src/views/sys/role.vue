<template>
  <div>
    <el-card id="search">
      <el-row>
        <el-col :span="20">
          <el-input
            v-model="searchModel.roleName"
            placeholder="角色名称"
            clearable
          ></el-input>

          <el-button
            type="primary"
            @click="getRoleList"
            round
            icon="el-icon-search"
            >查询</el-button
          >
        </el-col>
        <el-col :span="4" align="right">
          <el-button
            type="primary"
            icon="el-icon-plus"
            @click="openEditUI(null)"
            circle
          ></el-button>
        </el-col>
      </el-row>
    </el-card>

    <el-card>
      <el-table :data="roleList" stripe style="width: 100%">
        <el-table-column label="#" width="80">
          <template slot-scope="scope">
            {{
              (searchModel.pageNo - 1) * searchModel.pageSize + scope.$index + 1
            }}
          </template>
        </el-table-column>
        <el-table-column prop="roleId" label="角色ID" width="200">
        </el-table-column>
        <el-table-column
          prop="roleName"
          label="角色名称"
          width="280"
        ></el-table-column>

        <el-table-column prop="roleDese" label="角色描述"> </el-table-column>
        <el-table-column label="操作" width="180">
          <template slot-scope="scope">
            <el-button
              @click="openEditUI(scope.row.roleId)"
              type="primary"
              icon="el-icon-edit"
              circle
            ></el-button>
            <el-button
              @click="deleteRole(scope.row)"
              type="danger"
              icon="el-icon-delete"
              circle
            ></el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="searchModel.pageNo"
      :page-sizes="[5, 10, 20, 50]"
      :page-size="searchModel.pageSize"
      layout="total,sizes,prev,pager,next,jumper"
      :total="total"
    >
    </el-pagination>

    <!--角色信息添加对话框-->
    <el-dialog
      @close="clearForm"
      :title="title"
      :visible.sync="dialogFormVisible"
    >
      <el-form :model="roleForm" :rules="rules" ref="roleFormRef">
        <el-form-item
          label="角色名称"
          prop="roleName"
          :label-width="formLabelWidth"
        >
          <el-input v-model="roleForm.roleName" autocomplete="off"></el-input>
        </el-form-item>

        <el-form-item
          label="角色描述"
          prop="roleDesc"
          :label-width="formLabelWidth"
        >
          <el-input v-model="roleForm.roleDesc" autocomplete="off"></el-input>
        </el-form-item>

        <el-form-item
          label="权限设置"
          prop="menuIdList"
          :label-width="formLabelWidth"
        >
          <el-tree
            :data="menuList"
            :props="menuProps"
            show-checkbox
            style="width: 85%"
            default-expand-all
            node-key="menuId"
            ref="menuRef"
          ></el-tree>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveRole">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import roleApi from "@/api/roleManage";
import menuApi from "@/api/menuManage";

export default {
  data() {
    return {
      menuList: [],
      menuProps: {
        children: "children",
        label: "title",
      },
      formLabelWidth: "130px",
      roleForm: {},
      title: "",
      dialogFormVisible: false,
      total: 0,
      searchModel: {
        pageNo: 1,
        pageSize: 10,
      },
      roleList: [],
      rules: {
        roleName: [
          { required: true, message: "请输入角色名称", trigger: "blur" },
          {
            min: 3,
            max: 15,
            message: "长度在 3 到 15 个字符",
            trigger: "blur",
          },
        ],
        roleDesc: [
          { required: true, message: "请输入角色描述", trigger: "blur" },
          {
            min: 3,
            max: 15,
            message: "长度在 3 到 15 个字符",
            trigger: "blur",
          },
        ],
      },
    };
  },
  methods: {
    getAllMenu() {
      menuApi.getAllMenu().then((response) => {
        this.menuList = response.data;
      });
    },

    deleteRole(role) {
      this.$confirm(`您确认删除角色  #${role.roleName} ?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          roleApi.deleteRoleById(role.roleId).then((response) => {
            this.$message({
              type: "success",
              message: response.message,
            });
            this.getRoleList();
          });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除",
          });
        });
    },
    saveRole() {
      this.$refs.roleFormRef.validate((valid) => {
        if (valid) {
          //获取半选项和已选的数组并将其拼接
          let checkedKeys = this.$refs.menuRef.getCheckedKeys();
          let halfCheckedKeys = this.$refs.menuRef.getHalfCheckedKeys();
          this.roleForm.menuIdList = checkedKeys.concat(halfCheckedKeys);
          roleApi.saveRole(this.roleForm).then((response) => {
            this.$message({
              message: response.message,
              type: "success",
            });
            this.dialogFormVisible = false;
            this.getRoleList();
          });
        } else {
          alert("提交失败，请重试");
          return false;
        }
      });
    },
    clearForm() {
      this.roleForm = {};
      this.$refs.roleFormRef.clearValidate();
      this.$refs.menuRef.setCheckedKeys([]);
    },
    openEditUI(id) {
      if (id == null) {
        this.title = "新增角色";
      } else {
        this.title = "修改角色";
        //根据id查询角色数据
        roleApi.getRoleById(id).then((response) => {
          this.roleForm = response.data;
          this.$refs.menuRef.setCheckedKeys(response.data.menuIdList);
        });
      }
      this.dialogFormVisible = true;
    },
    handleSizeChange(pageSize) {
      this.searchModel.pageSize = pageSize;
      this.getRoleList();
    },
    handleCurrentChange(pageNo) {
      this.searchModel.pageNo = pageNo;
      this.getRoleList();
    },
    //获取用户数据
    getRoleList() {
      roleApi.getRoleList(this.searchModel).then((response) => {
        this.roleList = response.data.rows;
        this.total = response.data.total;
      });
    },
  },

  created() {
    this.getRoleList(); //当页面创建时调用此方法，就上面的getRoleList方法
    this.getAllMenu();
  },
};
</script>

<style>
#search .el-input {
  width: 200px;
  margin-right: 10px;
}
.el-dialog .el-input {
  width: 85%;
}
</style>