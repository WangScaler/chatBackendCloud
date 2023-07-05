<template>
    <div class="chat" :style="{ backgroundImage: `url(${roomBg})` }">
        <!--		 主要面板-->
        <transition name="message-panel" mode="out-in">
            <div v-if="showChatPanle" class="chat-container">
                <div class="chat-container-header">
                    <chat-header ref="header"/>
                </div>
                <div class="chat-container-content">
                    <message-panel :stop-loadmore="stopLoadmore" @loadHistoryMessage="handlerLoadHistoryMessage"
                                   @quoteMessage="handlerQuoteMessage"/>
                    <transition name="msg-tips" mode="out-in">
                        <div v-if="unReadMsgNum" class="un-read" @click="handleToBotton">有{{ unReadMsgNum }}条新消息</div>
                    </transition>
                </div>
                <div class="chat-container-progress">
                    <chat-progress/>
                </div>
                <div class="chat-container-footer">
                    <chat-message-frame ref="messageFrame"/>
                    <chat-lrc/>
                </div>
                <pre-img :data="preImg"/>
            </div>
        </transition>

        <!--		 弹幕-->
<!--        <Barrage v-if="!lock" :new-msg="newMsg" class="chat-barrage-wapper"/>-->

        <!--		 弹幕聊天场景-->
        <transition name="message-panel" mode="out-in">
            <div v-if="!showChatPanle && !lock" class="chat-barrage">
                <div class="chat-container-progress">
                    <chat-progress/>
                </div>
                <div class="chat-container-footer">
                    <chat-message-frame ref="messageFrame"/>
                    <chat-lrc/>
                </div>
                <pre-img :data="preImg"/>
            </div>
        </transition>

        <!--		 esc隐藏面板的歌词-->
        <!--		 <bullet-chat v-show="!showChatPanle" class="chat-bullet" />-->
        <music-player ref="minePlayer"/>
    </div>
</template>

