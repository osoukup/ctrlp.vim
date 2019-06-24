#!/bin/bash
# RPM test script

source /etc/os-release

SOURCE=$(basename $(find ~/rpmbuild/RPMS/noarch/*))

if [[ ! -e ~/rpmbuild/RPMS/noarch/$SOURCE ]]; then
    echo "ERROR: no RPM found";
    exit 1;
fi

mkdir vagrant
cp Vagrantfile vagrant/Vagrantfile
cp ~/rpmbuild/RPMS/noarch/$SOURCE vagrant
sed -i "s/[[:digit:]][[:digit:]]-cloud-base/$VERSION_ID-cloud-base/g" vagrant/Vagrantfile
sed -i "s/INSTALL/rpm -ivh \/vagrant\/*.rpm/g" vagrant/Vagrantfile

pushd vagrant
vagrant up
vagrant ssh
vagrant destroy -f
popd

rm -r vagrant
