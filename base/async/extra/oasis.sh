#!/usr/bin/env bash
set -e -u -o pipefail

source ../../../build-common.sh

cat >$HERE/_oasis <<EOF
#AUTOGENERATED FILE; EDIT oasis.sh INSTEAD

OASISFormat:  0.3
OCamlVersion: >= 3.12
Name:         async_extra
Version:      $core_version
Synopsis:     Jane Street Capital's asynchronous execution library (extra)
Authors:      Jane street capital
Copyrights:   (C) 2008-2011 Jane Street Capital LLC
License:      LGPL-2.1 with OCaml linking exception
LicenseFile:  LICENSE
Plugins:      StdFiles (0.3), DevFiles (0.3), META (0.3)
BuildTools:   ocamlbuild
Description:  Jane Street Capital's asynchronous execution library
FindlibVersion: >= 1.2.7
XStdFilesAUTHORS: false
XStdFilesINSTALLFilename: INSTALL
XStdFilesREADME: false

Library async_extra
  Path:               lib
  FindlibName:        async_extra
  Pack:               true
  Modules:            $(list_mods "$HERE/lib")
  BuildDepends:       sexplib.syntax,
                      sexplib,
                      fieldslib.syntax,
                      fieldslib,
                      bin_prot,
                      bin_prot.syntax,
                      pa_ounit,
                      pa_pipebang,
                      core,
                      async_core,
                      async_unix,
                      threads

EOF

make_tags "$HERE/_tags" <<EOF
<lib/*.ml{,i}>: syntax_camlp4o
EOF

cd $HERE
rm -f setup.ml
oasis setup
