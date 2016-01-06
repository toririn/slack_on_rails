require 'csv'

csv = CSV.read('db/fixtures/development/sample.csv')

csv.each do |sample|
  Collect.seed do |s|
    s.id = sample[0]
    s.name = sample[1]
    s.text = sample[2]
    s.created_at = sample[3]
    s.updated_at = sample[4]
  end
end
