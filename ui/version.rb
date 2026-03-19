module Version
    AUTHOR   = "Muhammad Quwais Saputra"
    MADE     = "01-02-2026"
    VERSION  = "0.0.5" #1 codename: Program
    CODENAME = "PROGRAM"
end

def showversion
    puts "\033[31m+\033[37m---=[ \033[31mQuwaisploit \033[34m#{Version::VERSION} - \033[32m#{Version::CODENAME}\t\033[37m]=--\033[31m+"
    puts "\033[31m+\033[37m---=[ Created in \033[36m#{Version::MADE}\t\t\033[37m]=--\033[31m+"
    puts "\033[31m+\033[37m---=[ By \033[36m#{Version::AUTHOR}\t\033[37m]=--\033[31m+"
end
