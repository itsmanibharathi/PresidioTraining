const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const app = express();
const port = process.env.PORT || 6000;
require('dotenv').config()

// MongoDB connection
mongoose.connect(process.env.MONGO_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true
});

const db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', async () => {
    console.log('Connected to MongoDB');
    // Insert default data if not present
    const count = await Item.countDocuments();
    if (count === 0) {
        await Item.insertMany([
            { name: 'Item 1' },
            { name: 'Item 2' },
            { name: 'Item 3' }
        ]);
        console.log('Default items added');
    }
});

app.use(cors());
app.use(express.json());

// Set EJS as the templating engine
app.set('view engine', 'ejs');

// Define a schema and model
const itemSchema = new mongoose.Schema({
    name: String
});

const Item = mongoose.model('Item', itemSchema);

// Health check
app.get('/', async (req, res) => {
    try {
        const items = await Item.find();
        res.render('index', { items });
    } catch (error) {
        res.status(500).send(error.message);
    }
});

// Route to get data from the database (JSON response)
app.get('/items', async (req, res) => {
    try {
        const items = await Item.find();
        res.json(items);
    } catch (error) {
        res.status(500).send(error.message);
    }
});

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
