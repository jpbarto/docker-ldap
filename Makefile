all: build

build:
	@docker build --tag=jpbarto/ldap .
