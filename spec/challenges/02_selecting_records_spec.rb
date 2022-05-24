require "database_connection"

RSpec.describe "Selecting Records" do
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

  it "selects all records" do
    db = setup_db

    # Fill out this line to query the animals table and get all the records
    # This is one you can Google if you don't know how
    result = db.run("SELECT id, name, species FROM animals;")
    # result = db.run("SELECT 1;")

    # Don't edit this
    expect(result.to_a).to eq([
      { "id" => "1", "name" => "Lola", "species" => "cat" },
      { "id" => "2", "name" => "Freyr", "species" => "cat" },
      { "id" => "3", "name" => "Milo", "species" => "dog" },
      { "id" => "4", "name" => "Fido", "species" => "dog" },
      { "id" => "5", "name" => "Kermit", "species" => "frog" }
    ])
  end

  it "selects all records sorted by ID descending" do
    db = setup_db

    # Fill out this line to query the animals table and get all the records
    # ordered by ID from highest to lowest
    result = db.run("SELECT id, name, species FROM animals ORDER BY id DESC;")
    #result = db.run("SELECT 1;")

    # Don't edit this
    expect(result.to_a).to eq([
      { "id" => "5", "name" => "Kermit", "species" => "frog" },
      { "id" => "4", "name" => "Fido", "species" => "dog" },
      { "id" => "3", "name" => "Milo", "species" => "dog" },
      { "id" => "2", "name" => "Freyr", "species" => "cat" },
      { "id" => "1", "name" => "Lola", "species" => "cat" },
    ])
  end

  it "selects only some records" do
    db = setup_db

    # Fill out this line to query the animals table and get only the dogs
    result = db.run("SELECT id, name, species FROM animals WHERE species LIKE '%dog%';")
    # result = db.run("SELECT 1;")

    # Don't edit this
    expect(result.to_a).to eq([
      { "id" => "3", "name" => "Milo", "species" => "dog" },
      { "id" => "4", "name" => "Fido", "species" => "dog" }
    ])
  end

  it "selects only some records using placeholders" do
    db = setup_db

    # Fill out this line to query the animals table and get only the dogs
    # Ensure you are using placeholders
    # sql = "SELECT 1;"
   # sql = "SELECT $1 as output FROM animals WHERE species LIKE '%dog%';"
    sql = "SELECT id, name, species FROM animals WHERE species LIKE '%dog%'=$1;"
    #sql = "SELECT id, name, species FROM animals WHERE species LIKE '%dog%';"
    #db.Exec(`UPDATE tags SET association_count = association_count - 1
    #WHERE id=$1;`, id
    fields = [1]

    # Don't edit this
    result = db.run(verify_placeholders(sql), fields)
    expect(result.to_a).to eq([
      { "id" => "3", "name" => "Milo", "species" => "dog" },
      { "id" => "4", "name" => "Fido", "species" => "dog" }
    ])
  end

  it "selects only some fields of some records" do
    db = setup_db

    # Fill out this line to query the animals table and get only the names of the dogs
    result = db.run(verify_placeholders("SELECT name FROM animals WHERE species LIKE '%dog%'=$1;"), [1])

    # Don't edit this
    expect(result.to_a).to eq([
      { "name" => "Milo" },
      { "name" => "Fido" }
    ])
  end

  it "selects a single record" do
    db = setup_db

    # Fill out this line to query the animals table and get just the record with the ID 3.
    result = db.run(verify_placeholders("SELECT id, name, species FROM animals WHERE id::TEXT LIKE '%3%'=$1;"), [1])

    # Don't edit this
    expect(result.to_a).to eq([
      { "id" => "3", "name" => "Milo", "species" => "dog" }
    ])
  end

  def verify_placeholders(sql)
    # Don't edit this
   fail "You didn't use placeholders." unless sql.include? "$1"
   return sql
 end
end
