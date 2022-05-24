require "database_connection"

RSpec.describe "Creating Tables" do
  def setup_db
    db = DatabaseConnection.new("localhost", "sql_challenges")
    db.run("DROP TABLE IF EXISTS hats;")
    return db
  end

  it "creates a table with an ID and a single field" do
    db = setup_db

    # Fill out this line to create a table with these fields:
    #   id (should auto-increment when inserts are made)
    #   name
    db.run("CREATE TABLE hats (
      id SERIAL PRIMARY KEY,
      name TEXT
    );")

    # Don't edit this
    db.run("INSERT INTO hats (name) VALUES ($1);", ["top hat"])
    db.run("INSERT INTO hats (name) VALUES ($1);", ["baseball cap"])
    db.run("INSERT INTO hats (name) VALUES ($1);", ["fedora"])
    result = db.run("SELECT * FROM hats;")
    expect(result.to_a).to eq([
      { "id" => "1", "name" => "top hat" },
      { "id" => "2", "name" => "baseball cap" },
      { "id" => "3", "name" => "fedora" }
    ])
  end

  it "creates a table with multiple fields" do
    db = setup_db

    # Fill out this line to create a table with these fields:
    #   id (should auto-increment when inserts are made)
    #   name
    #   price
    #   description
    #   telephone number
    #   is_sold
    # Think carefully about what the types should be!
    db.run("CREATE TABLE hats (
      id SERIAL PRIMARY KEY,
      name TEXT,
      price TEXT,
      description TEXT,
      telephone_number TEXT,
      is_sold BOOLEAN
    );")

    # Don't edit this
    db.run("INSERT INTO hats (name, price, description, telephone_number, is_sold) VALUES ($1, $2, $3, $4, $5);", ["top hat", "10.00", "A top hat", "07800000000", "false"])
    db.run("INSERT INTO hats (name, price, description, telephone_number, is_sold) VALUES ($1, $2, $3, $4, $5);", ["baseball cap", "5.00", "A baseball cap", "07800000001", "false"])
    db.run("INSERT INTO hats (name, price, description, telephone_number, is_sold) VALUES ($1, $2, $3, $4, $5);", ["fedora", "15.00", "A fedora", "07800000002", "true"])
    result = db.run("SELECT * FROM hats WHERE is_sold = true;")
    expect(result.to_a).to eq([
      { "id" => "3", "name" => "fedora", "price" => "15.00", "description" => "A fedora", "telephone_number" => "07800000002", "is_sold" => "t" }
    ])
    result = db.run("SELECT * FROM hats WHERE is_sold = false;")
    expect(result.to_a).to eq([
      { "id" => "1", "name" => "top hat", "price" => "10.00", "description" => "A top hat", "telephone_number" => "07800000000", "is_sold" => "f" },
      { "id" => "2", "name" => "baseball cap", "price" => "5.00", "description" => "A baseball cap", "telephone_number" => "07800000001", "is_sold" => "f" }
    ])
  end

  def verify_placeholders(sql)
     # Don't edit this
    fail "You didn't use placeholders." unless sql.include? "$1"
    fail "You didn't use placeholders." unless sql.include? "$2"
    return sql
  end
end
