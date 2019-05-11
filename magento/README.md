## install composer the php package manager
```
brew install composer
```

## https://github.com/markshust/docker-magento

- add `127.0.0.1 magento2.test` to `/etc/hosts`
- install and setup
```
curl -s https://raw.githubusercontent.com/markshust/docker-magento/master/lib/template|bash -s - magento-2
bin/download 2.3.1
bin/setup magento2.test
```

## Other
Use composer to install
```
composer create-project --ignore-platform-reqs --repository-url=https://repo.magento.com/ magento/project-community-edition .
```
