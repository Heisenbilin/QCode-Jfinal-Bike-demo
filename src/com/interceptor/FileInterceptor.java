package com.interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;

public class FileInterceptor implements Interceptor {

	@Override
	public void intercept(Invocation inv) {
		 Controller controller = inv.getController();
	     controller.getFile();
	     inv.invoke();
		
	}
}
