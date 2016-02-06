xt, yt, xp, yp = ARGV

if xt==xp && yt==yp
  puts 'Точка найдена!'
elsif xt!=xp || yt!=yp
  puts 'Близко, но нет'
    if xt==xp && yt!=yp
      puts 'х координата верна, y нет'
    elsif xt!=xp && yt==yp
      puts 'y координата верна, x нет'
    end
end
