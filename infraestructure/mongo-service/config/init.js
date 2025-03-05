// Cambiar a la base de datos: 'trackingsystem'
db = db.getSiblingDB("trackingsystem");

// Crear dos usuarios para "trackingsystem"
db.createUser({
  user: "usertest",
  pwd: "usertest",
  roles: [
    { role: "readWrite", db: "trackingsystem" }, //Permiso para leer/escribir
    { role: "userAdmin", db: "trackingsystem" }, // Permiso para administrar usuarios
  ],
});

db.createUser({
  user: "user2",
  pwd: "password2",
  roles: [{ role: "read", db: "trackingsystem" }], //Permiso para leer/escribir
});

// Listar los usuarios
db.getUsers();


const sensors = ["sensor_temp1", "sensor_temp2", "sensor_temp3"];

const data = sensors.map((sensor) => ({
  produced_by: "bash_script",
  sensorId: sensor,
  timestamp: new Date(),
  temperature: (Math.random() * 10 + 10).toFixed(1), // Genera temperatura aleatoria entre 10 y 20
  degree: "celsius",
}));

db.sensor_data.insertMany(data);

db.sensor_data.find().sort({ timestamp: -1 }).limit(1);
