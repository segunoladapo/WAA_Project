package edu.mum.coffee.service;


import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class EhTokenService {

    @Autowired
    private CacheManager cacheManager;

    public boolean contains(String key){
        Cache cache = cacheManager.getCache("tokenCache");
        return cache.get(key) != null;
    }

    public String setToken(Authentication auth){
        Cache cache =  cacheManager.getCache("tokenCache");
        UUID uuid = UUID.randomUUID();
        String token = uuid.toString();
        Element element = new Element(token, auth);
        cache.put(element);
        return token;
    }

    public Object retrieve(String token){
        return cacheManager.getCache("tokenCache").get(token).getObjectValue();
    }


    public void saveObject(String key, Object obj){
        Cache cache = cacheManager.getCache("tokenCache");
        Element element = new Element(key, obj);
        cache.put(element);
    }
}
