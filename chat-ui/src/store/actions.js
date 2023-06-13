import { getInfo } from '@/api/user';
import { queryRoomInfo } from '@/api/chat';
import router from '../router/index';

export default {
	/* 获取用户信息 */
	async getUserInfo({ commit }) {
		return new Promise(resolve => {
			getInfo().then(res => {
				const { user_info } = res.data;
				commit('setUserInfo', user_info);
				resolve(true);
			});
		});
	},

	/* 获取当前房间信息 */
	async getRoomInfo({ commit, state }) {
		return new Promise(resolve => {
			queryRoomInfo({ room_id: state.room_id }).then(res => {
				commit('setRoomInfo', res.data);
				resolve(true);
			});
		});
	},

	/* 退出登录 */
	async logout({ commit }) {
		return new Promise(resolve => {
			localStorage.removeItem('chat_token');
			commit('setToken', null);
			commit('resetStore');
			router.push('/login');
			resolve();
		});
	}
};
