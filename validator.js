const validateUsers = (req, res, next) => {
  const { firstname, lastname, email, city, language } = req.body;
  const error = [];
  const emailRegex = /[a-z0-9._]+@[a-z0-9-]+\.[a-z]{2,3}/;

  if (firstname == null) {
    error.push({ field: "firstname", message: "This field is required" });
  } else if (firstname >= 255) {
    error.push({
      field: "firstname",
      message: "Should contain less than 255 characters",
    });
  }
  if (lastname == null) {
    error.push({ field: "lastname", message: "This field is required" });
  }
  if (email == null) {
    error.push({ field: "email", message: "This field is required" });
  }
  if (!emailRegex.test(email)) {
    error.push({ field: "email", message: "Invalid email" });
  }
  if (city == null) {
    error.push({ field: "city", message: "This field is required" });
  }
  if (language == null) {
    error.push({ field: "language", message: "This field is required" });
  }
  if (error.length) {
    res.status(422).json({ validationError: error });
  } else {
    next();
  }
};

module.exports = validateUsers;
