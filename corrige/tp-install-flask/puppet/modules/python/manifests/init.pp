class python {
    include python::packages

    package { 'python':
        ensure => installed,
    }
}

class python::packages {
    $apt = ['build-essential', 'python3-pip', 'python3-dev' ]
    $pip = ['flask', ]

    package { $apt:
        require => Class['python'],
        ensure => installed,
    }

    package { $pip:
        require => Class['python'],
        ensure => installed,
        provider => pip,
    }
}
