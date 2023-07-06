import jwtDecode from "jwt-decode";

const TokenKey = 'chatToken';

export function getToken() {
    return localStorage.getItem(TokenKey);
}

export function setToken(token) {
    return localStorage.setItem(TokenKey, token);
}

export function removeToken() {
    localStorage.clear();
}


export function getUserId() {
    return localStorage.getItem("userId")
}

export function getRoomId() {
    return localStorage.getItem("roomId")
}

export function setUser(userId, userName, userPassword) {
    localStorage.userId = userId;
    localStorage.userName = userName;
    localStorage.userPassword = userPassword;
}

export function getUserByToken(token) {
    return jwtDecode(token).userId
}