# Lecture des données et traitement initial
equations = File.readlines("input.txt", chomp: true).map do |equation|
  equation.delete(":").split.map(&:to_i)
end

# Séparation des résultats cibles et des nombres
equations_results = []
equations_numbers = []

equations.each do |equation|
  equations_results << equation.shift
  equations_numbers << equation
end

# Initialisation des variables
total_calibration = 0
valid_equations = []

# Liste des opérateurs possibles
operators = [:+, :*, :concat]

# Méthode pour appliquer une opération entre deux nombres
def apply_operator(num1, num2, operator)
  case operator
  when :+
    num1 + num2
  when :*
    num1 * num2
  when :concat
    (num1.to_s + num2.to_s).to_i
  end
end

# Fonction pour tester une combinaison d'opérateurs
def evaluate_combination(numbers, operators_combination)
  result = numbers.first
  numbers[1..].each_with_index do |num, index|
    result = apply_operator(result, num, operators_combination[index])
  end
  result
end

# Traitement de chaque équation
equations_numbers.each_with_index do |numbers, index|
  target = equations_results[index]
  num_operators = numbers.size - 1

  # Générer toutes les combinaisons possibles d'opérateurs
  operators_combinations = operators.repeated_permutation(num_operators).to_a

  # Tester chaque combinaison d'opérateurs
  operators_combinations.each do |combination|
    if evaluate_combination(numbers, combination) == target
      total_calibration += target
      valid_equations << { index: index, combination: combination, result: target }
      break
    end
  end
end

# Affichage des résultats
puts "Total Calibration Result: #{total_calibration}"
puts "Valid Equations:"
valid_equations.each do |eq|
  puts "Equation ##{eq[:index] + 1} => Result: #{eq[:result]}, Combination: #{eq[:combination]}"
end
