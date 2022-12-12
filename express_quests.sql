const database = require("./database");

const users = [
{
  id: 1,
  firstname: 'John',
  lastname: 'Doe',
  email: 'john.doe@example.com',
  city: 'Paris',
  language: 'English'
},
{
  id: 2,
  firstname: 'Valeriy',
  lastname: 'Appius',
  email: 'valeriy.appius@example.com',
  city: 'Moscow',
  language: 'Russian'
},
{
  id: 3,
  firstname: 'Ralf',
  lastname: 'Geronimo',
  email: 'ralf.geronimo@example.com',
  city: 'New York',
  language: 'Italian'
},
{
  id: 4,
  firstname: 'Maria',
  lastname: 'Iskandar',
  email: 'maria.iskandar@example.com',
  city: 'New York',
  language: 'German'
},
{
  id: 5,
  firstname: 'Jane',
  lastname: 'Doe',
  email: 'jane.doe@example.com',
  city: 'London',
  language: 'English'
},
{
  id: 6,
  firstname: 'Johanna',
  lastname: 'Martino',
  email: 'johanna.martino@example.com',
  city: 'Milan',
  language: 'Spanish'
}
];

const getUsers = (req, res) => {
  database
  .query("SELECT * FROM users")
  .then(([users]) => {
    res.json(users)
  })
  .catch((err) => {
    console.error(err);
    res.status(500).send("Error")
  });
};

const getUserById = (req, res) => {
    const id = parseInt(req.params.id);

    database
    .query("SELECT * FROM users WHERE id = ?", [id])
    .then(([users]) => {
        if(users[0] != null){
            res.json(users[0]);
        } else {
            res.status(404).send("Not found");
        }
    }
    )
    .catch((err) =>{
        console.error(err)
        res.status(500).send("Error retrieving database");
    })

};

const getUser = (req, res) => {
    database
      .query("SELECT * FROM users")
      .then(([users]) => {
        res.json(users);
      })
      .catch((err) => {
        console.error(err);
        res.status(500).send("Error retrieving data from database");
      });
  }

  const postUsers = (req, res) => {
    const { firstname, lastname, email, city, language } = req.body;
    database
    .query(
      "INSERT INTO users(firstname, lastname, email, city, language) VALUES (?, ?, ?, ?, ?)",
      [firstname, lastname, email, city, language]
    )
    .then(([result]) =>{
      res.location(`/api/users/${result.insertId}`).sendStatus(201);
    })
    .catch((err) => {
      console.error(err);
      res.status(500).send("Error saving users");
    })
  }

  const updateUsers = (req, res) => {
    const id = parseInt(req.params.id);
    const { firstname, lastname, email, city, language } = req.body;

    database
    .query(
      "UPDATE users SET firstname = ?, lastname = ?, email = ?, city = ?, language = ? WHERE id = ?",
      [firstname, lastname, email, city, language, id]
    )
    .then(([result]) => {
      if(result.affectedRows === 0){
        res.status(404).send("Not found")
      } else {
        res.sendStatus(204);
      }
    })
    .catch((err) => {
      console.error(err);
      res.status(500).send("Error change users")
    })
  }

  const deleteUsers = (req, res) => {
    const id = parseInt(req.params.id);

    database
    .query("DELETE FROM users WHERE id = ?", [id])
    .then(([result]) => {
      if(result.affectedRows === 0) {
        res.status(404).send("Not found");
      } else {
        res.sendStatus(204)
      }
    })
    .catch((err) => {
      console.error(err);
      res.status(500).send("Error deleting the user")
    })
  }

module.exports = {
    getUsers,
    getUserById,
    getUser,
    postUsers,
    updateUsers,
    deleteUsers,
};