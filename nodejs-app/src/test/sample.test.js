const request = require('supertest');
const app = require('../app');

describe('GET /', () => {
  it('responds with expected heading containing deployed color', (done) => {
    request(app)
      .get('/')
      .expect(200)
      .expect(res => {
        if (!res.text.includes('<h1>Hello from Node.js app - blue version deployed on Minikube K8s cluster!</h1>')) {
          throw new Error('Response does not contain expected heading');
        }
      })
      .end(done);
  });
});
