PHP_IMAGE			:= wpengine/php
PHP_VERSION			:= 7.2
COMPOSER_IMAGE		:= skypress/wp-composer
COMPOSER_VERSION	:= latest
USER_GROUP			:= www-data
CURRENT_USER		:= $(shell whoami)

default: lint

lint: lint-php
clean: file-own file-perms
install: composer-install file-own file-perms
update: composer-update file-own file-perms

lint-php:
		@echo
		# Running php -l
		@docker run --rm \
			--volume $(PWD):/workspace \
			--workdir /workspace \
			$(PHP_IMAGE):$(PHP_VERSION) \
				/bin/bash -c 'find . \
					-not \( -path "*/vendor" -prune \) \
					-name \*.php \
					-print0 | \
					xargs -I {} -0 php -l {}'
		@echo
		# Linted PHP files

file-perms:
	@echo
	# Setting proper file permissions
	sudo find . -type d -exec chmod 775 {} \;
	sudo find . -type f -exec chmod 664 {} \;
	@echo
	# File permissions set

file-own:
	@echo
	# Changing ownership project files
	sudo chown -R $(CURRENT_USER):$(USER_GROUP) $(PWD)
	@echo
	# Ownsership set

composer-install:
	@echo
	# Installing packages from composer.json
	@docker run --rm \
		--volume $(PWD):/app \
		$(COMPOSER_IMAGE):$(COMPOSER_VERSION) \
			composer install -o
	@echo
	# Finished install packages

composer-update:
	@echo
	# Installing packages from composer.json
	@docker run --rm \
		--volume $(PWD):/app \
		$(COMPOSER_IMAGE):$(COMPOSER_VERSION) \
			composer update -o
	@echo
	# Finished install packages
