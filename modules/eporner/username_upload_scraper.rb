class UsernameUploadScraper < BaseModule
  def initialize
    super
    @description = "Scraper videos in eporner to get videos link after uploaded"
    
    register_option("USERNAME", "", true, "eporner profile username")
    register_option("BLACKLIST_PATH", "~/quwaisploit/tmp/blacklist.txt", true, "blacklist link path")
  end
  def run
    username       = @options["USERNAME"][:value]
    blacklist_path = @options["BLACKLIST_PATH"][:value]

    puts "[+] starting modules..."
    puts "[*] starting scrap modules..."
    system("python3 ~/quwaisploit/scripts/scrap.py #{username} #{blacklist_path}")
    puts "[*] job done"
  end
end
