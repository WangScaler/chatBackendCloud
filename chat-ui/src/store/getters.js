export default {
	roomAdminInfo: state => state.roomAdminInfo,
	roomAdminId: state => state.roomAdminInfo.id,
	roomList: state => state.roomList,
	roomId: state => state.roomId,
	mineRoomBg: state => state.userInfo && state.userInfo.userRoomBg,
	mineRoomInfo: state => state.userInfo && state.userInfo.userRoomId,
	mineId: state => state.userInfo && state.userInfo.id,
	onLineUserList: state => state.onLineUserList,
	onLineUserNum: state => state.onLineUserList.length,
	onLineRoomNum: state => state.roomList.length,
	userInfo: state => state.userInfo,
	roomInfo: state => state.roomList.find(t => t.roomId === state.roomId)
};
