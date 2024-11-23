# Nice string :
# Contient au moins 3 voyelles
# Une lettre qui apparaît deux fois à la suite dans une même ligne
# Ne contient jamais ab, cd, pq ou xy

def nice_string_count(strings)
  forbiden = %w[ab cd pq xy]


  strings.split.count do |string|
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


strings = File.read("input.txt")
p nice_string_count(strings)