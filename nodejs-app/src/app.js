const express = require('express');
const app = express();

const port = process.env.PORT || 3000;
const color = process.env.DEPLOY_COLOR || "blue";

app.get('/', (req, res) => {
  const style = `
    <style>
      body {
        background-color: ${color};
        color: white;
        font-family: Arial, sans-serif;
        display: flex;
        height: 100vh;
        justify-content: center;
        align-items: center;
        margin: 0;
      }
      h1 {
        font-size: 3rem;
      }
    </style>
  `;

  res.send(`
    <!DOCTYPE html>
    <html>
      <head>
        <title>Node.js App</title>
        ${style}
      </head>
      <body>
        <h1>Hello from Node.js app - ${color} version deployed on Minikube K8s cluster!</h1>
      </body>
    </html>
  `);
});

// Export the app for testing
module.exports = app;

// Start server only if app.js is run directly, not during tests
if (require.main === module) {
  app.listen(port, () => console.log(`App listening on port http://localhost:${port}`));
}
