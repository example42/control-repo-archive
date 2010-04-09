# Class: postfix::mysql::centos
#
# This class installs Postfix with Mysql backend on Centos/RedHat
# Some tweaks are necessary to use the CentosPlus versione of postfix with mysql support

class postfix::mysql::centos {

        exec {
                "RemoveNormalPostfix":
                        command => "rpm -e --nodeps postfix ; true",
                        unless  => "postconf -m | grep mysql",
                        before  => Package["postfix"],
        }

        config { "ExcludePostifxBase":
                file      => "/etc/yum.repos.d/CentOS-Base.repo",
                parameter => "base/exclude",
                value     => "postfix",
                engine    => "augeas",
                before    => Package["postfix"],
        }

        config { "ExcludePostifxUpdate":
                file      => "/etc/yum.repos.d/CentOS-Base.repo",
                parameter => "updates/exclude",
                value     => "postfix",
                engine    => "augeas",
                before    => Package["postfix"],
        }

        config { "IncludePostifxCentosPlus":
                file      => "/etc/yum.repos.d/CentOS-Base.repo",
                parameter => "centosplus/includepkgs",
                value     => "postfix",
                engine    => "augeas",
                before    => Package["postfix"],
        }

        config { "EnableCentosPlus":
                file      => "/etc/yum.repos.d/CentOS-Base.repo",
                parameter => "centosplus/enabled",
                value     => "1",
                engine    => "augeas",
                before    => Package["postfix"],
        }

}