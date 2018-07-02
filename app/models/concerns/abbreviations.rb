module Abbreviations
  include ActiveSupport::Concern

  def abbr
  
   {"Rusia" => "RUS", "Arabia Saudita" => "ARA", "Egipto" => "EGI", "Uruguay" => "URU",
   "Portugal" => "POR", "España" => "ESP", "Marruecos" => "MAR", "Irán" => "IRN",
   "Francia" => "FRA", "Australia" => "AUS", "Perú" => "PER", "Dinamarca" => "DIN",
   "Argentina" => "ARG", "Islandia" => "ISL", "Croacia" => "CRO", "Nigeria" => "NIG",
   "Brasil" => "BRA", "Suiza" => "SUI", "Costa Rica" => "CRC", "Serbia" => "SRB",
   "Alemania" => "ALE", "México" => "MEX", "Suecia" => "SUE", "Corea del Sur" => "COR",
   "Bélgica" => "BEL", "Panamá" => "PAN", "Túnez" => "TUN", "Inglaterra" => "ING",
   "Polonia" => "POL", "Senegal" => "SEN", "Colombia" => "COL", "Japón" => "JPN", "Empate" => "E"}
  end
end
