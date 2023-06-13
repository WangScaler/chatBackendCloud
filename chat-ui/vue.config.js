const path = require('path');

function resolve(dir) {
	return path.join(__dirname, dir);
}
const port = 8081;

module.exports = {
	publicPath: '/',
	pluginOptions: {
		'style-resources-loader': {
			preProcessor: 'less',
			patterns: [path.resolve(__dirname, './src/theme/global.less')]
		}
	},
	outputDir: 'dist',
	assetsDir: 'static',
	lintOnSave: process.env.NODE_ENV === 'development',
	productionSourceMap: false,
	devServer: {
		port: port,
		open: true,
		overlay: {
			warnings: false,
			errors: true
		},
		proxy: { // 配置跨域
			'/chat': {
				target: `http://localhost:8080`, //请求后台接口
				changeOrigin: true, // 允许跨域
				pathRewrite: {
					'^/chat': "" // 重写请求
				}
			}
		}
	},
	configureWebpack: {
		resolve: {
			alias: {
				'@': resolve('src')
			}
		}
	},

	chainWebpack(config) {
		config.module.rule('svg').exclude.add(resolve('src/icons')).end();
		config.module
			.rule('icons')
			.test(/\.svg$/)
			.include.add(resolve('src/icons'))
			.end()
			.use('svg-sprite-loader')
			.loader('svg-sprite-loader')
			.options({
				symbolId: 'icon-[name]'
			})
			.end();
	}
};
