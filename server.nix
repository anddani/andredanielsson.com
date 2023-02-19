{ mkDerivation, base, servant, servant-server, servant-elm
, transformers, wai, wai-extra, warp, lib }:
mkDerivation {
  pname = "website";
  version = "1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  license = lib.licenses.mit.spdxId;
  executableHaskellDepends = [
    base
    servant
    servant-elm
    servant-server
    transformers
    wai
    wai-extra
    warp
  ];
}
