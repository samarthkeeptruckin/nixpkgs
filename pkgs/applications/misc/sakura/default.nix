{ stdenv, fetchurl, cmake, pkgconfig, gtk3, perl, vte, pcre2, glib , makeWrapper }:

stdenv.mkDerivation rec {
  pname = "sakura";
  version = "3.6.0";

  src = fetchurl {
    url = "https://launchpad.net/sakura/trunk/${version}/+download/${pname}-${version}.tar.bz2";
    sha256 = "1q463qm41ym7jb3kbzjz7b6x549vmgkb70arpkhsf86yxly1y5m1";
  };

  nativeBuildInputs = [ cmake perl pkgconfig ];

  buildInputs = [ makeWrapper gtk3 vte pcre2 glib ];

  # Wrapper sets path to gsettings-schemata so sakura knows where to find colorchooser, fontchooser ...
  postInstall = "wrapProgram $out/bin/sakura --suffix XDG_DATA_DIRS : ${gtk3}/share/gsettings-schemas/${gtk3.name}/";

  meta = with stdenv.lib; {
    description = "A terminal emulator based on GTK and VTE";
    homepage    = http://www.pleyades.net/david/projects/sakura;
    license     = licenses.gpl2;
    maintainers = with maintainers; [ astsmtl codyopel ];
    platforms   = platforms.linux;
    longDescription = ''
      sakura is a terminal emulator based on GTK and VTE. It's a terminal
      emulator with few dependencies, so you don't need a full GNOME desktop
      installed to have a decent terminal emulator. Current terminal emulators
      based on VTE are gnome-terminal, XFCE Terminal, TermIt and a small
      sample program included in the vte sources. The differences between
      sakura and the last one are that it uses a notebook to provide several
      terminals in one window and adds a contextual menu with some basic
      options. No more no less.
    '';
  };
}
