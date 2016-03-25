lines = File.readlines(ARGV[0])
line_count = lines.size
text = lines.join
total_characters = text.length
total_characters_nospaces = text.gsub(/\s+/, '').length
total_words = text.split.length
sentence_count = text.split(/\.|\?|!/).length
paragraph_count = text.split(/\n\n/).length


puts "#{paragraph_count} paragraphs"
puts "#{line_count} lines"
puts "#{total_characters} characters"
puts "#{total_characters_nospaces} characters (excluding spaces)"
puts "#{total_words} words"
puts "#{sentence_count} sentences"
puts "#{sentence_count / paragraph_count} sentences per paragraph (average)"
puts "#{total_words / sentence_count} words per sentence (average)"