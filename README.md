# Webcamp August 2013 Presentation Demo

The following instructions are for a public network setup on Vagrant. For other
network setups, please consult the original documentation.

### Preparing your environment
1. Install [Vagrant](http://docs.vagrantup.com/v2/installation/)
2. Checkout the included submodules

    <!-- language: bsh -->
        $ git submodule update --init
    <!-- language: lang-none -->

### Setting up the puppet master
1. Bring up the master node, this will take some time. If you see a notice indicating failure to connect to PuppetDB, don't worry - PuppetDB takes some time to boot up.

    <!-- language: bsh -->
        $ vagrant up master
    <!-- language: lang-none -->

2. Open up a remote shell to the master node

    <!-- language: bsh -->
        $ vagrant ssh master 
    <!-- language: lang-none -->

3. Switch to the root user

    <!-- language: bsh -->
        $ sudo -i
    <!-- language: lang-none -->

4. Do a puppet agent run

    <!-- language: bsh -->
        $ puppet agent -t
    <!-- language: lang-none -->

### Setting up a puppet agent

1. Bring up the agent node. It should end with a failure, this is expected as it
   cannot reach the master node just yet.

2. Open up a remote shell to the agent node

    <!-- language: bsh -->
        $ vagrant ssh agent
    <!-- language: lang-none -->

3. Switch to the root user

    <!-- language: bsh -->
        $ sudo -i
    <!-- language: lang-none -->

4. Add an /etc/hosts entry for the master's FQDN. The default master FQDN is puppet.lan

    <!-- language: bsh -->
        # /etc/hosts
        127.0.0.1   localhost

        192.168.1.xxx agent.lan agent
        192.168.1.xxx puppet.lan puppet
    <!-- language: lang-none -->

5. Do a puppet agent run

    <!-- language: bsh -->
        $ puppet agent -t
    <!-- language: lang-none -->

6. The puppet agent run will end with a `waitforcert is disabled` notice. This
   signifies that puppet master needs to verify and sign this agent's cert. In
   order to do that, open a remote shell to master, switch to the root user and
   sign the agent's certification.

    <!-- language: bsh -->
        $ vagrant ssh master
        $ sudo -i
        $ puppet cert list -a
        $ puppet cert sign agent.lan
    <!-- language: lang-none -->

7. Go back to the agent shell and do a puppet run

    <!-- language: bsh -->
        $ puppet agent -t
    <!-- language: lang-none -->

8. Once the puppet run completes, you should see 3 directories in `/opt` on the agent node

    <!-- language: bsh -->
        $ ls /opt
        wc1 wc2 wc3
    <!-- language: lang-none -->

9. On your host machine, add /etc/hosts entries to view the above wordpress setups from your browser. The ip address for the wordpress sites is the same as the agent node's ip address

    <!-- language: bsh -->
        # /etc/hosts
        127.0.0.1   localhost

        192.168.1.xxx wc1.wordpress.lan wc1
        192.168.1.xxx wc2.wordpress.lan wc2
        192.168.1.xxx wc3.wordpress.lan wc3
    <!-- language: lang-none -->
