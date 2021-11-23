class mariadb {
    package { 'mariadb-server':
        ensure => installed,
    }
    service { 'mysqld':
        ensure => running,
        enable => true,
    }
}
