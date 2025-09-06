const request = require('supertest');
const app = require('../app');

describe('GET /', () => {
  it('respond with Hello World', (done) => {
    request(app)
      .get('/')
      .expect(200)
      .expect('<h1>Hello from Node.js app - blue version deployed on Minikube K8s cluster!</h1>', done);
  });
});
