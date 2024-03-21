import sqlite3 from 'sqlite3';
const database = new sqlite3.Database('./database.db');
import crypto from 'crypto'

const db = () => {
    database.run('CREATE TABLE IF NOT EXISTS devices(id TEXT, name TEXT, port INTEGER, orgid TEXT)');
    database.run('CREATE TABLE IF NOT EXISTS users(id TEXT, name TEXT, password TEXT, organisation TEXT)');
    database.run('CREATE TABLE IF NOT EXISTS organisations(id TEXT, name TEXT)');
}

const getDevices = () => {
    return new Promise((resolve, reject) => {
        const sql = `SELECT * FROM devices`;
        database.all(sql, [], (err, rows) => {
            if (err) {
                console.error(err.message);
                reject(err);
                return;
            }
            resolve(rows);

        });

    });

};
const getDevicesByOrgId = (orgid) => {
    return new Promise((resolve, reject) => {
        const sql = `SELECT * FROM devices WHERE orgid = ?`;
        database.all(sql, [orgid], (err, rows) => {
            if (err) {
                console.error(err.message);
                reject(err);
                return;
            }
            resolve(rows);

        });

    });

};
const getUsers = () => {
    return new Promise((resolve, reject) => {
        const sql = `SELECT * FROM users`;
        database.all(sql, [], (err, rows) => {
            if (err) {
                console.error(err.message);
                reject(err);
                return;
            }
            resolve(rows);

        });

    });

};
const getOrganisations = () => {
    return new Promise((resolve, reject) => {
        const sql = `SELECT * FROM organisations`;
        database.all(sql, [], (err, rows) => {
            if (err) {
                console.error(err.message);
                reject(err);
                return;
            }
            resolve(rows);

        });

    });

};
const addDevice = (name, port, orgId) => {
    const sql = `INSERT INTO devices (id, name, port, orgId) VALUES (?, ?, ?, ?)`;
    const id = crypto.randomBytes(16).toString('hex')
    database.run(sql, [id, name, port, orgId], function(err) {
        if (err) {
            console.error(err.message);
            return;

        }
    });

};

const addOrganisation = (name) => {
    const sql = `INSERT INTO organisations (id, name ) VALUES (?, ?)`;
    const id = crypto.randomBytes(16).toString('hex')
    database.run(sql, [id, name], function(err) {
        if (err) {
            console.error(err.message);
            return;

        }
    });

};

const addUser = (name, password, organisation) => {
    const sql = `INSERT INTO users (id, name, password, organisation) VALUES (?, ?, ?, ?)`;
    const id = crypto.randomBytes(16).toString('hex')
    database.run(sql, [id, name, password, organisation], function(err) {
        if (err) {
            console.error(err.message);
            return;

        }
    });

};

const deleteUser = (id) => {
const sql = `DELETE FROM users WHERE id = ?`;
db.run(sql, [id], function(err) {
    if (err) {
        return console.error('Error deleting user:', err.message);
    }
    console.log(`User with ID ${userIdToDelete} deleted successfully.`);
});
}

const updateUser = (name, password, organisation, id) => {
    const sql = `UPDATE users SET name = ?, password = ? WHERE id = ?`;
    db.run(sql, [name, password, id], function(err) {
    if (err) {
        return console.error('Error updating user:', err.message);
    }
        console.log(`User with ID ${id} updated successfully.`);
    });
}

const deleteDevice = (id) => {
const sql = `DELETE FROM devices WHERE id = ?`;
db.run(sql, [id], function(err) {
    if (err) {
        return console.error('Error deleting user:', err.message);
    }
    console.log(`User with ID ${userIdToDelete} deleted successfully.`);
});
}

const updateDevice = (name, organisation, id) => {
    const sql = `UPDATE device SET name = ?, orgid = ?, port = ?, WHERE id = ?`;
    db.run(sql, [name, password, port, id], function(err) {
    if (err) {
        return console.error('Error updating user:', err.message);
    }
        console.log(`User with ID ${id} updated successfully.`);
    });
}
export {
    db,
    getDevices,
    getOrganisations,
    getUsers,
    addDevice,
    addUser,
    addOrganisation
};
