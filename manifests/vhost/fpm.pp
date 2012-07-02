define apache::vhost::fpm(
    $ensure = present,
    $domain = 'absent',
    $domainalias = 'absent',
    $server_admin = 'absent',
    $ssl_mode = false,
    $website_name = $name,
    $path,
    $use_nagios = false,
    $nagios_check_string = ""
){
    apache::vhost {$name:
        ensure => $ensure,
        template_mode => 'fpm',
        domain => $domain,
        domainalias => $domainalias,
        server_admin => $server_admin,
        ssl_mode => $ssl_mode,
        path_is_webdir => false,
        path => $path,
        use_nagios => $use_nagios,
        nagios_check_string => $nagios_check_string
    }
}