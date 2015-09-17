Purpose
=======

Spins up Vagrant nodes (load balancers (including VIP provided by KeepAliveD), db nodes and web nodes) for testing with NGINX TCP and HTTP Load-Balancing...Creates MySQL active-active Replication to keep DB's in sync and installs a pre-configured Wordpress install (also synced via a cron job which runs an ansible playbook (sync_wordpress.yml) ). Suricata IDS/IPS role added as well; this will allow you to learn Suricata in a multi-tier environment.

###### To connect to the pre-configured wordpress site simply open your browser of choice and point to http://192.168.250.100

````
user: admin
password: VagrantAdmin1
````
If you would NOT like the wordpress db to be pre-loaded. Change the following.
###### group_vars/all/wordpress.yml
From:
````
wordpress_preload_db: true
````
To:
````
wordpress_preload_db: false
````

Requirements
============

The following packages must be installed on your Host you intend on running all of this from. If Ansible is not available for your OS (Windows) You can modify the following lines in the Vagrantfile.

From:
````
#  config.vm.provision :shell, path: "bootstrap.sh"
#      node.vm.provision :shell, path: "bootstrap_ansible.sh"

config.vm.provision :ansible do |ansible|
  ansible.playbook = "bootstrap.yml"
end
````
To:
````
  config.vm.provision :shell, path: "bootstrap.sh"
      node.vm.provision :shell, path: "bootstrap_ansible.sh"

#config.vm.provision :ansible do |ansible|
#  ansible.playbook = "bootstrap.yml"
#end
````

