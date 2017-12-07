FROM wordpress:php7.1-fpm-alpine

ENV JOINTSWP_VERSION 5.0

RUN set -ex; \
	\
	apk add --no-cache --virtual .build-deps \
		openldap-dev \
	; \
	docker-php-ext-install ldap; \
	\
	runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"; \
	apk add --virtual .wordpress-phpexts-rundeps $runDeps; \
	apk del .build-deps; \
	curl -o jointswp.tar.gz -fSL "https://github.com/JeremyEnglert/JointsWP/archive/${JOINTSWP_VERSION}.tar.gz"; \
	tar -xzf jointswp.tar.gz -C /usr/src/wordpress/wp-content/themes/; \
	rm jointswp.tar.gz; \
	
	
	
