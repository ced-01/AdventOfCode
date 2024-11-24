# Nice string :
# Contient au moins 3 voyelles
# Une lettre qui apparaît deux fois à la suite dans une même ligne
# Ne contient jamais ab, cd, pq ou xy

def nice_string_count(strings)
  forbiden = %w[ab cd pq xy]


  strings.count do |string|
    # Vérifie les 3 voyelles
    vowels_count = string.scan(/[a e i o u]/).size

    # Verifie une lettre doublée
    has_double = string =~ /([a-z])\1/

    # Vérifie les chaînes interdites
    has_forbidden =  forbiden.any? { |forb| string.include?(forb) }

    # Nice strings 
    vowels_count >= 3 && has_double && !has_forbidden
  end
end

def advanced_nice_strings_count(strings)
  strings.count do |string|
    # Vérifie une paire de deux lettres répétée non chevauchante
    has_repeated_pair = string =~ /([a-z]{2}).*\1/
    
    # Vérifie une lettre répétée avec une autre lettre entre les deux
    has_split_repeat = string =~ /([a-z]).\1/
    
    # Les deux conditions doivent être remplies
    has_repeated_pair && has_split_repeat
  end
end

strings = File.readlines("input.txt", chomp: true)
puts nice_string_count(strings)
puts advanced_nice_strings_count(strings)
