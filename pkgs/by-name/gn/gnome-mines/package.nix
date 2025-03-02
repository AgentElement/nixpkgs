{
  lib,
  stdenv,
  fetchurl,
  meson,
  ninja,
  vala,
  pkg-config,
  gnome,
  adwaita-icon-theme,
  gtk3,
  wrapGAppsHook3,
  librsvg,
  gettext,
  itstool,
  python3,
  libxml2,
  libgnome-games-support,
  libgee,
  desktop-file-utils,
}:

stdenv.mkDerivation rec {
  pname = "gnome-mines";
  version = "48.alpha.2";

  src = fetchurl {
    url = "mirror://gnome/sources/gnome-mines/${lib.versions.major version}/gnome-mines-${version}.tar.xz";
    hash = "sha256-ABxs04IprPiNN3irQI/9sRkRoWk7cfV0WcFsbFsK1UM=";
  };

  nativeBuildInputs = [
    meson
    ninja
    vala
    pkg-config
    gettext
    itstool
    python3
    libxml2
    wrapGAppsHook3
    desktop-file-utils
  ];

  buildInputs = [
    gtk3
    librsvg
    adwaita-icon-theme
    libgnome-games-support
    libgee
  ];

  postPatch = ''
    chmod +x build-aux/meson_post_install.py
    patchShebangs build-aux/meson_post_install.py
  '';

  passthru = {
    updateScript = gnome.updateScript { packageName = "gnome-mines"; };
  };

  meta = with lib; {
    homepage = "https://gitlab.gnome.org/GNOME/gnome-mines";
    description = "Clear hidden mines from a minefield";
    mainProgram = "gnome-mines";
    maintainers = teams.gnome.members;
    license = licenses.gpl3;
    platforms = platforms.unix;
  };
}
