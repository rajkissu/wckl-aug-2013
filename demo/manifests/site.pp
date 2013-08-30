node "puppet.lan" {
    include s_master
}

node /agent/ {
    include s_agent
}
