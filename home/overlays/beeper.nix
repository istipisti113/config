self: super:
{
  beeper = super.appimageTools.wrapType2 rec {
    pname = "beeper";
    version = "latest";  # or explicit version
    src = /home/istipisti113/Downloads/Beeper-4.2.269-x86_64.AppImage;
    meta = with super.lib; {
      description = "All your chats in one app.";
      homepage = "https://beeper.com";
      license = licenses.unfree;
      platforms = ["x86_64-linux"];
    };
  };
}

