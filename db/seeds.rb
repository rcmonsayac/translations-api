require 'csv'

CSV.foreach("language-codes.csv", headers: true) do |row|
  Language.find_or_create_by(code: row["code"], country: row["country"])
end