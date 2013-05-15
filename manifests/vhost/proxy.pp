define apache::vhost::proxy(
    $ensure = present,
    $domain = 'absent',
    $domainalias = 'absent',
    $server_admin = 'absent',
    $allow_list = ['all'],
    $deny_list = '',
    $order_allow_deny = "allow,deny",
    $proxy_path,
    $proxy_url
){
    # create vhost configuration file
    apache::vhost::template{$name:
        template_mode => 'proxy',
        ensure => $ensure,
        domain => $domain,
        domainalias => $domainalias,
        server_admin => $server_admin,
        allow_list => $allow_list,
        deny_list => $deny_list,
        order_allow_deny => $order_allow_deny,
    }
}

