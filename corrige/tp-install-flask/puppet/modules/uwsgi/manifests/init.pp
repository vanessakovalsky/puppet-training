class uwsgi {

    $mount_point = "/var/www/${hostname}.${domain}/src"

    $params = {
        "uid" => "www-data",
        "gid" => "www-data",
        "socket" => "/tmp/uwsgi.sock",
        "logdate" => "",
        "optimize" => 2,
        "processes" => 2,
        "master" => "",
        "die-on-term" => "",
        "logto" => "/var/log/uwsgi.log",
        "chdir" => $mount_point,
        "module" => "app",
        "callable" => "app",
    }

    package { "uwsgi":
        ensure => installed,
        require => [Class["python::packages"]],
    }

    # package { "uwsgi":
    #     ensure => installed,
    #     provider => pip,
    #     require => [Class["python::packages"]],
    # }
    file { "/etc/init/uwsgi.conf":
        ensure => present,
        owner => "root",
        group => "root",
        mode => "0644",
        content => template("uwsgi/uwsgi.conf.erb"),
        require => Package["uwsgi"],
    }
    file { "/var/log/uwsgi.log":
        ensure => present,
        owner => "www-data",
        group => "www-data",
        mode => "0755",
        require => User["www-data"],
    }
    service { "uwsgi":
        ensure => running,
        enable => true,
        require => [File["/etc/init/uwsgi.conf"], File["/var/log/uwsgi.log"]],
    }
}
