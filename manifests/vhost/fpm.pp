define apache::vhost::fpm(
    $ensure = present,
    $domain = 'absent',
    $domainalias = 'absent',
    $server_admin = 'absent',
    $ssl_mode = false,
    $website_name = $name,
    $path,
    $use_nagios = false,
    $nagios_check_string = "",
    $ssl_certificate_file = 'absent',
    $ssl_certificate_key_file = 'absent',
    $ssl_certificate_chain_file = 'absent',
){
    apache::vhost::template {$name:
        ensure => $ensure,
        template_mode => 'fpm',
        domain => $domain,
        domainalias => $domainalias,
        server_admin => $server_admin,
        ssl_mode => $ssl_mode,
        ssl_certificate_file => $ssl_certificate_file,
        ssl_certificate_key_file => $ssl_certificate_key_file,
        ssl_certificate_chain_file => $ssl_certificate_chain_file,
        path_is_webdir => false,
        path => $path,
        use_nagios => $use_nagios,
        nagios_check_string => $nagios_check_string
    }
}