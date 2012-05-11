#!/usr/bin/env bash
set -e -u -o -pipefail

source ../../build-common.sh

cat >$HERE/_oasis <<EOF
#AUTOGENERATED FILE; EDIT oasis.sh INSTEAD
OASISFormat:  0.3
OCamlVersion: >= 3.12
Name:         variantslib
Version:      $core_version
Synopsis:     OCaml variants as first class values.
Authors:      Jane street capital
Copyrights:   (C) 2009-2011 Jane Street Capital LLC
License:      LGPL-2.1 with OCaml linking exception
LicenseFile:  LICENSE
Plugins:      StdFiles (0.3), DevFiles (0.3), META (0.3)
XStdFilesREADME: false
XStdFilesAUTHORS: false
XStdFilesINSTALLFilename: INSTALL
BuildTools:   ocamlbuild

Library variantslib
  Path:               lib
  FindlibName:        variantslib
  Pack:               true
  Modules:            Variant
  XMETAType:          library

Library pa_variants_conv
  Path:               syntax
  Modules:            Pa_variants_conv
  FindlibParent:      variantslib
  FindlibName:        syntax
  BuildDepends:       camlp4.lib,
                      camlp4.quotations,
                      type_conv (>= 3.0.5)
  CompiledObject:     byte
  XMETAType:          syntax
  XMETARequires:      camlp4,type_conv,variantslib
  XMETADescription:   Syntax extension for Variantslib

Document "variantslib"
  Title:                API reference for variantslib
  Type:                 ocamlbuild (0.3)
  BuildTools+:          ocamldoc
  XOCamlbuildPath:      lib
  XOCamlbuildLibraries: variantslib
EOF

make_tags $HERE/_tags <<EOF
<syntax/*.ml{,i}>: syntax_camlp4o
EOF

cd $HERE
rm -f setup.ml
oasis setup
