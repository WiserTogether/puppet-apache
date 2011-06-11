class apache::reverseproxy {

  include apache::params

  apache::module {["wsgi"]: }

  file { "wsgi.conf":
    ensure  => "present",
    path    => "${apache::params::conf}/conf.d/wsgi.conf",
    content => "# file managed by puppet
<IfModule mod_wsgi.c>


    #This config file is provided to give an overview of the directives,
    #which are only allowed in the 'server config' context.
    #For a detailed description of all avaiable directives please read
    #http://code.google.com/p/modwsgi/wiki/ConfigurationDirectives


    #WSGISocketPrefix: Configure directory to use for daemon sockets.
    #
    #Apache's DEFAULT_REL_RUNTIMEDIR should be the proper place for WSGI's
    #Socket. In case you want to mess with the permissions of the directory,
    #you need to define WSGISocketPrefix to an alternative directory.
    #See http://code.google.com/p/modwsgi/wiki/ConfigurationIssues for more
    #information

        #WSGISocketPrefix /var/run/apache2/wsgi

    
    #WSGIPythonOptimize: Enables basic Python optimisation features.
    #
    #Sets the level of Python compiler optimisations. The default is '0'
    #which means no optimisations are applied.
    #Setting the optimisation level to '1' or above will have the effect
    #of enabling basic Python optimisations and changes the filename
    #extension for compiled (bytecode) files from .pyc to .pyo.
    #When the optimisation level is set to '2', doc strings will not be
    #generated and retained. This will result in a smaller memory footprint,
    #but may cause some Python packages which interrogate doc strings in some
    #way to fail. 

    WSGIPythonOptimize 1


    #WSGIPythonPath: Additional directories to search for Python modules,
    #                overriding the PYTHONPATH environment variable.
    #
    #Used to specify additional directories to search for Python modules.
    #If multiple directories are specified they should be separated by a ':'.

        #WSGIPythonPath directory|directory-1:directory-2:...


    #WSGIRestrictStdin: Enable restrictions on use of STDIN.
    #WSGIRestrictStdout: Enable restrictions on use of STDOUT.
    #WSGIRestrictSignal: Enable restrictions on use of signal().
    #
    #Well behaved WSGI applications neither should try to read/write from/to
    #STDIN/STDOUT, nor should they try to register signal handlers. If your
    #application needs an exception from this rule, you can disable the
    #restrictions here.

        #WSGIRestrictStdin On
        #WSGIRestrictStdout On
        #WSGIRestrictSignal On


    #WSGIAcceptMutex: Specify type of accept mutex used by daemon processes.
    #
    #The WSGIAcceptMutex directive sets the method that mod_wsgi will use to
    #serialize multiple daemon processes in a process group accepting requests
    #on a socket connection from the Apache child processes. If this directive
    #is not defined then the same type of mutex mechanism as used by Apache for
    #the main Apache child processes when accepting connections from a client
    #will be used. If set the method types are the same as for the Apache
    #AcceptMutex directive.

        #WSGIAcceptMutex default

</IfModule>
",
    notify  => Exec["apache-graceful"],
    require => Package["apache"],
  }

}
