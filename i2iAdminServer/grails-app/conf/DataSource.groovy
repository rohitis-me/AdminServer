dataSource {
	pooled = true
	driverClassName = "com.mysql.jdbc.Driver"
//	driverClassName = "org.h2.Driver"
//	username = "root"
//	password = ""
//	url = "jdbc:mysql://localhost:3306/i2idb4"
	username = "i2idbadminuser"
	password = "i2idbadminpass"
	url = "jdbc:mysql://i2idemodb.cfssgccplj1d.ap-southeast-1.rds.amazonaws.com:3306/i2idemodb"
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
//    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
    singleSession = true // configure OSIV singleSession mode
}

// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
//			url = "jdbc:h2:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
//            url = "jdbc:mysql://localhost:3306/i2idb"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
//			url = "jdbc:h2:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
//            url = "jdbc:mysql://localhost:3306/i2idb"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
//			url = "jdbc:h2:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
//            url = "jdbc:mysql://localhost:3306/i2idb"
            properties {
               // See http://grails.org/doc/latest/guide/conf.html#dataSource for documentation
               jmxEnabled = true
               initialSize = 5
               maxActive = 50
               minIdle = 5
               maxIdle = 25
               maxWait = 10000
               maxAge = 10 * 60000
               timeBetweenEvictionRunsMillis = 5000
               minEvictableIdleTimeMillis = 60000
               validationQuery = "SELECT 1"
               validationQueryTimeout = 3
               validationInterval = 15000
               testOnBorrow = true
               testWhileIdle = true
               testOnReturn = false
               jdbcInterceptors = "ConnectionState"
               defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED
            }
        }
    }
}
