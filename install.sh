#!/usr/bin/env sh
# DESCRIPTION
#   Install sshuttle-helper as an init-script
#
# USAGE
#   curl -L https://github.com/edouard-lopez/sshuttle-helper/raw/master/install.sh | sh
#
# AUTHOR
#   Édouard Lopez

# clone
echo "\033[0;34mCloning SSHuttle-helper...\033[0m"
hash git >/dev/null && /usr/bin/env git clone git://github.com/edouard-lopez/sshuttle-helper.git || {
  echo "git not installed"
  exit
}
initDir=/etc/init.d


# Check project has been cloned
if [ -d sshuttle-helper ]; then
  cd sshuttle-helper
else
  echo "SSHuttle-helper directory missing"
  exit 1
fi

# copy to System-V style init script directory
if [ ! -e "$initDir/proxy-ssh" ]; then
  echo "Adding init script..."
  sudo cp ./proxy-ssh /etc/init.d/
  sudo update-rc.d proxy-ssh defaults
else
  sudo cp -i ./proxy-ssh /etc/init.d/
fi

# add/update command to PATH directory
sudo ln -nfs "$initDir/proxy-ssh" /usr/local/sbin/
