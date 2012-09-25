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
    $nagios_auth = false,
    $auth_name = "",
    $auth_password = "",
    $ssl_certificate_file = 'absent',
    $ssl_certificate_key_file = 'absent',
    $ssl_certificate_chain_file = 'absent',
    $htpasswd_file = 'absent',
    $htpasswd_path = 'absent',
    $allow_list = ['all'],
    $deny_list = '',
    $order_allow_deny = "allow,deny",
    $use_custom_ssl_access = false,
    $allow_list_ssl = ['all'],
    $deny_list_ssl = '',
    $order_allow_deny_ssl = "allow,deny",
    $additional_options = "",
    $socket_path = ""
){
    if $socket_path == "" {
	$real_socket_path = "/var/lib/apache2/fpm-${website_name}.sock"
    } else {
        $real_socket_path = $socket_path
    }

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
        htpasswd_file => $htpasswd_file,
        htpasswd_path => $htpasswd_path,
        allow_list => $allow_list,
        deny_list => $deny_list,
        order_allow_deny => $order_allow_deny,
        use_custom_ssl_access => $use_custom_ssl_access,
        allow_list_ssl => $allow_list_ssl,
        deny_list_ssl => $deny_list_ssl,
        order_allow_deny_ssl => $order_allow_deny_ssl,
        path_is_webdir => false,
        path => $path,
        use_nagios => $use_nagios,
        nagios_check_string => $nagios_check_string,
        nagios_auth => $nagios_auth,
        auth_name => $auth_name,
        auth_password => $auth_password,
        additional_options => $additional_options,
    }
}