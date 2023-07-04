<template>
	<div v-if="musicInfo" class="progress">
		<div class="bar" :style="{ width: `${width}%` }"></div>
		<div class="current-music">
			<icon name="progress-music" class="icon" scale="1.8" />
			<span class="music-album">
				{{ musicInfo.music_album }} -
				{{ musicInfo.music_singer }}
			</span>
			<icon name="progress-collect" class="icon" scale="2.2" @click.native="collectMusic" />
			<icon name="progress-switch" class="icon" scale="2.2" @click.native="$socket.client.emit('cutMusic', musicInfo)" />
		</div>
	</div>
</template>

<script>
import { mapState } from "vuex";
import { collectMusic } from "@/api/music";

export default {
  computed: {
    ...mapState(["currentMusicTime", "musicInfo"]),
    width() {
      if (!this.currentMusicTime || !this.musicInfo) return 0;
      const { music_duration } = this.musicInfo;
      const width = (
        (Number(this.currentMusicTime) / Number(music_duration)) *
        100
      ).toFixed(2);
      return width > 100 ? 100 : width;
    },
  },
  methods: {
    async collectMusic() {
      await collectMusic(this.musicInfo);
      this.$message.success("歌曲收藏成功！");
    },
  },
};
</script>
<style lang="less" scoped>
@media screen and (max-width: 820px) {
  .current-music {
    top: -20px !important;
  }
}
.progress {
  height: 2px;
  width: 100%;
  background: @message-border-color;
  position: relative;
  .bar {
    height: 2px;
    background: linear-gradient(270deg, #4493d7, #fff);
  }
  .current-music {
    position: absolute;
    right: 0;
    height: 5px;
    top: 20px;
    display: flex;
    align-items: center;
    color: #999;
    user-select: none;
    z-index: 3;
    .music-album {
      text-overflow: ellipsis;
      overflow: hidden;
      white-space: nowrap;
      max-width: 300px;
    }
    .icon {
      transition: all 0.3s;
      margin-right: 5px;
      cursor: pointer;
      &:nth-child(2) {
        margin-left: 5px;
        &:hover {
          color: #409eff;
        }
      }
      &:nth-child(3) {
        &:hover {
          color: #ff4500;
        }
      }
      &:active {
        transform: scale(1.2);
      }
    }
  }
}
</style>
