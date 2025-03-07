const express = require("express");
const cors = require("cors");
const { faker } = require("@faker-js/faker");

const app = express();
app.use(cors());

app.get("/card", (req, res) => {
  const futureDate = faker.date.future();
  const month = String(futureDate.getMonth() + 1).padStart(2, "0"); // Ensures two-digit month
  const year = String(futureDate.getFullYear()).slice(-2); // Gets last two digits of the year

  const cardDetails = {
    number: faker.finance.creditCardNumber(),
    expiry: `${month}/${year}`, // Correct format MM/YY
    cvv: faker.finance.creditCardCVV(),
  };

  res.json(cardDetails);
});

app.listen(3000, () => console.log("Server running on port 3000"));
