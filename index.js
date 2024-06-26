import express from "express";
import dotenv from "dotenv";

dotenv.config();

const app = express();
const PORT = 8000;

app.get("/hello", (req, res) => {
  res.send("Hello World!");
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
