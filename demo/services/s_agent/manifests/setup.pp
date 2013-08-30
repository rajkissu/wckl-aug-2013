class s_agent::setup {
    # setup apache
    class { 'apache':
        mpm_module => prefork,
    }

    include apache::mod::php

    # setup mysql
    include mysql
    include mysql::server
    include mysql::php

    # setup wordpress sites
    s_agent::wordpress { "wc1": }
    s_agent::wordpress { "wc2": }
    s_agent::wordpress { "wc3": }

    Class['mysql::server'] -> S_agent::Wordpress <||>
}