<script>
    import Vue from "vue";
    import {mapActions, mapGetters, mapMutations, mapState} from "vuex";
    import ChatHeader from "@/components/Chat/ChatHeader";
    import ChatMessageFrame from "@/components/Chat/ChatMessageFrame";
    import ChatLrc from "@/components/Chat/ChatLrc";
    import MessagePanel from "@/components/Chat/MessagePanel";
    import MusicPlayer from "@/components/Chat/MusicPlayer";
    import ChatProgress from "@/components/Chat/ChatProgress";
    import PreImg from "@/components/PreImg";
    // import Barrage from '@/components/Barrage'
    import {setTheme} from "@/theme";
    import {history} from "@/api/chat";
    import config from "@/config/index";
    import {getToken} from '@/utils/auth';
    import MySocket from '@/websocket/index'

    const {defaultRoomBg} = config;
    const url = process.env.VUE_APP_WS_API;
    export default {
        components: {
            ChatHeader,
            ChatMessageFrame,
            ChatLrc,
            MessagePanel,
            MusicPlayer,
            ChatProgress,
            PreImg,
            // Barrage
        },
        data() {
            return {
                showPopup: true,
                websocketCount: -1,
                lock: true, // 用户确认进入房间后才能解锁 之后允许使用快捷键
                showChatPanle: false, // 是否现在聊天窗口
                stopLoadmore: false, // 是否加载完了历史消息
                messageParams: {
                    page: 1,
                    pagesize: 20,
                },
                count: 1,
                newMsg: ''
            };
        },
        computed: {
            ...mapState([
                "roomId",
                "unReadMsgNum",
                "preImg",
                "showTipsJoinRoom",
                "showTipsQuitRoom",
                "showTipsSwitchMusic",
                "theme",
                "showTipsPlayMusic",
                "showTipsNotice"
            ]),
            ...mapGetters(["roomInfo", "mineRoomBg"]),
            roomBg() {
                return (
                    this.mineRoomBg || this.roomInfo?.roomBgImg || defaultRoomBg
                );
            },
        },
        watch: {
            roomId(n, o) {
                if (Number(n) === Number(o) || !n) return;
                MySocket.websocketOnClose()
                this.resetRoom();
                this.initSocket();
            },
        },
        /**
         *校验开始
         * */
        created() {
            this.initLocalStorageConfig();
            localStorage.roomId && this.setRoomId(localStorage.roomId);
            this.$confirm('请注意、加入聊天室将自动播放音乐!', '欢迎加入聊天室', {
                confirmButtonText: '加入房间',
                cancelButtonText: '取消',
            }).then(() => this.passJoin()).catch(() => this.logout())
        },
        mounted() {
            this.initUserAddress();
            document.addEventListener("keyup", this.keyboardEvent);
        },

        beforeDestroy() {
            this.showPopup=false
            MySocket.websocketOnClose()
            document.removeEventListener("keyup", this.keyboardEvent, true);
        },
        /**
         *已完成校验
         * */
        methods: {
            ...mapActions([
                "toggleSignInPopup",
                "getUserInfo",
                "logout",
                "getRoomInfo",
            ]),
            ...mapMutations([
                "setOnlineUserList",
                "setRoomList",
                "setRoomAdminInfo",
                "setMessageDataList",
                "setCurrentMusicInfo",
                "setCurrentMusicStartTime",
                "setQueueMusicList",
                "emptyMessageDataList",
                "setRoomId",
                "updateMessageList",
                "setUnReadMsgNum",
                "setRoomInfo",
                "setGlobalRoomConfig",
            ]),
            /* 初始化全部配置，拿到本地缓存的历史配置,并设置主题 */
            initLocalStorageConfig() {
                const storageKeys = [
                    "showTipsJoinRoom",
                    "showTipsQuitRoom",
                    "showTipsSwitchMusic",
                    "theme",
                    "showAllTips",
                    "showTipsNotice",
                    "showHistoryBarrageInfo",
                    "showBarrageImg",
                    "showBarrageAvatar"
                ];
                storageKeys.forEach(
                    (key) =>
                        localStorage[key] &&
                        this.setGlobalRoomConfig({
                            key,
                            value: key === "theme" ? localStorage[key] : JSON.parse(localStorage[key])
                        })
                );
                const theme = localStorage.theme || "default";
                setTheme(theme);
            },
            /* 确认加入房间 */
            passJoin() {
                this.showPopup = false;
                this.lock = false;
                this.showChatPanle = true;
                this.initSocket();
            },
            /* random address */
            getRandomAddr() {
                const i = Math.round(Math.random() * 5);
                const randomAddrs = ['金星', '木星', '水星', '火星', '土星', '月球']
                return randomAddrs[i]
            },
            /* 调用一个开发API拿到用户位置的js */
            initUserAddress() {
                if (!document.querySelector("#address")) {
                    const script = document.createElement("script");
                    script.type = "text/javascript";
                    script.id = "address";
                    script.src = "https://pv.sohu.com/cityjson?ie=utf-8";
                    document.head.appendChild(script);
                }
            },
            /* 初始化ws需要参数携带token roomId 地址 前去校验 连接后挂载在全局 */
            async initSocket() {
                const token = getToken()
                if (!window.returnCitySN && this.count <= 3) {

                    this.count++
                    setTimeout(() => this.initSocket(), 50);
                } else {
                    const cname = window.returnCitySN ? window.returnCitySN.cname : this.getRandomAddr();
                    MySocket.initWebSocket(url.replace("TOKEN", token).replace("ADDRESS", cname));
                    MySocket.websocket.onmessage = this.websocketOnMessage;
                    localStorage.roomId = this.roomId;
                    this.initLocalStorageConfig();
                    if(MySocket.websocketState){
                        this.getHistoryMessage()
                    }

                }
            },
            websocketOnMessage(event) {
                this.websocketCount += 1;
                let info = JSON.parse(event.data);
                switch (info.messageType) {
                    case "heartcheck":
                        MySocket.websocketState = true;
                        break;
                    case "topic":
                        this.loading = true;
                        this.$nextTick(() => {
                            this.showTipsJoinRoom &&
                            this.setMessageDataList({ messageType: "info", messageContent: info.data.data });
                            this.setOnlineUserList(info.data.onLineUserList)
                        })
                        break;
                    case "error":
                        this.$message.error(info.data.toString());
                        this.logout()
                        this.loading = false;
                        break;
                }
            },
            resetRoom() {
                this.emptyMessageDataList();
                this.messageParams.page = 1;
            },
            /* 获取历史消息 */
            async getHistoryMessage() {
                const res = await history({
                    roomId: this.roomId,
                    ...this.messageParams,
                });
                this.stopLoadmore = res.data.length < this.messageParams.pagesize;
                this.stopLoadmore &&
                this.messageParams.page > 1 &&
                this.$message.warning("已加载完全部历史消息了！");
                this.setMessageDataList(res.data);
            },

            /* 上拉获取更多消息 */
            handlerLoadHistoryMessage() {
                this.messageParams.page += 1;
                this.getHistoryMessage();
            },

            /* 引用消息 */
            handlerQuoteMessage(message) {
                this.$refs.messageFrame.setQuoteMessage(message);
            },
            /* 关闭弹窗 */
            closePopup() {
                this.showPopup = false;
            },
            /* 聊天窗口滚到底部 */
            handleToBotton() {
                this.$scorllToBottom({animation: true});
                this.setUnReadMsgNum(0);
            },
            keyboardEvent({keyCode}) {
                if (this.lock) return;
                if (keyCode === 117) {
                    // f6
                }
                if (keyCode === 192) {
                    // ~
                }
                if (keyCode === 27) {
                    // esc
                    this.showChatPanle = !this.showChatPanle;
                    this.showChatPanle && this.$nextTick(() => this.$scorllToBottom());
                }
                if (keyCode === 112) {
                    // f1
                    this.$refs.messageFrame.openBox(1);
                }
                if (keyCode === 113) {
                    // f2
                    this.$refs.messageFrame.openBox(2);
                }
                if (keyCode === 114) {
                    // f3
                    this.$refs.messageFrame.openBox(3);
                }
                if (keyCode === 115) {
                    // f4
                    this.$refs.messageFrame.openBox(4);
                }
                if (keyCode === 116) {
                    // f5
                }
                if (keyCode === 118) {
                    // f7
                }
                if (keyCode === 119) {
                    // f8
                    this.$refs.header.openBox(1);
                }
                if (keyCode === 120) {
                    // f9
                    this.$refs.header.openBox(2);
                }
                if (keyCode === 121) {
                    // f10
                    this.$refs.header.openBox(3);
                }
                return false;
            },
            hanlderCloseDialog() {
                this.logout()
            },
        }
    };
