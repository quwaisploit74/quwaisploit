class VideoFoldBannerInjector < BaseModule
  def initialize
    super
    @description = "Video banner injector with icon and fold gif"
    register_option("PATH_TO_VIDEO", "", true, "video file")
    register_option("GIF_PATH", "", true, "path to gif file video")
    register_option("ICON_PATH", "", true, "path to icon files")
    register_option("DURATION", "125", true, "video duration to cut")
    register_option("MIN_SIZE", "9.0", true, "minimum size of videos in MB")
    register_option("DELETE_VIDEO", true, true, "delete original videos file after edit")
    register_option("OUTPUT", "~/quwaisploit/users/injected_outputs", true, "output path work")
  end

  def run
    video    = @options["PATH_TO_VIDEO"][:value]
    gif      = @options["GIF_PATH"][:value]
    icon     = @options["ICON_PATH"][:value]
    duration = @options["DURATION"][:value].to_i
    min_size = @options["MIN_SIZE"][:value]
    d        = @options["DELETE_VIDEO"][:value]
    output   = @options["OUTPUT"][:value]

    puts "[*] deleting injected_outputs in users if there any..."
    system("rm -r ~/quwaisploit/users/injected_outputs")
    puts "[+] starting ffmpeg and vinjector..."
    if d == true
        system("python3 ~/quwaisploit/scripts/vinjector.py -p #{video} -f #{gif} -i #{icon} -d #{duration} -m #{min_size} -x -o #{output}")
    else
        system("pythone ~/quwaisploit/scripts/vinjector.py -p #{video} -f #{gif} -i #{icon} -d #{duration} -m #{min_size} -o #{output}")
    end
    puts "[*] job done"
  end
end
