import Express from 'express';

const PORT = 8000;
const app = Express()
app.listen(8000, () => {
    console.log(`App is listening on  port ${PORT} `);
})