</script>

<style lang="less" scoped>
    @media screen and (max-width: 720px) {
        .chat-container {
            position: fixed;
            width: 100vw !important;
            height: 100vh !important;
            left: 0 !important;
            right: 0 !important;
            bottom: 0 !important;
            top: 0 !important;
            border-radius: 0 !important;
        }
    }

    .chat {
        width: 100vw;
        height: 100vh;
        background: url("https://public-1300678944.cos.ap-shanghai.myqcloud.com/blog/1636699165011bg.jpeg");
        background-size: cover;

        &-container {
            position: fixed;
            left: 8%;
            right: 8%;
            top: 5%;
            bottom: 5%;
            transition: all 0.5s;
            background: @message-panel-bg-color;
            box-shadow: @message-panel-box-shadow;
            border-radius: 10px;
            display: flex;
            flex-direction: column;
            z-index: 1;

            &-header {
                width: 100%;
                height: 50px;
                border-bottom: 1px solid @message-border-color;
            }

            &-content {
                flex: 1;
                height: 0;
                position: relative;

                .un-read {
                    transition: all 0.3s;
                    position: absolute;
                    right: 15px;
                    bottom: 10px;
                    padding: 7px 13px;
                    font-size: 12px;
                    background: #f56c6c;
                    color: #fff;
                    border-radius: 6px;
                    font-weight: 600;
                    cursor: pointer;
                }
            }

            &-progress {
                height: 2px;
                margin-bottom: 5px;
            }

            &-footer {
                padding: 0;
            }
        }

        &-barrage {
            position: fixed;
            bottom: 0%;
            left: 0%;
            right: 0%;
            z-index: 10;
            background: @message-panel-bg-color;
            box-shadow: @message-panel-box-shadow;
            border-radius: 10px;
        }

        &-bullet {
            position: fixed;
            bottom: 2%;
            z-index: 1;
        }

        &-barrage-wapper {
            position: fixed;
            top: 0;
            width: 100%;
        }
    }
</style>
