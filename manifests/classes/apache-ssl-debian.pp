class apache::ssl::debian inherits apache::ssl {

  apache::module {"ssl":
    ensure => present,
  }

  line {"listen on port 443":
    ensure => present,
    line => "Listen 443",
    file => "/etc/apache2/ports.conf",
    notify  => Service["apache"],
    require => Package["apache"],
  }

}
