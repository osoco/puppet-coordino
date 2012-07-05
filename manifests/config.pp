define coordino::config($virtualhost_name, $server_admin_mail,
                        $auth_required = false, $auth_name = "", $auth_file = "", 
                        $is_https = false, $ssl_cert = "", $ssl_cert_key = "",
                        $db_user, $db_passwd, $db_name) {
    include coordino

    apache2::virtualhost { "$virtualhost_name":
        virtualhost_name => "$virtualhost_name",
        server_admin_mail => "$server_admin_mail",
        document_root => "$coordino::coordino_home",
        is_https => $is_https,
        ssl_cert => "$ssl_cert",
        ssl_cert_key => "$ssl_cert_key",
    }

    mysql::database { "$db_name": }

    mysql::user { "$db_name-user-$db_user":
        user => "$db_user",
        password => "$db_passwd",
        database => "$db_name",
        host => '%'
    }
   
    file { "$coordino::coordino_home/app/config/database.php":
        owner => "$apache2::apache2_user",
        group => "$apache2::apache2_user",
        content => template("coordino/database.php.erb"),
        require => Git::Clone["$coordino::git_clone_name"]
    }
}
