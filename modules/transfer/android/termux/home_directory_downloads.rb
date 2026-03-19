# scp -P 8022 -r u0_a221@192.168.47.212:/data/data/com.termux/files/home/quwaisploit ~/quwaisploit
class HomeDirectoryDownloads < BaseModule
  def initialize
    super
    @description = "download directory from termux home dir into your desktop"
    
    register_option("TERMUX_USER", "", true, "termux user ssh name")
    register_option("TERMUX_IP", "", true, "termux user ip")
    register_option("PORT", "8022", true, "ssh open port")
    register_option("DIR", "", true, "directory name in home to downloads. you dont need to use /data/data/com.termux")
    register_option("INTO", "~/quwaisploit/users/results", true, "send the directory into where in your desktop")
  end
  def run
    termux_user    = @options["TERMUX_USER"][:value]
    termux_ip      = @options["TERMUX_IP"][:value]
    port           = @options["PORT"][:value]
    xdir           = @options["DIR"][:value]
    into           = @options["INTO"][:value]

    puts "[+] creating/jumping the #{into} directory..."
    system("mkdir #{into}")
    puts "[+] getting connection on #{termux_user}@#{termux_ip}"
    system("scp -P #{port} -r #{termux_user}@#{termux_ip}:/data/data/com.termux/files/home/#{xdir} #{into}")
    puts "[*] transfer done"
  end
end
