# vhost_mode: which option is chosen to deploy the vhost
#   - template: generate it from a template (default)
#   - file: deploy a vhost file (apache::vhost::file will be called directly)
define apache::vhost::static(
    $ensure = present,
    $domain = 'absent',
    $domainalias = 'absent',
    $server_admin = 'absent',
    $path = 'absent',
    $owner = root,
    $group = apache,
    $documentroot_owner = apache,
    $documentroot_group = 0,
    $documentroot_mode = 0640,
    $allow_override = 'None',
    $do_includes = false,
    $options = 'absent',
    $additional_options = 'absent',
    $default_charset = 'absent',
    $ssl_mode = false,
    $vhost_mode = 'template',
    $vhost_source = 'absent',
    $vhost_destination = 'absent',
    $htpasswd_file = 'absent',
    $htpasswd_path = 'absent',
    $mod_security = false,
    $mod_security_relevantonly = true,
    $ssl_certificate_file = 'absent',
    $ssl_certificate_key_file = 'absent',
    $ssl_certificate_chain_file = 'absent',
){
    # create webdir
    ::apache::vhost::webdir{$name:
        ensure => $ensure,
        path => $path,
        owner => $owner,
        group => $group,
        run_mode => 'normal',
        documentroot_owner => $documentroot_owner,
        documentroot_group => $documentroot_group,
        documentroot_mode => $documentroot_mode,
    }

    # create vhost configuration file
    ::apache::vhost{$name:
        ensure => $ensure,
        path => $path,
        template_mode => 'static',
        vhost_mode => $vhost_mode,
        vhost_source => $vhost_source,
        vhost_destination => $vhost_destination,
        domain => $domain,
        domainalias => $domainalias,
        server_admin => $server_admin,
        allow_override => $allow_override,
        do_includes => $do_includes,
        options => $options,
        additional_options => $additional_options,
        default_charset => $default_charset,
        ssl_mode => $ssl_mode,
        ssl_certificate_file => $ssl_certificate_file,
        ssl_certificate_key_file => $ssl_certificate_key_file,
        ssl_certificate_chain_file => $ssl_certificate_chain_file,
        htpasswd_file => $htpasswd_file,
        htpasswd_path => $htpasswd_path,
        mod_security => $mod_security,
        mod_security_relevantonly => $mod_security_relevantonly,
    }
}

