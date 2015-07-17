name 'docker-registry2'
maintainer 'dennyzhang'
maintainer_email 'denny.zhang001@gmail.com'
license 'All rights reserved'
description 'Chef cookbook to install and setup docker-registry2'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

supports 'ubuntu'

depends 'apt', '=2.6.1'
depends 'python', '=1.4.6'
depends 'htpasswd', '=0.2.4'
depends 'nginx', '=2.7.6'
