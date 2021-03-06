require_relative 'whitelist'

  # see http://rubular.com/r/mrNTXICP9s
  # names_regex = /[A-Z][a-zA-Z]{2,25}(\s|\s[A-Z]\.\s)[A-Z][a-zA-Z]{3,25}/
  name_surname_regex = /[A-Z][a-zA-Z]{2,25}\s[A-Z][a-zA-Z]{2,25}/

  def whitelisted? full_name
    @whitelist ||= Whitelist.new
    @whitelist.words.include?(full_name.split(/\s/).first.downcase) ||
    @whitelist.words.include?(full_name.split(/\s/).last.downcase)
  end

  def inizials_of(full_name)
    words = full_name.split(/\s/)
    initials = words.map { |w| "#{w[0]}." }
    return initials[0] + initials[1]
  end

  content = File.open('input.txt', 'rb') { |file| file.read }

  name_surname_groups = content.scan(name_surname_regex)

  name_surname_groups.each do |full_name|
    content.gsub!(full_name, inizials_of(full_name))
  end

  puts content