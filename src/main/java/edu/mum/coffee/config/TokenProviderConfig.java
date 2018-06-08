package edu.mum.coffee.config;


import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.config.CacheConfiguration;
import net.sf.ehcache.store.MemoryStoreEvictionPolicy;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TokenProviderConfig {

    @Bean
    public CacheManager cacheManager(){
        CacheManager manager = CacheManager.create();
        Cache cache = new Cache(
                new CacheConfiguration("tokenCache", 80000)
                        .memoryStoreEvictionPolicy(MemoryStoreEvictionPolicy.LFU)
                        .eternal(false)
                        .timeToIdleSeconds(900));
        manager.addCache(cache);
        return manager;
    }
}
