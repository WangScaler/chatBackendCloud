import request from '@/utils/request';

export const history = data => request('post', '/message/history', data);

export const createRoom = data => request('post', '/message/createRoom', data);

export const queryRoomInfo = data => request('get', '/message/roomInfo', data);

export const updateRoomInfo = data => request('post', '/message/updateRoomInfo', data);
