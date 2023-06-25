package com.wangscaler.chatcore.util;
import cn.hutool.core.util.ObjectUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * 以静态变量保存Spring ApplicationContext, 可在任何代码任何地方任何时候中取出ApplicaitonContext.
 *
 * @author wangscaler
 */
@Slf4j
public class SpringContextUtils implements ApplicationContextAware {
	private static ApplicationContext applicationContext;

	/**
	 * 实现ApplicationContextAware接口的context注入函数, 将其存入静态变量.
	 */
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) {
		// NOSONAR
		SpringContextUtils.applicationContext = applicationContext;
	}

	/**
	 * 从静态变量ApplicationContext中取得Bean, 自动转型为所赋值对象的类型.
	 */
	public static <T> T getHandler(String name, Class<T> cls) {
		T t = null;
		if (ObjectUtil.isNotEmpty(name)) {
			checkApplicationContext();
			try {
				t = applicationContext.getBean(name, cls);
			} catch (Exception e) {
				log.warn("Customize redis listener handle [ " + name + " ], does not exist！");
			}
		}
		return t;
	}

	private static void checkApplicationContext() {
		if (applicationContext == null) {
			throw new IllegalStateException("applicaitonContext未注入,请在applicationContext.xml中定义SpringContextHolder");
		}
	}

}