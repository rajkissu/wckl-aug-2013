class s_master {
    include puppet::repo::puppetlabs
    include puppetdb

    class { 'puppet::master':
        modulepath   => '/etc/puppet/modules:/etc/puppet/services',
        storeconfigs => true,
    }

    # update the apt repo
    exec { 'apt-get update':
        path => '/usr/bin',
    }

    # get SSL certificates up and running
    # for puppetdb
    exec { 'puppetdb-ssl-setup':
        path    => '/usr/sbin:/usr/bin:/bin',
        creates => [
            '/etc/puppetdb/ssl/private.pem',
            '/etc/puppetdb/ssl/public.pem',
            '/etc/puppetdb/ssl/ca.pem',
        ],
    }

    Class['puppet::repo::puppetlabs'] -> Exec <| title == 'apt-get update' |> -> Package <||>

    Exec['Certificate_Check'] -> Exec['puppetdb-ssl-setup'] -> Class['puppetdb::master::config']
}
