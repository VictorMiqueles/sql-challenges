require "database_connection"

RSpec.describe "Executing SQL" do
  it "connects successfully" do
    # This connects to the databse `sql_challenges` on your local computer
    # If it fails, your machine probably isn't set up right yet.
    # Consult the README, then your coach.
    db = DatabaseConnection.new("localhost", "sql_challenges")

    # db.run runs a query in a language called SQL (structed query language)
    # This query just replies with "Hello, world!"
    result = db.run("SELECT 'Hello, world!' as output;")

    # We can get the results back from the database and assert
    expect(result.first["output"]).to eq("Hello, world!")
  end

  it "uses placeholders" do
    db = DatabaseConnection.new("localhost", "sql_challenges")

    # We can also use placeholders to pass data into the SQL.
    # Edit this line to make the test pass.
    result = db.run("SELECT $1 as output;", ["Hello, engineer!"])

    # Don't edit this line!
    expect(result.first["output"]).to eq("Hello, engineer!")
  end
end
