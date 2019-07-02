CountrySelect::FORMATS[:with_alpha2] = lambda do |country|
  name = country.alpha2 == "TW" ? "Taiwan" : country.name
  "#{name} (#{country.alpha2})"
end