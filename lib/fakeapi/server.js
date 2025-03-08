const express = require("express");
const cors = require("cors");
const { faker } = require("@faker-js/faker");

const app = express();
app.use(cors());

app.get("/card", (req, res) => {
  const futureDate = faker.date.future();
  const month = String(futureDate.getMonth() + 1).padStart(2, "0"); 
  const year = String(futureDate.getFullYear()).slice(-2); 

  const cardDetails = {
    number: faker.finance.creditCardNumber(),
    expiry: `${month}/${year}`, 
    cvv: faker.finance.creditCardCVV(),
  };

  res.json(cardDetails);
});

app.listen(3000, () => console.log("Server running on port 3000"));
