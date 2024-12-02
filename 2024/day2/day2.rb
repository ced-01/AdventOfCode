reports = File.readlines("input.txt", chomp: true)
reports_num = reports.map { |report| report.split(/\s+/).map(&:to_i) }

# Any two adjacent levels in report differ by at least one and at most three. 
def valid_report_adjacent?(report, tolerance: 3)
  report.each_cons(2).all? { |a, b| (a - b).abs <= tolerance}
end

# The levels in report are either all increasing or all decreasing.
def strictly_increasing_or_decreasing?(report)
  is_increasing = report.each_cons(2).all? { |a, b| a < b }
  is_decreasing = report.each_cons(2).all? { |a, b| a > b }
  is_increasing || is_decreasing
end


# Partie 1 : Filtre les raports en fonction des deux régles définies => valid_reports

valid_reports_adjacents = reports_num.select { |report| valid_report_adjacent?(report) }
valid_reports = valid_reports_adjacents.select { |report| strictly_increasing_or_decreasing?(report) }

puts "Valids reports part_1 / Day2: #{valid_reports.size}"

# Part 2 : Ajout de la logique de suppression

def validate_with_removal(report, tolerance: 3)
  # Retourne vrai si le rapport est déjà valide
  return true if valid_report_adjacent?(report, tolerance: tolerance) && 
                 strictly_increasing_or_decreasing?(report)

  #Sinon, tente de supprimer un level à chaque position
  report.each_with_index do |_, index|
    modified_report =  report[0...index] + report[(index + 1)..-1]
    return true if valid_report_adjacent?(modified_report, tolerance: tolerance) &&
                   strictly_increasing_or_decreasing?(modified_report)
  end
  # Aucun ajustement ne fonctionne
  false
end

valid_reports_part2 = reports_num.select { |report| validate_with_removal(report) }


puts "Valids reports part_2 / Day2 : #{valid_reports_part2.size}"