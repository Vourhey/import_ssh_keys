{ stdenv
, bash
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  name = "import_ssh_keys_${version}";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "Vourhey";
    repo = "import_ssh_keys";
    rev = "127da0bb9d91dd5eacf6e27ac4888d3d2615a2ee";
    sha256 = "113wcc2r61p386h1rirrmydvpbnlxl1h824l2yw00i31kjgz7slf";
  };

  installPhase = ''
    mkdir -p $out/bin/
    cp  $src/import_ssh_keys $out/bin/
    chmod 755 $out/bin/import_ssh_keys
  '';
  dontbuild = true;
  dontUnpack = true;
  doCheck = false;

  postInstall = ''
    substituteInPlace out/bin/import_ssh_keys \
      --replace "/bin/bash" "${bash}/bin/bash"
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/Vourhey/import_ssh_keys;
    description = "little sctript from import_ssh_keys";
    platforms = platforms.linux;
    maintainers = with maintainers; [ spd vourhey ];
  };
}
