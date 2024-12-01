x = 0..999
y = 0..999

grid = { [x, y] => "off"}

instructions = Files.readlines("input.txt", chomp: true)