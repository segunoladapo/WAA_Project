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

    public boolean contains(String key, String cacheName){
        Cache cache = cacheManager.getCache(cacheName);
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

    public Object retrieve(String token, String cacheName){
        return cacheManager.getCache(cacheName).get(token).getObjectValue();
    }


    public void saveObject(String key, Object obj, String cachName){
        Cache cache = cacheManager.getCache(cachName);
        Element element = new Element(key, obj);
        cache.put(element);
    }

    public void clearObject(String key, String cacheName){
        Cache cache = cacheManager.getCache(cacheName);
        cache.remove(key);
    }
}