Ansible (http://www.ansible.com/home)

VirtualBox (https://www.virtualbox.org/)

Vagrant (https://www.vagrantup.com/)



Variable Definitions
====================
````
nodes.yml
````
Define the nodes to spin up
````
---
# Keep in mind....Vagrant will always create an initial interface as a NAT interface..Any definitions below are for adding additional interfaces.
# for network_name define a var other than remaining blank to define an internal only network. Otherwise leave blank for a host-only network.
# for DHCP leave ip and network_name vars blank
# for Static define ip var
# type should generally be private_network..Other option(s) are: public_network
- name: lb-1
  box: mrlesmithjr/trusty64
  mem: 512
  cpus: 1
  ansible_ssh_host_ip: 192.168.250.101 #always create for Ansible provisioning within nodes
  config_interfaces: "False"  #defines if interfaces below should be created or not...Set to "False" if you do not wish to create the interfaces.
  interfaces:  #Define additional interface settings
    - ip: 192.168.12.11
      auto_config: "True"
      network_name: 01-to-02
      method: static
      type: private_network
    - ip: 192.168.14.11
      auto_config: "True"
      network_name:
      method: static
      type: private_network
    - ip: 192.168.15.11
      auto_config: "False"
      network_name: 01-to-05
      method: static
      type: private_network
    - ip:
      auto_config: "True"
      network_name:
      method: dhcp
      type: private_network
- name: lb-2
  box: mrlesmithjr/trusty64
  mem: 512
  cpus: 1
  ansible_ssh_host_ip: 192.168.250.102 #always create for Ansible provisioning within nodes
  config_interfaces: "False"  #defines if interfaces below should be created or not...Set to "False" if you do not wish to create the interfaces.
  interfaces:  #Define additional interface settings
    - ip: 192.168.12.11
      auto_config: "True"
      network_name: 01-to-02
      method: static
      type: private_network
    - ip: 192.168.14.11
      auto_config: "True"
      network_name:
      method: static
      type: private_network
    - ip: 192.168.15.11
      auto_config: "False"
      network_name: 01-to-05
      method: static
      type: private_network
    - ip:
      auto_config: "True"
      network_name:
      method: dhcp
      type: private_network
- name: mysql-1
  box: mrlesmithjr/trusty64
  mem: 512
  cpus: 1
  ansible_ssh_host_ip: 192.168.250.103 #always create for Ansible provisioning within nodes
  config_interfaces: "False"  #defines if interfaces below should be created or not...Set to "False" if you do not wish to create the interfaces.
  interfaces:  #Define additional interface settings
    - ip: 192.168.12.11
      auto_config: "True"
      network_name: 01-to-02
      method: static
      type: private_network
    - ip: 192.168.14.11
      auto_config: "True"
      network_name:
      method: static
      type: private_network
    - ip: 192.168.15.11
      auto_config: "False"
      network_name: 01-to-05
      method: static
      type: private_network
    - ip:
- name: mysql-2
  box: mrlesmithjr/trusty64
  mem: 512
  cpus: 1
  ansible_ssh_host_ip: 192.168.250.104 #always create for Ansible provisioning within nodes
  config_interfaces: "False"  #defines if interfaces below should be created or not...Set to "False" if you do not wish to create the interfaces.
  interfaces:  #Define additional interface settings
    - ip: 192.168.12.11
      auto_config: "True"
      network_name: 01-to-02
      method: static
      type: private_network
    - ip: 192.168.14.11
      auto_config: "True"
      network_name:
      method: static
      type: private_network
    - ip: 192.168.15.11
      auto_config: "False"
      network_name: 01-to-05
      method: static
      type: private_network
    - ip:
- name: web-1
  box: mrlesmithjr/trusty64
  mem: 512
  cpus: 1
  ansible_ssh_host_ip: 192.168.250.105 #always create for Ansible provisioning within nodes
  config_interfaces: "False"  #defines if interfaces below should be created or not...Set to "False" if you do not wish to create the interfaces.
  interfaces:  #Define additional interface settings
    - ip: 192.168.12.11
      auto_config: "True"
      network_name: 01-to-02
      method: static
      type: private_network
    - ip: 192.168.14.11
      auto_config: "True"
      network_name:
      method: static
      type: private_network
    - ip: 192.168.15.11
      auto_config: "False"
      network_name: 01-to-05
      method: static
      type: private_network
    - ip:
- name: web-2
  box: mrlesmithjr/trusty64
  mem: 512
  cpus: 1
  ansible_ssh_host_ip: 192.168.250.106 #always create for Ansible provisioning within nodes
  config_interfaces: "False"  #defines if interfaces below should be created or not...Set to "False" if you do not wish to create the interfaces.
  interfaces:  #Define additional interface settings
    - ip: 192.168.12.11
      auto_config: "True"
      network_name: 01-to-02
      method: static
      type: private_network
    - ip: 192.168.14.11
      auto_config: "True"
      network_name:
      method: static
      type: private_network
    - ip: 192.168.15.11
      auto_config: "False"
      network_name: 01-to-05
      method: static
      type: private_network
    - ip:
````

Provisions nodes by bootstrapping using Ansible
````
bootstrap.yml
````
Bootstrap Playbook
````
---
- hosts: all
  remote_user: vagrant
  sudo: yes
  vars:
    - galaxy_roles:
      - mrlesmithjr.bootstrap
      - mrlesmithjr.base
      - mrlesmithjr.keepalived
      - mrlesmithjr.mysql
      - mrlesmithjr.nginx
      - mrlesmithjr.postfix
    - install_galaxy_roles: true
    - ssh_key_path: '.vagrant/machines/{{ inventory_hostname }}/virtualbox/private_key'
    - update_host_vars: true
  roles:
  tasks:
    - name: updating apt cache
      apt: update_cache=yes cache_valid_time=3600
      when: ansible_os_family == "Debian"

    - name: installing ansible pre-reqs
      apt: name={{ item }} state=present
      with_items:
        - python-pip
        - python-dev
      when: ansible_os_family == "Debian"

    - name: adding ansible ppa
      apt_repository: repo='ppa:ansible/ansible'
      when: ansible_os_family == "Debian"

    - name: installing ansible
      apt: name=ansible state=latest
      when: ansible_os_family == "Debian"

#    - name: installing ansible
#      pip: name=ansible state=present

#    - name: linking ansible hosts inventory
#      file: src=/etc/ansible/hosts path=/vagrant/ansible/hosts state=link

    - name: installing ansible-galaxy roles
      shell: ansible-galaxy install {{ item }} --force
      with_items: galaxy_roles
      when: install_galaxy_roles is defined and install_galaxy_roles

    - name: ensuring host file exists in host_vars
      stat: path=./host_vars/{{ inventory_hostname }}
      delegate_to: localhost
      register: host_var
      sudo: false
      when: update_host_vars is defined and update_host_vars

    - name: creating missing host_vars
      file: path=./host_vars/{{ inventory_hostname }} state=touch
      delegate_to: localhost
      sudo: false
      when: not host_var.stat.exists

    - name: updating ansible_ssh_port
      lineinfile: dest=./host_vars/{{ inventory_hostname }} regexp="^ansible_ssh_port{{ ':' }}" line="ansible_ssh_port{{ ':' }} 22"
      delegate_to: localhost
      sudo: false
      when: update_host_vars is defined and update_host_vars

    - name: updating ansible_ssh_host
      lineinfile: dest=./host_vars/{{ inventory_hostname }} regexp="^ansible_ssh_host{{ ':' }}" line="ansible_ssh_host{{ ':' }} {{ ansible_eth1.ipv4.address }}"
      delegate_to: localhost
      sudo: false
      when: update_host_vars is defined and update_host_vars

    - name: updating ansible_ssh_key
      lineinfile: dest=./host_vars/{{ inventory_hostname }} regexp="^ansible_ssh_private_key_file{{ ':' }}" line="ansible_ssh_private_key_file{{ ':' }} {{ ssh_key_path }}"
      delegate_to: localhost
      sudo: false
      when: update_host_vars is defined and update_host_vars

    - name: ensuring host_vars is yaml formatted
      lineinfile: dest=./host_vars/{{ inventory_hostname }} regexp="---" line="---" insertbefore=BOF
      delegate_to: localhost
      sudo: false
      when: update_host_vars is defined and update_host_vars
````
````
playbook.yml
````
````
---
- hosts: all
  remote_user: vagrant
  sudo: true
  vars:
    - config_hosts: true
  roles:
    - mrlesmithjr.postfix
  tasks:
    - name: updating /etc/hosts in case of dns lookup issues
      lineinfile: dest=/etc/hosts regexp='.*{{ item }}$' line="{{ hostvars[item].ansible_eth1.ipv4.address }} {{ item }}" state=present
      with_items: groups['all']
      when: config_hosts is defined and config_hosts

    - name: installing common packages
      apt: name={{ item }} state=present
      with_items:
        - git
        - mysql-client

    - name: ensuring ssh_pub_keys folder exists
      file: path=ssh_pub_keys state=directory
      delegate_to: localhost
      sudo: false
      tags:
        - ssh_keys

    - name: generating ssh keys
      user: name=vagrant generate_ssh_key=yes
      tags:
        - ssh_keys

    - name: downloading ssh keys
      fetch: src=/home/vagrant/.ssh/id_rsa.pub dest=./ssh_pub_keys/vagrant@{{ ansible_hostname }}.pub flat=yes
      tags:
        - ssh_keys

    - name: adding ssh authorized_keys
      authorized_key: user=vagrant key="{{ lookup('file', 'ssh_pub_keys/vagrant' + '@' + item + '.pub') }}" state=present
      with_items: groups['all']
      tags:
        - ssh_keys

    - name: identifying hosts
      local_action: ping
      register: id_hosts
      tags:
        - ssh_keys

    - name: cleaning up
      file: path=/tmp/hosts state=absent
      tags:
        - ssh_keys

    - name: cleaning up
      file: path=/tmp/hosts state=absent
      delegate_to: localhost
      run_once: true
      tags:
        - ssh_keys

    - name: creating temporary hosts file
      file: path=/tmp/hosts state=touch mode=0777
      delegate_to: localhost
      run_once: true
      tags:
        - ssh_keys

    - name: adding hosts to temporary hosts file
      lineinfile: dest=/tmp/hosts regexp="^{{ ansible_hostname }}" line="{{ ansible_hostname }}" state=present
      delegate_to: localhost
      with_items: id_hosts.results
      tags:
        - ssh_keys

    - name: adding hosts to temporary hosts file
      lineinfile: dest=/tmp/hosts regexp="^{{ ansible_hostname }}" line="{{ ansible_hostname }}" state=present
      delegate_to: localhost
      with_items: id_hosts.results
      tags:
        - ssh_keys

    - name: adding hosts to temporary hosts file
      lineinfile: dest=/tmp/hosts regexp="^{{ ansible_default_ipv4.address }}" line="{{ ansible_default_ipv4.address }}" state=present
      delegate_to: localhost
      with_items: id_hosts.results
      tags:
        - ssh_keys

    - name: keyscan
      shell: "ssh-keyscan -H -f /tmp/hosts >> /tmp/hosts.ready"
      delegate_to: localhost
      run_once: true
      tags:
        - ssh_keys

    - name: sort
      shell: "sort -u /tmp/hosts.ready > /tmp/hosts.sorted"
      delegate_to: localhost
      run_once: true
      tags:
        - ssh_keys

    - name: copying new ssh_known_hosts
      copy: src=/tmp/hosts.sorted dest=/etc/ssh/ssh_known_hosts
      tags:
        - ssh_keys

    - name: cleaning up
      file: path=/tmp/hosts state=absent
      delegate_to: localhost
      run_once: true
      tags:
        - ssh_keys

- hosts: load-balancers
  remote_user: vagrant
  sudo: true
  handlers:
    - name: restart nginx
      service: name=nginx state=restarted
  vars:
    - disable_default_nginx_site: true
    - load_balancer_configs:
        - name: mysql
          load_balancing_method: least_conn ##least_conn, least_time or ip_hash
          protocol: tcp
          backend_port: 3306
          frontend_port: 3306
          backend_servers:
           - mysql-1
           - mysql-2
        - name: nginx
          load_balancing_method: ip_hash
          protocol: http
          backend_port: 80
          frontend_port: 80
          backend_servers:
            - web-1
            - web-2
          server_name: "{{ ansible_hostname }}"
          location: /
#        - name: elasticsearch
#          load_balancing_method: least_conn ##least_conn, least_time or hash
#          protocol: tcp
#          backend_port: 9200
#          frontend_port: 9200
#          backend_servers:
#            - es-1
#            - es-2
    - nginx_branch: development
  roles:
    - mrlesmithjr.keepalived
    - mrlesmithjr.nginx
  tasks:
    - name: adding nginx repo
      apt_repository: repo='ppa:nginx/{{ nginx_branch }}' state=present

    - name: upgrading nginx
      apt: name=nginx state=latest

    - name: configuring nginx for tcp load balancing
      template: src=templates/etc/nginx/nginx.conf.j2 dest=/etc/nginx/nginx.conf
      notify: restart nginx

    - name: ensuring nginx stream.d folder exists
      file: path=/etc/nginx/stream.d state=directory

    - name: configuring nginx load balancer (TCP) configs
      template: src=templates/etc/nginx/stream.d/streams.conf.j2 dest=/etc/nginx/stream.d/{{ item.name }}.conf
      notify: restart nginx
      with_items: load_balancer_configs
      when: load_balancer_configs is defined and item.protocol == "tcp"

    - name: configuring nginx load balancer (HTTP) configs
      template: src=templates/etc/nginx/conf.d/http.conf.j2 dest=/etc/nginx/conf.d/{{ item.name }}.conf
      notify: restart nginx
      with_items: load_balancer_configs
      when: load_balancer_configs is defined and item.protocol == "http"

    - name: disabling NGINX default web site
      file: dest=/etc/nginx/sites-enabled/default state=absent
      notify: restart nginx
      when: disable_default_nginx_site is defined and disable_default_nginx_site

- hosts: mysql-nodes
  remote_user: vagrant
  sudo: true
  vars:
  handlers:
    - name: restart mysql
      service: name=mysql state=restarted
  roles:
    - mrlesmithjr.mysql
  tasks:
    - name: checking if cluster is configured
      stat: path=/etc/mysql/clustered
      register: clustered

    - name: creating mysql users
      mysql_user: name={{ item.name }} password={{ item.pass }} priv=*.*:ALL state=present host=%
      with_items: mysql_accounts

    - name: configuring mysql
      template: src=templates/etc/mysql/my.cnf.j2 dest=/etc/mysql/my.cnf owner=root group=root mode=0644
      register: mysql_configured

    - name: restarting mysql
      service: name=mysql state=restarted
      when: mysql_configured.changed

    - name: finding master log position
      mysql_replication: mode=getmaster
      register: master
      delegate_to: "{{ mysql_master }}"
      when: not clustered.stat.exists

    - name: finding slave log position
      mysql_replication: mode=getmaster
      register: slave
      delegate_to: "{{ mysql_slave }}"
      when: not clustered.stat.exists

    - name: stopping slave on slave
      mysql_replication: mode=stopslave
      when: not clustered.stat.exists

    - name: configuring replication on slave
      mysql_replication: mode=changemaster master_host={{ mysql_master }} master_log_file={{ master.File }} master_log_pos={{ master.Position }} master_user={{ mysql_replication_user }} master_password={{ mysql_replication_pass }}
      when: mysql_master is defined and inventory_hostname == "{{ mysql_slave }}" and not clustered.stat.exists

    - name: configuring replication on master
      mysql_replication: mode=changemaster master_host={{ mysql_slave }} master_log_file={{ slave.File }} master_log_pos={{ slave.Position }} master_user={{ mysql_replication_user }} master_password={{ mysql_replication_pass }}
      when: mysql_slave is defined and inventory_hostname == "{{ mysql_master }}" and not clustered.stat.exists

    - name: creating mysql dbs
      mysql_db: name={{ item }} state=present
      register: dbs_created
      with_items: mysql_replication_dbs
      when: mysql_master is defined and inventory_hostname == "{{ mysql_master }}"

    - name: marking cluster as configured
      file: path=/etc/mysql/clustered state=touch
      when: not clustered.stat.exists

    - name: copying pre-loaded wordpress sql file
      copy: src=files/wordpress.sql dest=/tmp/wordpress.sql
      when: dbs_created.changed and (wordpress_preload_db is defined and wordpress_preload_db)

    - name: pre-loading wordpress db
      mysql_db: state=import name={{ wordpress_db }} target=/tmp/wordpress.sql
      when: dbs_created.changed and (wordpress_preload_db is defined and wordpress_preload_db) and (mysql_master is defined and inventory_hostname == "{{ mysql_master }}")

- hosts: web-servers
  remote_user: vagrant
  sudo: true
  vars:
    - disable_default_nginx_site: true
    - nginx_default_root: /usr/share/nginx/html
  handlers:
    - name: restart nginx
      service: name=nginx state=restarted
  roles:
    - mrlesmithjr.nginx
  tasks:
    - name: installing pre-req packages
      apt: name={{ item }} state=present
      with_items:
        - mcrypt
        - php5
        - php5-cgi
        - php5-fpm
        - php5-mysql

    - name: configuring default web page to validate load-balancers
      template: src=templates/usr/share/nginx/html/index.html.j2 dest="{{ nginx_default_root }}/index.html"

    - name: downloading wordpress package
      get_url: url={{ wordpress_package }} dest="{{ nginx_default_root }}/wordpress.tar.gz"

    - name: extracting wordpress package
      unarchive: src="{{ nginx_default_root }}/wordpress.tar.gz" dest="{{ nginx_default_root }}/" creates="{{ wordpress_default_root }}/index.php" copy=no

    - name: disabling NGINX default web site
      file: dest=/etc/nginx/sites-enabled/default state=absent
      notify: restart nginx
      when: disable_default_nginx_site is defined and disable_default_nginx_site

    - name: Fetch random salts for WordPress config
      local_action: command curl https://api.wordpress.org/secret-key/1.1/salt/
      register: wp_salt
      sudo: no

    - name: configuring wordpress site
      template: src=templates/etc/nginx/conf.d/default.conf.j2 dest=/etc/nginx/conf.d/default.conf
      notify: restart nginx

    - name: configuring wordpress
      template: src=templates/usr/share/nginx/html/wordpress/wp-config.php.j2 dest="{{ wordpress_default_root }}/wp-config.php" owner=www-data group=www-data

    - name: changing ownership of wordpress root folder
      file: dest={{ wordpress_default_root }} state=directory owner=www-data group=www-data recurse=yes

    - name: creating ansible playbook
      template: src=templates/sync_wordpress.yml.j2 dest=/vagrant/sync_wordpress.yml owner=vagrant group=vagrant
      tags:
        - cron

    - name: creating cron job
      cron: name="ansible sync wordpress" minute=*/1 user=vagrant job="cd /vagrant && /usr/bin/ansible-playbook -i /vagrant/hosts /vagrant/sync_wordpress.yml" cron_file=ansible_sync_wordpress state=present
      tags:
        - cron
````
group_vars/all/keepalived.yml
````
---
config_keepalived: true
keepalived_vip: 192.168.250.100
keepalived_vip_int: eth1
````
group_vars/all/mysql.yml
````
---
mysql_accounts:
  - name: "{{ mysql_replication_user }}"
    pass: "{{ mysql_replication_pass }}"
  - name: "{{ mysql_test_user }}"
    pass: "{{ mysql_test_pass }}"
  - name: "{{ wordpress_db_user }}"
    pass: "{{ wordpress_db_user_pass }}"
mysql_master: mysql-1
mysql_replication_dbs:
  - test
  - test1
  - test2
  - "{{ wordpress_db }}"
mysql_replication_user: replicator
mysql_replication_pass: replication
mysql_server_replication: true
mysql_slave: mysql-2
mysql_test_user: lbtest
mysql_test_pass: lbtest
````
group_vars/all/wordpress.yml
````
---
wordpress_admin_password: 91e71c4092c656317cdf2063fa7e1143  #default is VagrantAdmin1; generate new password here http://www.miraclesalad.com/webtools/md5.php
wordpress_admin_user: admin
# Disable All Updates
  # By default automatic updates are enabled, set this value to true to disable all automatic updates
wordpress_auto_up_disable: false
#Define Core Update Level
  #true  = Development, minor, and major updates are all enabled
  #false = Development, minor, and major updates are all disabled
  #minor = Minor updates are enabled, development, and major updates are disabled
wordpress_core_update_level: true
wordpress_db: wordpress
wordpress_db_server: "{{ keepalived_vip }}"
wordpress_db_user: wordpress
wordpress_db_user_pass: wordpress
wordpress_default_root: "{{ nginx_default_root }}/wordpress"
wordpress_dst_sync_dir: /usr/share/nginx/html
wordpress_package: http://wordpress.org/latest.tar.gz
wordpress_preload_db: true
wordpress_src_sync_dir: /usr/share/nginx/html/wordpress
wordpress_update_db_site_file: /tmp/update_db_site.sql
````

Usage
=====

http://everythingshouldbevirtual.com/learning-vagrant-and-ansible-provisioning

````
git clone https://github.com/mrlesmithjr/vagrant-ansible-nginx-loadbalancing.git
cd vagrant-ansible-nginx-loadbalancing
````
Spin up your environment
````
vagrant up
````

To run ansible from within Vagrant nodes (Ex. site.yml)
````
vagrant ssh lb-1 # or lb-2, mysql-1, mysql-2, web-1 or web-2; any will work
cd /vagrant
./update_hosts.sh
ansible-playbook -i hosts playbook.yml
````

Now you should be able to open your browser and head over to http://192.168.250.100 and login with (admin/VagrantAdmin1)
If for some reason your site is redirecting to http://nginx you can run the following playbook to update the DB..(Should be fixed now but in case there is a need)
````
vagrant ssh lb-1 #lb-1, lb-2, mysql-1, mysql-2, web-1 or web-2; all work
cd /vagrant
ansible-playbook -i hosts fix_db_wordpress_site_url.yml
````

License
-------

BSD

Author Information
------------------

Larry Smith Jr.
- @mrlesmithjr
- http://everythingshouldbevirtual.com
- mrlesmithjr [at] gmail.com
