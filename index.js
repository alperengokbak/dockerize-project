import express from "express";

const app = express();
const PORT = 3000;

app.get("/helloworld", (req, res) => {
  res.send("Hello World!");
});

app.listen(PORT, () => {
  console.log("Server is running on port 3000");
});
