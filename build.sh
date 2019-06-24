#!/bin/bash
# RPM build script

if ! rpmlint -i vim-ctrlp.spec; then
    echo "ERROR: invalid spec file";
    exit 1;
fi

rpmdev-setuptree

cp vim-ctrlp.spec ~/rpmbuild/SPECS/

# local or remote sources
if [[ $1 = "--local" ]]; then
    VERSION=`grep Version vim-ctrlp.spec | cut -d: -f2 | xargs`
    pushd ctrlp.vim/
    tar -czf vim-ctrlp-$VERSION.tar.gz *
    mv vim-ctrlp-$VERSION.tar.gz ~/rpmbuild/SOURCES/
    cp LICENSE ~/rpmbuild/SOURCES/
    popd
    cp vim-ctrlp.metainfo.xml ~/rpmbuild/SOURCES/
else
    spectool -g -R ~/rpmbuild/SPECS/vim-ctrlp.spec
fi

rpmbuild --quiet -ba ~/rpmbuild/SPECS/vim-ctrlp.spec
rpmlint -i ~/rpmbuild/RPMS/noarch/*
