import express from 'express'
import {db, getUsers, addUser, getOrganisations, getDevices, addOrganisation, addDevice} from '../db/db.js'
import cors from 'cors';
const app = express();
db();
app.use(express.json());
app.use(cors())
app.get('/users', async (req, res) => {
    const users = await getUsers();
    res.json(users);
});

app.get('/organisations', async (req, res) => {
    const organisations = await getOrganisations();
    res.json(organisations)
});

app.get('/devices', async (req, res) => {
    const devices = await getDevices();
    res.json(devices)
});

app.post('/users', (req, res) => {
    addUser(req.body.name, req.body.password, req.body.organisation) 
    const users = getUsers();
    res.json(users)
});

app.put('/users', (req, res) => {
    updateUser(req.body.name, req.body.password, req.body.organisation) 
    const users = getUsers();
    res.json(users)
});

app.put('/devices', (req, res) => {
    updateDevice(req.body.name, req.body.port, req.body.orgId) 
    const users = getUsers();
    res.json(users)
});

app.post('/organisations', (req, res) => {
    addOrganisation(req.body.name) 
    const organisations = getOrganisations();
    res.json(organisations)
});

app.post('/devices', (req, res) => {
    addDevice(req.body.name, req.body.port, req.body.orgId) 
    const organisations = getOrganisations();
    res.json(organisations)
});

app.put('/users/:id', (req, res) => {
});
app.delete('/users/:id', (req, res) => {
});
export default app;
