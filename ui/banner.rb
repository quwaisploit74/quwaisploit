def banner_show
    day = Time.now.strftime("%A") # Mendapatkan nama hari (Monday, Tuesday, dll)
    
    case day
    when "Monday"
        puts "<banner hari senin>"
    when "Tuesday"
        puts "<banner hari selasa>"
    when "Wednesday"
        puts "<banner hari rabu>"
    when "Thursday"
        puts "<banner hari kamis>"
    when "Friday"
        puts "<banner hari jum'at>"
    when "Saturday"
        puts "<banner hari sabtu>"
    when "Sunday"
        puts "<banner hari minggu>"
    end
end
