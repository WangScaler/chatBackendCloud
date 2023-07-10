<template>
	<div class="online">
		<div v-if="!createRoomVisible">
			<!-- 房间列表 -->
			<div
				v-for="(item, index) in roomList"
				:key="index"
				:class="[
          'online-item',
          { official: item.roomId == 888 },
          ,
          { current: item.roomId == roomId },
        ]"
				@click="handlerJoinRoom(item)"
			>
				<img class="online-item-avatar" :src="item.roomLogo" />
				<icon v-if="Number(item.roomId) === roomId" name="chat-room-info-select" scale="2.6" class="mine-room" />
				<div class="online-item-info">
					<div class="online-item-info-name">
						<span>
							<span class="room-num">({{ item.onLineNums }})</span>
							{{ item.roomName }}
						</span>
						<!-- 888官方房间 -->
						<span v-if="item.roomId == 888" class="role hall">官方大厅</span>
						<!-- 房间是否加密状态 -->
						<span v-if="item.roomNeedPassword === 2 && item.roomId != 888" class="lock">
							<icon name="chat-room-info-lock" scale="1.8" />
						</span>
					</div>
					<div class="online-item-info-desc s-1-line">
						{{ item.roomNotice }}
					</div>
				</div>
			</div>
		</div>

		<el-dialog title="更改房间提醒" :visible.sync="showJoinModal" width="320px" top="35vh" append-to-body>
			<span>是否退出当前房间并加入新的房间？</span>
			<span slot="footer" class="dialog-footer">
				<el-button size="mini" @click="showJoinModal = false">我再想想</el-button>
				<el-button type="primary" size="mini" @click="handlerConfirm">确认加入</el-button>
			</span>
		</el-dialog>

		<el-dialog title="当前房间加密" :visible.sync="showPasswordModal" width="30%" top="35vh" append-to-body @click.stop>
			<h5>当前房间加密，请先验证密码</h5>
			<el-form :model="form">
				<el-form-item>
					<el-input v-model="form.password" placeholder="请输入房间密码"></el-input>
				</el-form-item>
			</el-form>
			<span slot="footer" class="dialog-footer">
				<el-button size="mini" @click="showPasswordModal = false">返回房间</el-button>
				<el-button type="primary" size="mini" @click="handlerJoinPasswordRoom">确认加入</el-button>
			</span>
		</el-dialog>

		<!-- 创建房间 -->
		<div v-if="createRoomVisible" class="create">
			<el-form ref="form" label-position="left" label-width="80px" :rules="rules" :model="ruleform" size="mini">
				<el-form-item label="房间名称" prop="roomName">
					<el-input v-model="ruleform.roomName" placeholder="请设置您的房间名称"></el-input>
				</el-form-item>
				<el-form-item label="房间号码" prop="roomId">
					<el-input v-model="ruleform.roomId" placeholder="请设置您的房间ID"></el-input>
				</el-form-item>
				<el-form-item label="是否加密" prop="roomNeedPassword">
					<el-select v-model="ruleform.roomNeedPassword" style="width: 100%" placeholder="请选择房间是否加密">
						<el-option label="加密" :value="1"></el-option>
						<el-option label="不加密" :value="0"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item v-if="Number(ruleform.roomNeedPassword)" label="房间密码" prop="roomPassword">
					<el-input v-model="ruleform.roomPassword" placeholder="请设置您的房间密码"></el-input>
				</el-form-item>
				<el-form-item label="房间公告" prop="roomNotice">
					<el-input v-model="ruleform.roomNotice" type="textarea" :rows="3" placeholder="请设置您的房间公告 英文,为换行"></el-input>
				</el-form-item>
				<el-form-item label="房间头像" porp="roomLogo">
					<el-upload class="avatar-uploader" :action="uploadUrl" :show-file-list="false" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload">
						<img v-if="preImage" :src="preImage" class="avatar" />
						<i v-else class="el-icon-plus avatar-uploader-icon"></i>
					</el-upload>
				</el-form-item>
				<div class="create-footer">
					<el-button style="float: right" type="info" size="mini" @click="$emit('canel')">取消创建</el-button>
					<el-button style="float: right" type="primary" size="mini" @click="createRoom('form')">创建房间</el-button>
				</div>
			</el-form>
		</div>
	</div>
</template>
<script>
import { mapGetters, mapMutations } from "vuex";
import { createRoom } from "@/api/chat";
import config from '@/config'

