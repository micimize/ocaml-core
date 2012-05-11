#!/usr/bin/env bash
set -e -u -o pipefail

source ../../build-common.sh

cat >$HERE/_oasis <<EOF
#AUTOGENERATED FILE; EDIT oasis.sh INSTEAD
OASISFormat:  0.3
OCamlVersion: >= 3.12
Name:         type_conv
Version:      3.0.5
Synopsis:     support library for preprocessor type conversions
Authors:      Martin Sandin,
              Markus Mottl,
              Jane Street Capital, LLC
License:      LGPL-2.1 with OCaml linking exception
LicenseFile:  LICENSE
Plugins:      StdFiles (0.3), DevFiles (0.3), META (0.3)
BuildTools:   ocamlbuild, camlp4o
XStdFilesAUTHORS: false
XStdFilesINSTALLFilename: INSTALL
XStdFilesREADME: false

Library pa_type_conv
  Path:               lib
  FindlibName:        type_conv
  Modules:            Pa_type_conv
  BuildDepends:       camlp4.quotations, camlp4.extend
  CompiledObject:     byte
  XMETAType:          syntax
  XMETARequires:      camlp4
  XMETADescription:   Syntax extension for type_conv

Document "type_conv"
  Title:                API reference for type_conv
  Type:                 ocamlbuild (0.3)
  BuildTools+:          ocamldoc
  XOCamlbuildPath:      lib
  XOCamlbuildLibraries: type_conv
EOF

make_tags $HERE/_tags <<EOF
<lib/pa_type_conv.ml>: syntax_camlp4o
EOF

cd $HERE
oasis setup
