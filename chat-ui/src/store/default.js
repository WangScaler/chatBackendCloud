export default function getDefaultValue() {
	return {
		token: null,
		userInfo: null,
		roomList: [],
		roomId: 888,
		onLineUserList: [],
		messageList: [],
		musicInfo: null,
		musicLrc: null,
		musicSrc: null,
		musicStartTime: null,
		currentMusicTime: null,
		musicQueueList: [],
		roomAdminInfo: {},
		unReadMsgNum: 0, // 未读消息数
		preImg: null,
		roomInfo: null, // 此处的信息来自于初始化阶段，后续不会变更，页面使用的数据 以getters的roomInfo为准 来自ws实时更新的数据

		showAllTips: true,
		showTipsJoinRoom: true,
		showTipsQuitRoom: true,
		showTipsSwitchMusic: true,
		showTipsPlayMusic: true,
		showTipsNotice: true,
		showHistoryBarrageInfo: true,
		showBarrageImg: false,
		showBarrageAvatar: true,
		theme: 'black'
	};
}
