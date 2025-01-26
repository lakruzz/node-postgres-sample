const { ApolloServer, gql } = require('apollo-server');
const { Pool } = require('pg');

// Define the type definitions
const typeDefs = gql`
  type Superhero {
    heroId: Int!
    heroName: String!
    realName: String!
    creationYear: Int
    city: City!
  }

  type City {
    cityId: Int!
    name: String!
  }

  type SuperPower {
    powerId: Int!
    name: String!
  }

  type SuperheroPower {
    heroId: Int!
    powerId: Int!
    level: String!
  }

  type Query {
    superhero(id: Int): Superhero
    superheroes: [Superhero!]!
    city(name: String): City
    cities: [City!]!
    superpowers: [SuperPower!]!
  }
`;

// Define resolvers
const resolvers = {
  Query: {
    superhero: async (_, { id }) => {
      console.log(`Received request for superhero with id: ${id}`);
      
      try {
        const result = await pool.query(
          'SELECT * FROM superhero WHERE hero_id = $1',
          [id]
        );
        
        if (result.rows.length === 0) {
          console.log(`No superhero found with id ${id}`);
          return null;
        }
        
        const superheroData = result.rows[0];
        console.log("Superhero data:", JSON.stringify(superheroData));
        
        // Ensure we're returning an object with the exact field names defined in the schema
        return {
          heroId: superheroData.hero_id,
          heroName: superheroData.hero_name,
          realName: superheroData.real_name,
          creationYear: superheroData.creation_year,
          city: {
            cityId: superheroData.city_id,
            name: superheroData.city_name
          }
        };
      } catch (error) {
        console.error('Error in superhero resolver:', error);
        throw new Error('Database error occurred while fetching superhero data.');
      }
    },
  },
};

// Create the Apollo server
const server = new ApolloServer({ typeDefs, resolvers });

// Start the server
server.listen().then(({ url }) => {
  console.log(`🚀  Server ready at ${url}`);
  console.log('Using DATABASE_URL:', process.env.DATABASE_URL);
}).catch(error => {
  console.error('Failed to start server:', error);
});

// Initialize database connection
console.log("Attempting to initialize database pool");
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});
console.log("Database pool initialized");

   // Test the connection
   pool.connect((err, client, release) => {
    if (err) {
      console.error('Error acquiring client', err.stack);
    } else {
      console.log('Successfully connected to database');
      client.query('SELECT NOW()', (err, result) => {
        release();
        if (err) {
          console.error('Error executing query', err.stack);
        } else {
          console.log('Database query executed successfully');
        }
      });
    }
  });