define apache::module(
    $ensure = present,
    $package_name = 'absent',
    $source = '',
    $destination = ''
){
    case $::operatingsystem {
        centos: { apache::centos::module { "$name" : ensure => $ensure, source => $source, destination => $destination } }
        gentoo: { apache::gentoo::module { "$name" : ensure => $ensure, source => $source, destination => $destination } }
        debian: { apache::debian::module { "$name" : ensure => $ensure, package_name => $package_name } }
        ubuntu: { apache::debian::module { "$name" : ensure => $ensure, package_name => $package_name } }
        default: { apache::debian::module { "$name" : ensure => $ensure, package_name => $package_name } }
    }
}

