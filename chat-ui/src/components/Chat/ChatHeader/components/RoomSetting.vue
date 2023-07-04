<template>
	<div class="persion">
		<div class="header">
			<el-upload class="avatar-uploader" :action="uploadUrl" :show-file-list="false" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload">
				<img :src="form.roomLogo" class="avatar" />
			</el-upload>
		</div>
		<span class="uuid">专属房间ID: {{ uuid }}</span>
		<div class="form">
			<el-form ref="userForm" :model="form" label-position="right" label-width="80px" size="mini" :rules="rules">
				<el-form-item prop="roomName" label="房间名称">
					<el-input v-model="form.roomName" clearable placeholder="输入您的房间名称" />
				</el-form-item>
				<el-form-item prop="roomNeedPassword" label="房间权限">
					<el-select v-model="form.roomNeedPassword" placeholder="请选择您的房间权限" style="width: 100%">
						<el-option label="房间加密" :value="2"></el-option>
						<el-option label="公开房间" :value="1"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item prop="roomInterval" label="点歌间隔">
					<el-input v-model="form.roomInterval" disabled clearable placeholder="输入您的房间名称" />
				</el-form-item>
				<el-form-item prop="roomSpeak" label="发言权限">
					<el-select v-model="form.roomSpeak" disabled placeholder="请选择您的发言权限" style="width: 100%">
						<el-option label="允许所有人发言" :value="1"></el-option>
						<el-option label="禁止所有人发言" :value="2"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item prop="roomChoose" label="点歌权限">
					<el-select v-model="form.roomChoose" disabled placeholder="请选择您的点歌权限" style="width: 100%">
						<el-option label="允许所有人点歌" :value="1"></el-option>
						<el-option label="禁止所有人点歌" :value="2"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item prop="roomPassword" label="房间密码">
					<el-input v-model="form.roomPassword" show-password clearable placeholder="如不更改，无需填写" />
				</el-form-item>
				<el-form-item prop="roomNotice" label="房间公告">
					<el-input v-model="form.roomNotice" type="textarea" :rows="5" placeholder="请填写房间公告、以英文,换行" />
				</el-form-item>
			</el-form>
			<div class="btns">
				<el-button class="btn" size="mini" type="danger" @click="removeRoomBgImg">移除房间背景</el-button>
				<el-button class="btn" size="mini" type="primary" @click="updateUser">更新资料</el-button>
			</div>
		</div>
	</div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import { updateRoomInfo } from "@/api/chat";
import config from '@/config'

export default {
  name: "PersionInfo",
  components: {},
  data() {
    return {
      uploadUrl: config.fileUploadUrl,
      imageUrl: "",
      uuid: "",
      form: {
      	roomId: null,
        roomName: null,
        roomNotice: null,
        roomNeedPassword: null,
        roomPassword: null,
        roomLogo: null,
        roomSpeak: 1,
        roomChoose: 1,
        roomInterval: 8,
      },
      rules: {
        roomName: [
          { required: true, message: "请输入您房间名称", trigger: "blur" },
          { min: 1, max: 12, message: "长度在1到10个字符", trigger: "blur" },
        ],
        roomNotice: [
          { required: true, message: "请输入房间公告", trigger: "blur" },
          { max: 512, message: "最长为512字符", trigger: "blur" },
        ],
        roomNeedPassword: [
          { required: true, message: "请设置房间权限", trigger: "change" },
        ],
      },
    };
  },
  computed: {
    ...mapGetters(["mineId", "roomInfo"]),
  },
  created() {
    this.initRoomInfo();
  },
  methods: {
    ...mapActions(["getRoomInfo"]),
    handleAvatarSuccess(res) {
      if (!res.data[0].url) return this.$message.error("上传头像失败");
      this.form.roomLogo = res.data[0].url;
    },
    beforeAvatarUpload(file) {
      const isLt1M = file.size / 1024 / 1024 < 1;
      if (!isLt1M) {
        this.$message.error("上传头像图片大小不能超过1MB!");
      }
      return isLt1M;
    },

    initRoomInfo() {
      if (!this.roomInfo) return;
      const { roomName, roomNotice, roomNeedPassword, roomLogo, roomId } =
        this.roomInfo;
      Object.assign(this.form, {
        roomName,
        roomNotice,
        roomNeedPassword,
        roomLogo,
        roomId,
      });
      this.uuid = roomId.toString().padStart(3, 0);
    },

    updateUser() {
      this.$refs.userForm.validate(async (valid) => {
        if (!valid) return;
        await updateRoomInfo(this.form);
        this.$message.success("修改房间设置完成");
        /* 修改完重新查一次保证本地数据是最新的 */
        await this.getRoomInfo();
        /* 数据格式同步于服务端connectSuccess */
        const {
          roomName,
          roomNotice,
          roomNeedPassword,
          roomId,
          roomBgImg,
          roomLogo,
        } = this.form;
        /* 这个页面只能房主操作，所以这里的roomUserId就是自己 */
        const newRoomInfo = {
          roomName,
          roomNotice,
          roomNeedPassword,
          roomBgImg,
          roomLogo,
          roomId,
          roomUserId: this.mineId,
        };
        /* 通知服务端聊天室需要更新房间的信息 */
        this.$socket.client.connected &&
          this.$socket.client.emit("updateRoomInfo", newRoomInfo);
      });
    },

    /* 移除房间背景 */
    async removeRoomBgImg() {
      await updateRoomInfo({ roomBgImg: "", roomId: this.form.roomId });
      this.$message.success("已移除掉您的房间背景！");
      /* 修改完重新查一次保证本地数据是最新的 */
      await this.getRoomInfo();
      const {
        roomName,
        roomNotice,
        roomNeedPassword,
        roomId,
        roomBgImg,
        roomLogo,
      } = this.form;
      const newRoomInfo = {
        roomName,
        roomNotice,
        roomNeedPassword,
        roomBgImg,
        roomLogo,
        roomId,
        roomUserId: this.mineId,
      };
      /* 通知服务端聊天室需要更新房间的信息 */
      this.$socket.client.connected &&
        this.$socket.client.emit("updateRoomInfo", newRoomInfo);
    },
  },
};
</script>
<style lang="less" scoped>
.persion {
  padding: 0 15px;
  padding-bottom: 10px;
  display: flex;
  align-items: center;
  flex-direction: column;

  .uuid {
    display: inline-block;
    font-size: 12px;
    background: #ccc;
    padding: 2px 5px;
    color: #fff;
    font-weight: 600;
    border-radius: 5px;
    margin-top: 5px;
  }

  .form {
    width: 100%;
    margin-top: 15px;
  }

  .btns {
    display: flex;
    justify-content: flex-end;
    .btn {
      margin-left: 10px;
    }
  }
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 80px;
  height: 80px;
  line-height: 80px;
  text-align: center;
  border-radius: 6px;
  border: 1px dashed #ccc !important;
}
.avatar {
  width: 80px;
  height: 80px;
  border-radius: 6px;
  display: block;
  border: 1px solid #ddd8d8;
}
</style>
