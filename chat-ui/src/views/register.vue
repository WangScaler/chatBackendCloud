<template>
    <div class="login">
        <div class="login-container">
            <div class="logo">
                <img src="../assets/logo.gif"/>
                <span class="logo-name">音乐聊天室</span>
            </div>

            <div class="form">
                <el-form ref="registerForm" :model="form" :rules="rules">
                    <el-form-item prop="userName">
                        <el-input v-model="form.userName" clearable placeholder="您的账号" size="medium"></el-input>
                    </el-form-item>
                    <el-form-item prop="userNick">
                        <el-input v-model="form.userNick" clearable placeholder="您的昵称" size="medium"></el-input>
                    </el-form-item>
                    <el-form-item prop="userEmail">
                        <el-input v-model="form.userEmail" clearable placeholder="您的邮箱" size="medium"></el-input>
                    </el-form-item>
                    <el-form-item prop="userPassword">
                        <el-input v-model="form.userPassword" clearable show-password placeholder="您的账户密码" size="medium"
                                  @keyup.native.enter="register"></el-input>
                    </el-form-item>
                </el-form>
            </div>

            <el-button style="width: 100%" type="primary" size="medium" @click="register">注册&登录</el-button>
            <div class="links">
                <a @click="$router.push('/login')">已有账号去登录</a>
            </div>
        </div>
    </div>
</template>

<script>
    import {register, login} from "@/api/user";
    import {setToken} from '@/utils/auth';

    export default {
        components: {},
        data() {
            return {
                form: {
                    userName: null,
                    userNick: null,
                    userEmail: null,
                    userPassword: null,
                    userPassword2: null,
                },
                rules: {
                    userName: [
                        {required: true, message: "请输入您的账号", trigger: "blur"},
                        {min: 1, max: 8, message: "长度在1至8个字符", trigger: "blur"},
                    ],
                    userNick: [
                        {required: true, message: "请输入您的昵称", trigger: "blur"},
                        {min: 1, max: 8, message: "长度在1到8个字符", trigger: "blur"},
                    ],
                    userEmail: [
                        {required: true, message: "请输入您的邮箱", trigger: "blur"},
                        {
                            type: "email",
                            message: "请输入正确的邮箱地址",
                            trigger: ["blur", "change"],
                        },
                    ],
                    userPassword: [
                        {required: true, message: "请输入您的账户密码", trigger: "blur"},
                        {min: 6, max: 32, message: "长度在6到32个字符", trigger: "blur"},
                    ],
                },
            };
        },
        computed: {},
        watch: {},
        created() {
        },
        mounted() {
        },
        methods: {
            register() {
                this.$refs.registerForm.validate(async (valid) => {
                    if (!valid) return;
                    await register(this.form).then((res) => {
                        if (res.code != 200) {
                            this.$message.error(res.msg);
                            return
                        }
                        this.$message.success("注册成功，即将登录！");
                        setTimeout(async () => {
                            await login(this.form).then((res) => {
                                if (res.code != 200) {
                                    this.$message.success(res.msg);
                                    return
                                }
                                setToken(res.data)
                                localStorage.userName = this.form.userName;
                                localStorage.userPassword = this.form.userPassword;
                                this.$router.push("/");
                                });
                        }, 1000);
                    })
                    .catch((err) => {
                        console.log(err);
                    })
                });
            },
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
                justify-content: flex-end;
                font-size: 12px;
                cursor: pointer;
                color: #fff;
                margin-top: 15px;
            }
        }
    }
</style>
