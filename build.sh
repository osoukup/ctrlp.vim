#!/bin/bash
# RPM build script

if ! rpmlint -i vim-ctrlp.spec; then
    echo "ERROR: invalid spec file";
    exit 1;
fi

VERSION=`grep Version vim-ctrlp.spec | cut -d: -f2 | xargs`

rpmdev-setuptree
pushd ctrlp.vim/
tar -czf vim-ctrlp-$VERSION.tar.gz *
popd
cp ctrlp.vim/vim-ctrlp-$VERSION.tar.gz ~/rpmbuild/SOURCES/
rm ctrlp.vim/vim-ctrlp-$VERSION.tar.gz
cp vim-ctrlp.metainfo.xml ~/rpmbuild/SOURCES/
cp vim-ctrlp.spec ~/rpmbuild/SPECS/

rpmbuild --quiet -ba ~/rpmbuild/SPECS/vim-ctrlp.spec
rpmlint -i ~/rpmbuild/RPMS/noarch/*
