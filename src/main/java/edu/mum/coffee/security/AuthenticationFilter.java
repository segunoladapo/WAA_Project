package edu.mum.coffee.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Optional;
import edu.mum.coffee.domain.Response;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class AuthenticationFilter extends GenericFilterBean {

    private final static Logger logger = LoggerFactory.getLogger(AuthenticationFilter.class);
    public static final String TOKEN_SESSION_KEY = "token";
    public static final String USER_SESSION_KEY = "user";

    private AuthenticationManager authenticationManager;

    public AuthenticationFilter(AuthenticationManager authenticationManager) {
        this.authenticationManager = authenticationManager;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = asHttp(request);
        HttpServletResponse httpResponse = asHttp(response);

        logger.debug("Trying to authenticate user by X-Auth-Token method. Token");
        Optional<String> token = Optional.fromNullable(httpRequest.getParameter("X-Auth-Token"));

        try {
            try {
                if (token.isPresent()) {
                    logger.info("Trying to authenticate user by X-Auth-Token method. Token: {}", token);
                    processTokenAuthentication(token);
                }
            } catch (Exception ex) {
                logger.debug("Exception occurred while processing provided token from Client");
                logger.debug(ex.getMessage());
            }
            logger.debug("AuthenticationFilter is passing request down the filter chain");
            chain.doFilter(request, response);
        } catch (AuthenticationException authenticationException) {
            SecurityContextHolder.clearContext();
            Response rsp = new Response("1008", authenticationException.getMessage());
            String tokenJsonResponse = new ObjectMapper().writeValueAsString(rsp);
            httpResponse.addHeader("Content-Type", "application/json");
            httpResponse.getWriter().print(tokenJsonResponse);
            httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            //httpResponse.sendError(HttpServletResponse.SC_UNAUTHORIZED, authenticationException.getMessage());
        } finally {
            MDC.remove(TOKEN_SESSION_KEY);
            MDC.remove(USER_SESSION_KEY);
        }
    }

    private HttpServletRequest asHttp(ServletRequest request) {
        return (HttpServletRequest) request;
    }

    private HttpServletResponse asHttp(ServletResponse response) {
        return (HttpServletResponse) response;
    }

    private void processTokenAuthentication(Optional<String> token) throws Exception {
        PreAuthenticatedAuthenticationToken requestAuthentication = new PreAuthenticatedAuthenticationToken(token, null);
        Authentication resultOfAuthentication = tryToAuthenticate(requestAuthentication);
        SecurityContextHolder.getContext().setAuthentication(resultOfAuthentication);
    }

    private Authentication tryToAuthenticate(Authentication requestAuthentication) throws Exception {
        Authentication responseAuthentication = authenticationManager.authenticate(requestAuthentication);
        if (responseAuthentication == null || !responseAuthentication.isAuthenticated()) {
            throw new Exception("Unable to authenticate User for provided credentials");
        }
        logger.debug("User successfully authenticated");
        return responseAuthentication;
    }
}

