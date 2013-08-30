define s_agent::wordpress (
    $user       = $name,
    $group      = $name,
    $servername = "${name}.wordpress.lan",
    $docroot    = "/opt/${name}",
    $port       = 80,
){
    # create user and group
    user { $user:
        ensure     => present,
        home       => $docroot,
        managehome => true,
        gid        => $group,
    }

    group { $group:
        ensure => present,
    }

    # add host entry
    host { $servername:
        ensure => present,
        ip     => $::ipaddress,
    }

    # add vhost entry
    apache::vhost { $servername:
        docroot_owner => $user,
        docroot_group => $group,
        docroot       => $docroot,
        port          => $port,
    }

    # wordpress installation
    ::wordpress::setup { $user:
        install_dir => $docroot,
        wp_owner    => $user,
        wp_group    => $group,
    }
}
