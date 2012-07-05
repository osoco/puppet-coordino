class coordino ($coordino_parent_path = '/var/www', $coordino_url = 'https://github.com/Datawalke/Coordino') {

    include apache2
    include apache2_php

    $coordino_home = "$coordino_parent_path/coordino"
    $git_clone_name = 'git-clone-coordino'
    $exec_grant_name = "grant-apache-user-access-$coordino_home"

    if !defined(File["$coordino_parent_path"]) {
        file { "$coordino_parent_path":
            ensure => 'directory',
            owner => "$apache2::apache2_user",
            group => "$apache2::apache2_user",
        }
    }

    git::clone { "$git_clone_name":
       username => 'anybody',
       password => 'anything',
       url => "$coordino_url",
       path => "$coordino_home",
       notify => Exec["$exec_grant_name"]
    }

    exec { "$exec_grant_name":
       command => "chown -R ${apache2::apache2_user}:${apache2::apache2_user} $coordino_home",
       refreshonly => true
    }

    if !defined(Apache2::Module["rewrite"]) {
        apache2::module { "rewrite":
            modname => "rewrite"
        }
    }
}
