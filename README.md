puppet-coordino
===============

Puppet module to install coordino Q&amp;A software. Depends on:
  * OSOCO apache2 puppet module: https://github.com/osoco/puppet-apache2
  * OSOCO apache2 PHP puppet module: https://github.com/osoco/puppet-apache2_php

Example of usage:

  class coordino_conf($virtualhost_name = 'coordino.myorg.com') {

    class { 'coordino': coordino_url =>'https://github.com/osoco/coordino.git' } # Patched to avoid captcha

    coordino::config { "configure-coordino-$virtualhost_name":
        virtualhost_name => "$virtualhost_name", 
        server_admin_mail => "admin@myorg.com",
        db_name => 'coordino',
        db_user => 'coordino',
        db_passwd => 'coordino'
    }
  }
