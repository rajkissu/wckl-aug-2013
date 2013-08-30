class s_agent {
    class { 'puppet::agent':
        puppet_server => 'puppet.lan',
        splay         => true,
    }

    # setup webserver stack and configure wordpress installations
    include s_agent::setup

    exec { 'apt-get update':
        path => '/usr/bin',
    }

    Exec <| title == 'apt-get update' |> -> Package <||>

    Class['puppet::agent'] -> Class['s_agent::setup']
}
