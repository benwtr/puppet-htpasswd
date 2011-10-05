module Puppet
  newtype(:htpasswd) do
    @doc = "Manage an Apache style htpasswd file
  
    htpasswd { \"user\":
      ensure => present,
      cryptpasswd => \"MrC7Aq3qPKPaK\",
      target => \"/etc/httpd/conf/htpasswd\",
    }"

    ensurable

    newparam(:name, :namevar => true) do
      desc "The user to manage"
      isnamevar
    end

    newproperty(:cryptpasswd) do
      desc "The encrypted password for the given user"
    end

    newproperty(:target) do
      desc "Location of the htpasswd file"
      defaultto {
        if @resource.class.defaultprovider.ancestors.include?(Puppet::Provider::ParsedFile)
          @resource.class.defaultprovider.default_target
        else
          nil
        end
      }
    end

  end
end
