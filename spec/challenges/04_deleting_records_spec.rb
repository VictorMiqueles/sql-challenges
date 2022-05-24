require "database_connection"

RSpec.describe "Deleting Records" do
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

  it "deletes a single record" do
    db = setup_db

    # Fill out this line to delete the record with the ID 3 from the animals table.
    db.run(verify_placeholders("DELETE FROM animals WHERE id::TEXT LIKE '%3%'=$1;"), [1])
    #db.run(verify_placeholders("SELECT 1=$1;"), [])

    # Don't edit this
    result = db.run("SELECT * FROM animals;")
    expect(result.to_a).to eq([
      { "id" => "1", "name" => "Lola", "species" => "cat" },
      { "id" => "2", "name" => "Freyr", "species" => "cat" },
      { "id" => "4", "name" => "Fido", "species" => "dog" },
      { "id" => "5", "name" => "Kermit", "species" => "frog" }
    ])
  end

  it "deletes records that match a criteria" do
    db = setup_db

    # Fill out this line to delete all the cats from the table
    db.run(verify_placeholders("DELETE FROM animals WHERE species LIKE '%cat%'=$1;"), [1])

    # Don't edit this
    result = db.run("SELECT * FROM animals;")
    expect(result.to_a).to eq([
      { "id" => "3", "name" => "Milo", "species" => "dog" },
      { "id" => "4", "name" => "Fido", "species" => "dog" },
      { "id" => "5", "name" => "Kermit", "species" => "frog" }
    ])
  end

  it "deletes all records" do
    db = setup_db

    # Fill out this line to delete all the records from the table
    db.run("DELETE FROM animals;")

    # Don't edit this
    result = db.run("SELECT * FROM animals;")
    expect(result.to_a).to eq([])
  end

  def verify_placeholders(sql)
     # Don't edit this
    fail "You didn't use placeholders." unless sql.include? "$1"
    return sql
  end
end
