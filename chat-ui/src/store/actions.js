import { getInfo } from '@/api/user';
import { queryRoomInfo } from '@/api/chat';
import router from '../router/index';
import { removeToken } from '@/utils/auth';

export default {
	/* 获取用户信息 */
	async getUserInfo({ commit }) {
		return new Promise(resolve => {
			getInfo().then(res => {
				commit('setUserInfo', res.data);
				resolve(true);
			});
		});
	},

	/* 获取当前房间信息 */
	async getRoomInfo({ commit, state }) {
		return new Promise(resolve => {
			queryRoomInfo({ roomId: state.roomId }).then(res => {
				commit('setRoomInfo', res.data);
				resolve(true);
			});
		});
	},

	/* 退出登录 */
	async logout({ commit }) {
		return new Promise(resolve => {
			removeToken();
			commit('setToken', null);
			commit('resetStore');
			router.push('/login');
			resolve();
		});
	}
};
