# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

GROUPS = {
 "A" => ["Rusia", "Arabia Saudita", "Egipto", "Uruguay"],
 "B" => ["Portugal", "España", "Marruecos", "Irán"],
 "C" => ["Francia", "Australia", "Perú", "Dinamarca"],
 "D" => ["Argentina", "Islandia", "Croacia", "Nigeria"],
 "E" => ["Brasil", "Suiza", "Costa Rica", "Serbia"],
 "F" => ["Alemania", "México", "Suecia", "Corea del Sur"],
 "G" => ["Bélgica", "Panamá", "Túnez", "Inglaterra"],
 "H" => ["Polonia", "Senegal", "Colombia", "Japón"]
 }

STAGES = {
 "OCTAVOS" => {points: 2, num_teams: 16, step: "octavos"},
 "CUARTOS" => {points: 5, num_teams: 8, step: "cuartos"},
 "SEMIS" => {points: 7, num_teams: 4, step: "semis"},
 "CAMPEON" => {points: 10, num_teams: 1, step: "semis"},
 "SEGUNDO" => {points: 10, num_teams: 1, step: "semis"},
 "TERCERO" => {points: 10, num_teams: 1, step: "semis"},
 "CUARTO" => {points: 10, num_teams: 1, step: "semis"},
 "GOLEADOR" => {points: 1, num_teams: 1, step: "goleador"},
 "MASGOLEADO" => {points: 1, num_teams: 1, step: "goleador"}
}
GROUPS.keys.each{|group| (1..4).to_a.each{|n| STAGES["#{group}#{n}"] = {:points => 1, :num_teams => 1, :step => "posiciones"}}}

STAGES.each{|stage, det| Round.create!(name: stage, points: det[:points], :num_teams => det[:num_teams], :step => det[:step])}

GROUPS.each do |group, teams|
  teams.each{|team| Team.create!(name: team, group: group)}
end

GROUPS.keys.each do |group|
  group_teams = Team.where(group: group)
  group_teams.each_with_index do |team, i|
    id = team[:id]
    if i == 0
      Match.create!(:home_team_id => id, :away_team_id => group_teams[i + 1][:id])
      Match.create!(:home_team_id => id, :away_team_id => group_teams[i + 2][:id])
      Match.create!(:home_team_id => id, :away_team_id => group_teams[i + 3][:id])
    elsif i == 1
      Match.create!(:home_team_id => id, :away_team_id => group_teams[i + 1][:id])
      Match.create!(:home_team_id => id, :away_team_id => group_teams[i + 2][:id])
    elsif i == 2
      Match.create!(:home_team_id => id, :away_team_id => group_teams[i + 1][:id])
    end
  end
end
