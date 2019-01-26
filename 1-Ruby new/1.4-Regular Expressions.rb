/Perl|Python/
/P(erl|ython)/

/ab+c/
/ab*c/

if line =~ /Perl|Python/
  puts "pattern found: #{line}"
end

line.sub(/Perl/, 'Ruby') # replace first 'Perl' with 'Ruby'
line.gsub(/Perl/, 'Ruby') # replace every 'Perl' with 'Ruby'