export default {
  name: "RoomInfo",
  props: {
    createRoomVisible: {
      type: Boolean,
      default: () => false,
    },
  },
  data() {
    return {
      uploadUrl: config.fileUploadUrl,
      showJoinModal: false,
      showPasswordModal: false,
      activeRoomId: null,
      preImage: null,
      form: {
        password: null,
      },
      ruleform: {
        roomId: null,
        roomName: null,
        roomNotice: null,
        roomNeedPassword: null,
        roomLogo: null,
      },
      rules: {
        roomId: [
          { required: true, message: "请设置您的房间ID", trigger: "blur" },
          { min: 3, max: 5, message: "长度在 3 到 5 个字符", trigger: "blur" },
        ],
        roomName: [
          { required: true, message: "请设置您的房间名称", trigger: "blur" },
          { min: 4, max: 8, message: "长度在 4 到 8 个字符", trigger: "blur" },
        ],
        roomNotice: [
          { required: true, message: "请设置您的房间公告", trigger: "blur" },
          { max: 520, message: "长度最长520字符", trigger: "blur" },
        ],
        roomNeedPassword: [
          {
            required: true,
            message: "请设置房间是否需要密码",
            trigger: "change",
          },
        ],
        roomPassword: [
          { required: true, message: "请设置房间密码", trigger: "change" },
          { min: 3, max: 9, message: "长度在 3 到 9 个字符", trigger: "blur" },
        ],
      },
    };
  },
  computed: {
    ...mapGetters(["roomList", "roomId", "mineRoomInfo"]),
  },
  methods: {
    ...mapMutations(["setRoomId"]),
    handlerJoinRoom(room) {
      const { roomId, roomNeedPassword } = room;
      if (Number(roomId) === Number(this.roomId)) {
        return this.$message.warning("已经在当前房间了");
      }
      if (roomNeedPassword === 2) {
        return this.$message.warning("当前房间已加密，禁止加入房间！");
        // TODO 密码房间输入密码进入
        // this.showJoinModal = false
        // this.showPasswordModal = true
      }
      this.activeRoomId = Number(roomId);
      this.showJoinModal = true;
    },

    /* 确定加入其他房间 */
    handlerConfirm() {
      this.setRoomId(Number(this.activeRoomId));
      this.$emit("close");
    },

    /* 加入密码房间 */
    handlerJoinPasswordRoom() {},

    /* 没有房间的时候运行创建一个房间 */
    async createRoom(formName) {
      this.$refs[formName].validate(async (valid) => {
        if (!valid) return;
        const { success } = await createRoom(this.ruleform);
        success && this.$emit("create-success");
      });
    },

    handleAvatarSuccess(res, file) {
      this.ruleform.roomLogo = res.data[0].url;
      this.preImage = URL.createObjectURL(file.raw);
    },
    beforeAvatarUpload(file) {
      const isLt2M = file.size / 1024 / 1024 < 1;
      if (!isLt2M) {
        this.$message.error("上传头像图片大小不能超过 1MB!");
      }
      return isLt2M;
    },
  },
};
</script>
<style lang="less" scoped>
.online {
  display: flex;
  flex-direction: column;
  height: 440px;
  overflow: hidden;
  overflow-y: auto;
  &-item {
    cursor: pointer;
    padding: 10px;
    display: flex;
    align-items: center;
    transition: all 0.3s;
    border-left: 3px solid transparent;
    padding-left: 8px;
    position: relative;
    .mine-room {
      position: absolute;
      top: 5px;
      left: 0;
    }
    &:hover {
      border-left: 3px solid #1295dd;
    }
    &-avatar {
      width: 40px;
      height: 40px;
      border-radius: 5px;
      margin-right: 10px;
    }
    &-info {
      display: flex;
      flex-direction: column;
      flex: 1;
      width: 0;
      &-name {
        font-size: 14px;
        color: @message-main-text-color;
        font-weight: 500;
        display: flex;
        justify-content: space-between;
        align-items: center;
        .role {
          background-color: #ccc;
          font-size: 12px;
          color: #fff;
          padding: 1px 10px;
          margin-right: 3px;
          border-radius: 3px;
        }
        .hall {
          background: #000;
          color: #fff;
        }
        .room-num {
          margin-right: 5px;
          color: red;
        }
      }
      &-desc {
        font-size: 12px;
        margin-top: 8px;
        color: rgb(144, 140, 140);
      }
    }
  }

  .official {
    border-bottom: 3px solid @message-border-color;
    border-top: 1px solid @message-border-color;
    margin-bottom: 15px;
  }
  .current {
    border-right: 3px solid #521cd373;
    // background: #d8cbf5;

    .online-item-info-desc {
      // color: #fff !important;
    }
  }

  .create {
    transition: all 0.3s;
    padding: 10px 20px;
    .create-footer {
      display: flex;
      margin-left: 80px;
    }
  }

  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 100px;
    height: 100px;
    line-height: 100px;
    text-align: center;
    border-radius: 6px;
    border: 1px dashed #ccc !important;
  }
  .avatar {
    width: 100px;
    height: 100px;
    border-radius: 6px;
    display: block;
    border: 1px solid #409eff;
  }
}
</style>
