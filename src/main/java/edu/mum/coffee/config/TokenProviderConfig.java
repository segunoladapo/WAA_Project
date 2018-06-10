package edu.mum.coffee.config;


import edu.mum.coffee.util.Utility;
import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.config.CacheConfiguration;
import net.sf.ehcache.store.MemoryStoreEvictionPolicy;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import static edu.mum.coffee.util.Utility.*;
@Configuration
public class TokenProviderConfig {

    @Bean
    public CacheManager cacheManager(){
        CacheManager manager = CacheManager.create();
        Cache cache = new Cache(
                new CacheConfiguration(TOKEN_CACHE, 80000)
                        .memoryStoreEvictionPolicy(MemoryStoreEvictionPolicy.LFU)
                        .eternal(false)
                        .timeToIdleSeconds(30));
        Cache unExpiredCache = new Cache(
                new CacheConfiguration(UNEXPIREDCACHE, 80000)
                        .memoryStoreEvictionPolicy(MemoryStoreEvictionPolicy.LFU)
                        .eternal(true));
        manager.addCache(cache);
        manager.addCache(unExpiredCache);
        return manager;
    }
}
