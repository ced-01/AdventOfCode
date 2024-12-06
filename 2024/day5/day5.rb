input = File.readlines("input.txt").map(&:strip)

# Séparation des régles et des mises à jour
rules = input.select { |line| line.include?("|") }
updates = input.select { |line| line.include?(",") }

# Conversion des régles en tableau 2D d'entiers
rules_pairs = rules.map { |rule| rule.split("|").map(&:to_i) }

# Conversion des mises à jour en tableau 2D d'entiers
updates_lists = updates.map { |update| update.split(",").map(&:to_i) }

# Méthode pour vérifier si une mise à jour est valide
def valid_update?(update_list, rules_pairs)
  #Filtrer uniquement les règles 
  applicable_rules = rules_pairs.select { |x, y| update_list.include?(x) && update_list.include?(y) }

  # Vérifier si les règles sont respectées dans l'ordre donné
  applicable_rules.all? do |x, y|
    update_list.index(x) < update_list.index(y)
  end
end

# Fonction pour trier une mise à jour incorrecte
def sort_update(update_list, rules_pairs)
  # Créer un graphe de dépendances
  graph = {}
  update_list.each { |page| graph[page] = [] }

  rules_pairs.each do |x, y|
    if update_list.include?(x) && update_list.include?(y)
      graph[x] << y
    end
  end

  # Tri topologique pour déterminer l'ordre correct
  sorted = []
  visited = {}
  temp_mark = {}

  dfs = lambda do |node|
    raise "Cycle detected" if temp_mark[node]
    return if visited[node]

    temp_mark[node] = true
    graph[node].each { |neighbor| dfs.call(neighbor) }
    temp_mark.delete(node)

    visited[node] = true
    sorted.unshift(node)
  end

  update_list.each { |page| dfs.call(page) unless visited[page] }
  sorted
end

# Filtrer les mises à jour invalides et les trier correctement
incorrect_updates = updates_lists.reject { |update_list| valid_update?(update_list, rules_pairs) }

sorted_updates = incorrect_updates.map do |update_list|
  sort_update(update_list, rules_pairs)
end


# Filtrer les mises à jour valides
valid_updates = updates_lists.select { |update_list| valid_update?(update_list, rules_pairs) }

# Calculer la somme des pages du milieu des mises à jour valides
# ATTENTION partie 1 remplacer sorted_updates.sum par valid_updates.sum
middle_sum = sorted_updates.sum do |update|
middle_index = update.size / 2
update[middle_index]
end

# Afficher le résultat final
puts "Somme des pages du milieu des mises à jour valides : #{middle_sum}"