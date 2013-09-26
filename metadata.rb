name             'androidsdk-crate'
maintainer       'John Leacox'
license          'Apache 2.0'
description      'Installs/Configures androidsdk'
version          '0.1.0'

%w{
  ubuntu
}.each do |os|
  supports os
end

depends 'uncrate_base'
depends 'java-crate'
