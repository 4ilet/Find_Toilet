package com.Fourilet.project.fourilet.config;

import com.Fourilet.project.fourilet.data.repository.MemberRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.Fourilet.project.fourilet.config.jwt.filter.JwtAuthenticationProcessingFilter;
import com.Fourilet.project.fourilet.config.jwt.service.JwtService;
//import com.Fourilet.project.fourilet.config.oauth2.handler.OAuth2LoginFailureHandler;
//import com.Fourilet.project.fourilet.config.oauth2.handler.OAuth2LoginSuccessHandler;
//import com.Fourilet.project.fourilet.config.oauth2.service.CustomOAuth2UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.logout.LogoutFilter;

/**
 * 인증은 CustomJsonUsernamePasswordAuthenticationFilter에서 authenticate()로 인증된 사용자로 처리
 * JwtAuthenticationProcessingFilter는 AccessToken, RefreshToken 재발급
 */
@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final JwtService jwtService;
    private final MemberRepository memberRepository;
    private final ObjectMapper objectMapper;

    private static final String[] PERMIT_URL_ARRAY = {
            /* swagger v2 */
            "/v2/api-docs",
            "/swagger-resources",
            "/swagger-resources/**",
            "/configuration/ui",
            "/configuration/security",
            "/swagger-ui.html",
            "/webjars/**",
            /* swagger v3 */
            "/v3/api-docs/**",
            "/swagger-ui/**",
            "/user/login",
            "/toilet/**",
            "/oauth2/**",
            "/review/{toiletId}"
    };

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .formLogin().disable() // FormLogin 사용 X
                .httpBasic().disable() // httpBasic 사용 X
                .csrf().disable() // csrf 보안 사용 X
                .headers().frameOptions().disable()
                .and()

                // 세션 사용하지 않으므로 STATELESS로 설정
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)

                .and()

                //== URL별 권한 관리 옵션 ==//
                .authorizeRequests()

                // 아이콘, css, js 관련
                // 기본 페이지, css, image, js 하위 폴더에 있는 자료들은 모두 접근 가능, h2-console에 접근 가능
                .antMatchers(PERMIT_URL_ARRAY).permitAll()
//                .antMatchers("/sign-up").permitAll() // 회원가입 접근 가능
                .anyRequest().authenticated() // 위의 경로 이외에는 모두 인증된 사용자만 접근 가능
                .and()
                .exceptionHandling()
                .authenticationEntryPoint(new CustomAuthenticationEntryPoint());


        // 원래 스프링 시큐리티 필터 순서가 LogoutFilter 이후에 로그인 필터 동작
        // 따라서, LogoutFilter 이후에 우리가 만든 필터 동작하도록 설정
        // 순서 : LogoutFilter -> JwtAuthenticationProcessingFilter -> CustomJsonUsernamePasswordAuthenticationFilter
        http.addFilterAfter(jwtAuthenticationProcessingFilter(), LogoutFilter.class);

        return http.build();
    }

//    @Bean
//    public PasswordEncoder passwordEncoder() {
//        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
//    }
//
//    /**
//     * AuthenticationManager 설정 후 등록
//     * PasswordEncoder를 사용하는 AuthenticationProvider 지정 (PasswordEncoder는 위에서 등록한 PasswordEncoder 사용)
//     * FormLogin(기존 스프링 시큐리티 로그인)과 동일하게 DaoAuthenticationProvider 사용
//     * UserDetailsService는 커스텀 LoginService로 등록
//     * 또한, FormLogin과 동일하게 AuthenticationManager로는 구현체인 ProviderManager 사용(return ProviderManager)
//     *
//     */
//    @Bean
//    public AuthenticationManager authenticationManager() {
//        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
//        provider.setPasswordEncoder(passwordEncoder());
//        provider.setUserDetailsService(loginService);
//        return new ProviderManager(provider);
//    }
//
//    /**
//     * 로그인 성공 시 호출되는 LoginSuccessJWTProviderHandler 빈 등록
//     */
//    @Bean
//    public LoginSuccessHandler loginSuccessHandler() {
//        return new LoginSuccessHandler(jwtService, userRepository);
//    }
//
//    /**
//     * 로그인 실패 시 호출되는 LoginFailureHandler 빈 등록
//     */
//    @Bean
//    public LoginFailureHandler loginFailureHandler() {
//        return new LoginFailureHandler();
//    }
//
//    /**
//     * CustomJsonUsernamePasswordAuthenticationFilter 빈 등록
//     * 커스텀 필터를 사용하기 위해 만든 커스텀 필터를 Bean으로 등록
//     * setAuthenticationManager(authenticationManager())로 위에서 등록한 AuthenticationManager(ProviderManager) 설정
//     * 로그인 성공 시 호출할 handler, 실패 시 호출할 handler로 위에서 등록한 handler 설정
//     */
//    @Bean
//    public CustomJsonUsernamePasswordAuthenticationFilter customJsonUsernamePasswordAuthenticationFilter() {
//        CustomJsonUsernamePasswordAuthenticationFilter customJsonUsernamePasswordLoginFilter
//                = new CustomJsonUsernamePasswordAuthenticationFilter(objectMapper);
//        customJsonUsernamePasswordLoginFilter.setAuthenticationManager(authenticationManager());
//        customJsonUsernamePasswordLoginFilter.setAuthenticationSuccessHandler(loginSuccessHandler());
//        customJsonUsernamePasswordLoginFilter.setAuthenticationFailureHandler(loginFailureHandler());
//        return customJsonUsernamePasswordLoginFilter;
//    }

    @Bean
    public JwtAuthenticationProcessingFilter jwtAuthenticationProcessingFilter() {
        JwtAuthenticationProcessingFilter jwtAuthenticationFilter = new JwtAuthenticationProcessingFilter(jwtService, memberRepository);
        return jwtAuthenticationFilter;
    }
}