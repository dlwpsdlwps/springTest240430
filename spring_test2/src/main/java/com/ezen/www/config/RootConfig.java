package com.ezen.www.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;


@EnableScheduling	// 파일삭제기능 사용 시 필요
@EnableTransactionManagement
@MapperScan(basePackages = {"com.ezen.www.repository"})
@Configuration
public class RootConfig {
	
	@Autowired		// 객체 생성하여 사용할 수 있도록 설정
	ApplicationContext applicationContext;
	
	@Bean			// 메서드 하나에 사용(메서드를 객체로 설정하는 역할)
	public DataSource dataSource() {
		HikariConfig hikariConfig = new HikariConfig();
		
		//log4jdbc >>> DB의 로그를 찍을 수 있는 드라이버로 설정변경
		hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
		hikariConfig.setJdbcUrl("jdbc:log4jdbc:mysql://localhost:3306/springtest");
		hikariConfig.setUsername("springUser");
		hikariConfig.setPassword("mysql");
		
		// hikari 추가 설정 영역 /////////////////////////
		hikariConfig.setMaximumPoolSize(5);		// 커넥션 최대 개수(필수설정)
		hikariConfig.setMinimumIdle(5);			// 유휴커넥션 최소 개수(작동하지 않고 휴식하는 커넥션을 의미?)(필수설정)
		
		hikariConfig.setConnectionTestQuery("SELECT now()");		// 커넥팅 시 test 쿼리문(커넥팅 여부 체크하는 역할)(필수설정)
		hikariConfig.setPoolName("springHikariCP");					// (필수설정)
		
		// 추가설정
		// cachePrepStmts : cache 사용 여부를 결정하는 역할
		hikariConfig.addDataSourceProperty("dataSource.cachePrepStmts", "true");
		// mysql 드라이버가 connection 당 cache 사이즈 : default 250~500(권장)
		hikariConfig.addDataSourceProperty("dataSource.prepStmtsCacheSize", "250");
		// connection 당 캐싱할 preparedStatement의 개수 지정 옵션 : default 256
		hikariConfig.addDataSourceProperty("dataSource.prepStmtsCacheSqlLimit", "true");
		// mysql 서버에서 최신이슈가 있을 경우 지원을 받을 것인지 설정
		hikariConfig.addDataSourceProperty("dataSource.useServerPrepStmts", "true");
		
		// hikari에 대한 dataSource 생성
		HikariDataSource hikariDataSource = new HikariDataSource(hikariConfig);
		
		return hikariDataSource;
	}
	
	
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlFactoryBean = new SqlSessionFactoryBean();
		
		sqlFactoryBean.setDataSource(dataSource());
		sqlFactoryBean.setMapperLocations(applicationContext.getResources("classpath:/mappers/*.xml"));
		// DB : _(스네이크 표기법), JAVA : 카멜 표기법
		// file_name >>> fileName으로 받는다.
		// Alias 설정(알리아스) : 별칭 설정
//		sqlFactoryBean.setConfigLocation(applicationContext.getResources("classpath:/mybatisConfig.xml"));
		sqlFactoryBean.setConfigLocation(applicationContext.getResource("classpath:/mybatisConfig.xml"));
		
		return sqlFactoryBean.getObject();
		
	}
	
	
	// 트랜잭션 매니저 설정
	@Bean
	public DataSourceTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}
	
	
	
	
	
	
	
}
