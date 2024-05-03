package com.ezen.www.config;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration.Dynamic;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] {RootConfig.class };
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] {ServletConfiguration.class };
	}

	@Override
	protected String[] getServletMappings() {
		// TODO Auto-generated method stub
		return new String[] {"/"};
	}

	@Override
	protected Filter[] getServletFilters() {
		// TODO Auto-generated method stub
		// filter 설정
		CharacterEncodingFilter encoding = new CharacterEncodingFilter();
		encoding.setEncoding("UTF-8");
		encoding.setForceEncoding(true);	// 외부로 나가는 데이터도 인코딩 설정
		return new Filter[] {encoding};
	}


	// 사용자지정 설정(커스텀)
	@Override
	protected void customizeRegistration(Dynamic registration) {
		// TODO Auto-generated method stub
		// 그 외 기타 사용자설정 영역
		// 예) 파일업로드 / 사용자지정 Exception 등
		String uploadLocation = "D:\\_myProject\\_java\\_fileUpload";
		int maxFilesize = 1024*1024*20;
		int maxRequestSize = maxFilesize*2;
		int fileSizeThreshold = maxFilesize;
		
		MultipartConfigElement multipartConfig = new MultipartConfigElement(uploadLocation, maxFilesize, maxRequestSize, fileSizeThreshold);
		
		registration.setMultipartConfig(multipartConfig);
		
	}
	
	
	
	
	
	

	
	
}
