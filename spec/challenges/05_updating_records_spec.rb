require "database_connection"

RSpec.describe "Updating Records" do
  def setup_db
    db = DatabaseConnection.new("localhost", "sql_challenges")
    db.run("DROP TABLE IF EXISTS animals;")
    db.run("CREATE TABLE animals (
      id SERIAL PRIMARY KEY,
      name TEXT,
      species TEXT
    );")
    db.run("INSERT INTO animals (name, species) VALUES ($1, $2);", ["Lola", "cat"])
    db.run("INSERT INTO animals (name, species) VALUES ($1, $2);", ["Freyr", "cat"])
    db.run("INSERT INTO animals (name, species) VALUES ($1, $2);", ["Milo", "dog"])
    db.run("INSERT INTO animals (name, species) VALUES ($1, $2);", ["Fido", "dog"])
    db.run("INSERT INTO animals (name, species) VALUES ($1, $2);", ["Kermit", "frog"])
    return db
  end

  it "updates a single record" do
    db = setup_db

    # Fill out this line to update the name of the record with the ID 2 to have the name "Felix"
    db.run(verify_two_placeholders("UPDATE animals SET name = $1 WHERE id::TEXT LIKE $2;"), ['Felix', 2])

    # Don't edit this
    result = db.run("SELECT * FROM animals ORDER BY id ASC;")
    expect(result.to_a).to eq([
      { "id" => "1", "name" => "Lola", "species" => "cat" },
      { "id" => "2", "name" => "Felix", "species" => "cat" },
      { "id" => "3", "name" => "Milo", "species" => "dog" },
      { "id" => "4", "name" => "Fido", "species" => "dog" },
      { "id" => "5", "name" => "Kermit", "species" => "frog" }
    ])
  end

  it "updates records that match a criteria" do
    db = setup_db

    # Fill out this line to update all the cats to have the name "Felix"
    db.run(verify_two_placeholders("UPDATE animals SET name = $1 WHERE species = $2;"), ['Felix', 'cat'])

    # Don't edit this
    result = db.run("SELECT * FROM animals ORDER BY id ASC;")
    expect(result.to_a).to eq([
      { "id" => "1", "name" => "Felix", "species" => "cat" },
      { "id" => "2", "name" => "Felix", "species" => "cat" },
      { "id" => "3", "name" => "Milo", "species" => "dog" },
      { "id" => "4", "name" => "Fido", "species" => "dog" },
      { "id" => "5", "name" => "Kermit", "species" => "frog" }
    ])
  end

  it "updates all records" do
    db = setup_db

    # Fill out this line to update all the records to have the name "Kermit"
    db.run(verify_one_placeholder("UPDATE animals SET name = $1;"), ['Kermit'])

    # Don't edit this
    result = db.run("SELECT * FROM animals ORDER BY id ASC;")
    expect(result.to_a).to eq([
      { "id" => "1", "name" => "Kermit", "species" => "cat" },
      { "id" => "2", "name" => "Kermit", "species" => "cat" },
      { "id" => "3", "name" => "Kermit", "species" => "dog" },
      { "id" => "4", "name" => "Kermit", "species" => "dog" },
      { "id" => "5", "name" => "Kermit", "species" => "frog" }
    ])
  end

  def verify_two_placeholders(sql)
     # Don't edit this
    fail "You didn't use placeholders." unless sql.include? "$1"
    fail "You didn't use placeholders." unless sql.include? "$2"
    return sql
  end

  def verify_one_placeholder(sql)
     # Don't edit this
    fail "You didn't use placeholders." unless sql.include? "$1"
    return sql
  end
end
