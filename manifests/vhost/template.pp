# template_mode:
#   - php: for a default php application
#   - static: for a static application (default)
#   - perl: for a mod_perl application
#   - php_joomla: for a joomla application
#
# domainalias:
#   - absent: no domainalias is set (*default*)
#   - www: domainalias is set to www.$domain
#   - else: domainalias is set to that
#
# ssl_mode: wether this vhost supports ssl or not
#   - false: don't enable ssl for this vhost (default)
#   - true: enable ssl for this vhost
#   - force: enable ssl and redirect non-ssl to ssl
#   - only: enable ssl only
# php_safe_mode_exec_bins: An array of local binaries which should be linked in the
#                          safe_mode_exec_bin for this hosting
#                          *default*: None
# php_default_charset: default charset header for php.
#                      *default*: absent, which will set the same as default_charset
#                                 of apache
define apache::vhost::template(
    $ensure = present,
    $path = 'absent',
    $path_is_webdir = true,
    $logpath = 'absent',
    $domain = 'absent',
    $domainalias = 'absent',
    $server_admin = 'absent',
    $allow_override = 'None',
    $php_safe_mode_exec_bin_dir = 'absent',
    $php_upload_tmp_dir = 'absent',
    $php_session_save_path = 'absent',
    $dav_db_dir = 'absent',
    $cgi_binpath = 'absent',
    $do_includes = false,
    $options = 'absent',
    $additional_options = 'absent',
    $default_charset = 'absent',
    $php_use_smarty = false,
    $php_use_pear = false,
    $php_safe_mode = true,
    $php_default_charset = 'absent',
    $php_additional_open_basedirs = 'absent',
    $php_additional_options = 'absent',
    $run_mode = 'normal',
    $run_uid = 'absent',
    $run_gid = 'absent',
    $template_mode = 'static',
    $ssl_mode = false,
    $ssl_certificate_file = 'absent',
    $ssl_certificate_key_file = 'absent',
    $ssl_certificate_chain_file = 'absent',
    $use_mod_macro = false,
    $htpasswd_file = 'absent',
    $htpasswd_path = 'absent',
    $ldap_auth = false,
    $ldap_user = 'any',
    $allow_list = ['all'],
    $deny_list = '',
    $order_allow_deny = "allow,deny",
    $use_custom_ssl_access = false,
    $allow_list_ssl = ['all'],
    $deny_list_ssl = '',
    $order_allow_deny_ssl = "allow,deny",
    $satisfy = 'absent',
    $use_nagios = false,
    $nagios_check_string = '',
    $nagios_auth = false,
    $auth_name = "",
    $auth_password = "",
    $gitweb_config = "/etc/gitweb.conf",
){

    if ! $use_custom_ssl_access {
	$real_order_allow_deny_ssl = $order_allow_deny
	$real_allow_list_ssl = $allow_list
	$real_deny_list_ssl = $deny_list
    }

    $real_path = $path ? {
        'absent' => $::operatingsystem ? {
            openbsd => "/var/www/htdocs/${name}",
            default => "/var/www/vhosts/${name}"
        },
        default => $path
    }

    if $path_is_webdir {
        $documentroot = "${real_path}"
    } else {
        $documentroot = "${real_path}/www"
    }

    $servername = $domain ? {
        'absent' => $name,
        default => $domain
    }
    $serveralias = $domainalias ? {
        'absent' => '',
        'www' => "www.${servername}",
        default => $domainalias
    }
    if $htpasswd_path == 'absent' {
      $real_htpasswd_path = "/var/www/htpasswds/${name}"
    } else {
      $real_htpasswd_path = $htpasswd_path
    }
    case $run_mode {
        'itk': {
            case $run_uid {
                'absent': { fail("you have to define run_uid for $name on ${::fqdn}") }
            }
            case $run_gid {
                'absent': { fail("you have to define run_gid for $name on ${::fqdn}") }
            }
        }
    }


    # set default dirs for templates
    # php php_safe_mode_exec_bin directory
    case $php_safe_mode_exec_bin_dir {
        'absent': {
            $real_php_safe_mode_exec_bin_dir = "/var/www/vhosts/${name}/bin"
        }
        default: { $real_php_safe_mode_exec_bin_dir = $php_safe_mode_exec_bin_dir }
    }
    # php upload_tmp_dir
    case $php_upload_tmp_dir {
        'absent': {
            $real_php_upload_tmp_dir = "/var/www/upload_tmp_dir/${name}"
        }
        default: { $real_php_upload_tmp_dir = $php_upload_tmp_dir }
    }
    # php session_save_path
    case $php_session_save_path {
        'absent': {
            $real_php_session_save_path = "/var/www/session.save_path/${name}"
        }
        default: { $real_php_session_save_path = $php_session_save_path }
    }
    # dav db dir
    case $dav_db_dir {
        'absent': {
            $real_dav_db_dir = "/var/www/dav_db_dir/${name}"
        }
        default: { $real_dav_db_dir = $dav_db_dir }
    }

    apache::vhost::file{$name:
        ensure => $ensure,
        content => template("apache/vhosts/$template_mode/${::operatingsystem}.erb"),
        do_includes => $do_includes,
        htpasswd_file => $htpasswd_file,
        htpasswd_path => $htpasswd_path,
        use_mod_macro => $use_mod_macro,
        use_nagios => $use_nagios,
        nagios_check_string => $nagios_check_string,
        nagios_auth => $nagios_auth,
        auth_name => $auth_name,
        auth_password => $auth_password,
        ssl_mode => $ssl_mode,
    }
}

