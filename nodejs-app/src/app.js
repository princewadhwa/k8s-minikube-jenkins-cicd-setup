const express = require('express');
const app = express();

const port = process.env.PORT || 3000;
const color = process.env.DEPLOY_COLOR || "blue";

app.get('/', (req, res) => res.send(`<h1>Hello from Node.js app - ${color} version deployed on Minikube K8s cluster!</h1>`));

// Export the app for testing
module.exports = app;

// Start server only if app.js is run directly, not during tests
if (require.main === module) {
  app.listen(port, () => console.log(`App listening on port http://localhost:${port}`));
}
