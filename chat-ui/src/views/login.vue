<template>
	<div class="login">
		<div class="login-container">
			<div class="logo">
				<img src="../assets/logo.gif" />
				<span class="logo-name">音乐聊天室</span>
			</div>

			<div class="form">
				<el-form ref="loginForm" :model="form" :rules="rules">
					<el-form-item prop="userName">
						<el-input v-model="form.userName" clearable placeholder="您的账户或邮箱" size="medium"></el-input>
					</el-form-item>
					<el-form-item prop="userPassword">
						<el-input v-model="form.userPassword" clearable show-password placeholder="您的账户密码" size="medium" @keyup.native.enter="login"></el-input>
					</el-form-item>
				</el-form>
			</div>

			<div class="links">
				<a @click="foegetPassword">忘记密码</a>
				<a @click="$router.push('/register')">注册账号</a>
			</div>

			<el-button style="width: 100%" type="primary" size="medium" @click="login">登录</el-button>
		</div>
	</div>
</template>

<script>
import { login } from "@/api/user";
import { setToken,setUser,getUserByToken } from '@/utils/auth';

export default {
  components: {},
  data() {
    return {
      form: {
        userName: "",
        userPassword: "",
      },
      rules: {
        userName: [
          { required: true, message: "请输入您的账号", trigger: "blur" },
          { min: 1, max: 16, message: "长度在 1 到 16 个字符", trigger: "blur" },
        ],
        userPassword: [
          { required: true, message: "请输入您的账户密码", trigger: "blur" },
          {
            min: 6,
            max: 32,
            message: "长度在 6 到 32 个字符",
            trigger: "blur",
          },
        ],
      },
    };
  },
  computed: {},
  watch: {},
  created() {
    localStorage.userName && (this.form.userName = localStorage.userName);
    localStorage.userPassword &&
      (this.form.userPassword = localStorage.userPassword);
  },
  mounted() {},
  methods: {
    login() {
      this.$refs.loginForm.validate(async (valid) => {
        if (!valid) return;
        await login(this.form).then((res) => {
			if (res.code != 200) {
				this.$message.error(res.msg);
				return
			}
			setToken(res.data)
			setUser(getUserByToken(res.data),this.form.userName,this.form.userPassword)
			this.$router.push("/");
		})
		.catch((err) => {
			console.log(err);
		})
      });
    },
    foegetPassword() {
      return this.$message.warning("暂不支持！");
    }
  },
};
</script>
<style lang="less" scoped>
@media screen and (max-width: 820px) {
  .login-container {
    margin-top: 50px !important;
  }
}
.login {
  background: url("https://jiangly.com/_nuxt/img/banner_111.a6be22c.gif");
  height: 100%;
  display: flex;
  justify-content: center;
  &-container {
    margin-top: 100px;
    .logo {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      margin-top: 100px;

      img {
        width: 80px;
        height: 80px;
        border-radius: 8px;
      }

      &-name {
        font-size: 14px;
        color: #fff;
        margin-top: 10px;
      }
    }

    .form {
      margin-top: 50px;
      width: 300px;
    }

    .links {
      display: flex;
      justify-content: space-between;
      font-size: 12px;
      cursor: pointer;
      color: #fff;
      margin-bottom: 30px;
    }
  }
}
</style>
