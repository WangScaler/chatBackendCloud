import getDefaultValue from './default';

export default {
	setSignInPopup(state, isShow) {
		state.showSignInPopup = isShow;
	},

	setSignUpPopup(state, isShow) {
		state.showSignUpPopup = isShow;
	},

	setToken(state, token) {
		state.token = token;
	},

	setUserInfo(state, userInfo) {
		state.userInfo = userInfo;
	},

	/* 设置房间当前所在的房间roomId */
	setRoomId(state, roomId) {
		state.roomId = Number(roomId);
	},

	/* 房间列表信息 */
	setRoomList(state, roomList) {
		state.roomList = roomList;
	},

	/* 房间在线用户列表 */
	setOnlineUserList(state, onLineUserList) {
		state.onLineUserList = onLineUserList;
	},

	/* 房间房主信息 */
	setRoomAdminInfo(state, roomAdminInfo) {
		state.roomAdminInfo = roomAdminInfo;
	},

	/**
	 * @desc 变更消息列表
	 * @param {*} state
	 * @param {*} messageInfo [] || {} 数组表示第一次获取了历史信息或者上拉加载更多 {} 表示一条新消息， 直接存入即可
	 */
	setMessageDataList(state, messageInfo) {
		const isArray = Array.isArray(messageInfo);
		let result = [];
		isArray && (result = [...messageInfo, ...state.messageList]);
		!isArray && (result = [...state.messageList, ...[messageInfo]]);
		state.messageList = state.showAllTips ? result : result.filter(t => t.messageType !== 'info');
	},

	/* 清除所有公告信息 */
	clearTipsInfo(state) {
		state.messageList = state.messageList.filter(t => t.messageType !== 'info');
	},

	/* 清除公告信息 */
	clearNoticeInfo(state) {
		state.messageList = state.messageList.filter(t => t.messageType !== 'notice');
	},

	/* 撤回消息修改列表信息 */
	updateMessageList(state, { id, msg }) {
		const messageIndex = state.messageList.findIndex(t => t.id === id);
		messageIndex !== -1 && (state.messageList[messageIndex].messageContent = msg);
		messageIndex !== -1 && (state.messageList[messageIndex].messageType = 'info');
		state.messageList.forEach(item => {
			if (item?.quoteInfo?.quoteMessageId === id) {
				item.quoteInfo.quoteMessageStatus = -1;
			}
		});
	},

	setCurrentMusicInfo(state, currentMusicInfo) {
		const { musicInfo, musicLrc, musicSrc } = currentMusicInfo;
		state.musicInfo = musicInfo;
		state.musicLrc = musicLrc;
		state.musicSrc = musicSrc;
	},

	setCurrentMusicStartTime(state, musicStartTime) {
		state.musicStartTime = musicStartTime;
	},

	setCurrenMusicTime(state, currentMusicTime) {
		state.currentMusicTime = currentMusicTime;
	},

	setQueueMusicList(state, musicQueueList) {
		state.musicQueueList = musicQueueList;
	},

	setUnReadMsgNum(state, unReadMsgNum) {
		state.unReadMsgNum = unReadMsgNum;
	},

	emptyMessageDataList(state) {
		state.messageList = [];
	},

	resetStore(state) {
		Object.assign(state, getDefaultValue());
	},

	/* 设置预览图片 */
	setPreImg(state, preImg) {
		state.preImg = preImg;
	},

	/* 设置当前房间信息 */
	setRoomInfo(state, roomInfo) {
		state.roomInfo = roomInfo;
	},

	/* 设置全局配置信息 */
	setGlobalRoomConfig(state, { key, value }) {
		state[key] = value;
		localStorage.setItem(key, typeof value === 'boolean' ? JSON.stringify(value) : value);
	}
};
