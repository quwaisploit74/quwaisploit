require 'readline'
require_relative 'ui/banner'
require_relative 'ui/version'
class BaseModule
  attr_accessor :options, :description
  def initialize
    @options = {}
    @description = "No description provide.."
  end
  def register_option(key, default, required, description)
    @options[key.to_s.upcase] = { value: default, required: required, desc: description }
  end
  def run
    puts "[-] Error: Method 'run' not definited"
  end
end
class QuwaisFramework
  MODULE_DIR = "modules"
  def initialize
    Dir.mkdir(MODULE_DIR) unless Dir.exist?(MODULE_DIR)
    @current_mod_instance = nil
    @current_mod_name = nil
    @running = true
  end
  def start
    banner_show
    showversion
    puts "\033[1;37m[\033[1;31m-\033[1;37m] \033[1;31mQuwaisploit core by Muhammad Quwais Saputra\033[0;37m"
    while @running
      prompt = @current_mod_name ? "\033[1;31mQ\033[1;37muwaisploit(\e[31m#{@current_mod_name}\033[1;37m)$> \033[0;32m" : "\033[1;31mQ\033[1;37muwaisploit$> \033[0;32m"
      input = Readline.readline(prompt, true)
      printf("\033[0;37m")
      next if input.nil? || input.strip.empty?
      cmd, *args = input.split(' ')
      case cmd
      when 'help', '?' then show_help
      when 'show' then handle_show(args[0])
      when 'use'  then load_module(args[0])
      when 'set'  then set_val(args[0], args[1..-1].join(' ')) # Support spasi di value
      when 'run', 'exploit' then execute_mod
      when 'back' then go_back
      when 'clear' then system("clear")
      when 'exit', 'quit' then @running = false
      else puts "[-] Unknown command: #{cmd}"
      end
    end
  end
  private
  def show_help
    puts "\nQuwaisploit Commands"
    puts "  show modules          List All Availabe Modules"
    puts "  use <path>            Select modules"
    puts "  show options          show options of the modules"
    puts "  set <k> <v>           set the value of the key modules"
    puts "  run                   run the modul"
    puts "  clear                 clear the terminal"
    puts "  back                  back the modules\n\n"
  end
  def handle_show(sub_cmd)
    sub_cmd == 'modules' ? list_modules : show_options
  end
  def list_modules
    puts "\nModules"
    puts "============================"
    printf "  %-40s %s\n", "Name", "Description"
    printf "  %-40s %s\n", "----", "-----------"
    Dir.glob(File.join(MODULE_DIR, "**", "*.rb")).each do |f|
      begin
        display_path = f.sub("./", "").sub("#{MODULE_DIR}/", "").sub(".rb", "")
        load f
        file_name = File.basename(f, ".rb")
        class_name = file_name.split('_').map(&:capitalize).join
        instance = Object.const_get(class_name).new
        printf "  %-40s %s\n", display_path, instance.description
      rescue => e; next; end
    end
    puts ""
  end
  def load_module(name)
    clean_input = name.sub(/^#{MODULE_DIR}\//, "").sub(/\.rb$/, "")
    full_path = "./#{MODULE_DIR}/#{clean_input}.rb"
    if File.exist?(full_path)
      begin
        load full_path
        file_name = File.basename(full_path, ".rb")
        class_name = file_name.split('_').map(&:capitalize).join
        @current_mod_instance = Object.const_get(class_name).new
        @current_mod_name = clean_input
        puts "[+] Loaded: \033[1;31m#{clean_input}"
      rescue => e
        puts "[-] Error: #{e.message}"
      end
    else
      puts "[-] Modul Not Found: #{clean_input}"
    end
  end
  def show_options
    return puts "[-] Pilih modul dahulu." unless @current_mod_instance
    puts "\nModule Options (#{@current_mod_name}):\n"
    printf "  %-15s %-25s %-10s %s\n", "Name", "Setting", "Required", "Description"
    printf "  %-15s %-25s %-10s %s\n", "----", "-------", "--------", "-----------"
    @current_mod_instance.options.each do |k, v|
      printf "  %-15s %-25s %-10s %s\n", k, v[:value], v[:required], v[:desc]
    end
    puts ""
  end
  def set_val(key, val)
    return puts "[-] Pilih modul dahulu." unless @current_mod_instance
    if key && @current_mod_instance.options.key?(key.upcase)
      @current_mod_instance.options[key.upcase][:value] = val
      puts "#{key.upcase} => #{val}"
    else
      puts "[-] Variabel not found."
    end
  end
  def go_back
    @current_mod_instance = nil
    @current_mod_name = nil
  end
  def execute_mod
    return puts "[-] Modules not selected" unless @current_mod_instance
    @current_mod_instance.options.each do |k, v|
      if v[:required] && (v[:value].nil? || v[:value].to_s.strip.empty?)
        puts "[-] Error: Option #{k} must be setted first"
        return
      end
    end
    puts "\033[31m[$] \033[37mRunning the modules"
    begin
      @current_mod_instance.run
    rescue => e
      puts "[-] Runtime Error: #{e.message}"
      puts e.backtrace.first # Menunjukkan baris kode mana yang error
    end
  end
end
QuwaisFramework.new.start
