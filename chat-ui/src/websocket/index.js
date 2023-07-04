const MySocket = {
	url: "",
	websocket: null,
	websocketState: false,
	reconnectNum: 0,
	lockReconnect: false,
	timeout: null,
	clientTimeout: null,
	serverTimeout: null,
	initWebSocket(newUrl) {
		MySocket.url = newUrl;
		MySocket.websocket = new WebSocket(MySocket.url);
		MySocket.websocket.onopen = MySocket.websocketOnOpen;
		MySocket.websocket.onerror = MySocket.websocketOnError;
		MySocket.websocket.onclose = MySocket.websocketOnClose;
		this.resetHeartbeat()
	},
	reconnect() {
		if (MySocket.lockReconnect) return;
		MySocket.reconnectNum += 1;
		if (MySocket.reconnectNum === 3) {
			MySocket.reconnectNum = 0;
			MySocket.websocket.onclose()
			return;
		}
		MySocket.lockReconnect = true;
		MySocket.timeout = setTimeout(() => {
			MySocket.initWebSocket(MySocket.url);
			MySocket.lockReconnect = false;
		}, 5000);
	},
	resetHeartbeat() {
		MySocket.heartbeat();
	},
	heartbeat() {
		MySocket.clientTimeout = setTimeout(() => {
			if (MySocket.websocket) {
				MySocket.websocket.send(JSON.stringify({ messageType: "heartcheck" ,data:"心跳响应"}));
				MySocket.websocketState = false;
				console.log(MySocket.websocketState,"??????1???????")
				MySocket.serverTimeout = setTimeout(() => {
					console.log(MySocket.websocketState,"??????3???????")
					if (!MySocket.websocketState) {
						MySocket.websocket.onclose()
					} else {
						this.resetHeartbeat()
					}
				}, 60 * 1000);
			}
		}, 3 * 1000);
	},
	sendMsg(message) {
		MySocket.websocket.send(message);
	},
	websocketOnOpen(event) {
		MySocket.sendMsg(JSON.stringify({ messageType: "heartcheck" ,data:"心跳响应"}));
	},
	websocketOnError(error) {
		console.log(error);
		MySocket.reconnect();
	},
	websocketOnClose() {
		MySocket.websocket.close();
	},
};
export default MySocket
