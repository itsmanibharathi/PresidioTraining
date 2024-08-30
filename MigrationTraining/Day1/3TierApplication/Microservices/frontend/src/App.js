// src/App.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';

function App() {
    const [items, setItems] = useState([]);
    const apiUrl = process.env.REACT_APP_BACKEND_API || 'http://localhost:5000';

    useEffect(() => {
        axios.get(`${apiUrl}/items`)
            .then(response => {
                setItems(response.data);
            })
            .catch(error => {
                console.error('There was an error fetching the data!', error);
            });
    }, [apiUrl]);

    return (
        <div className="App">
            <h1>Items List</h1>
            <ul>
                {items.map(item => (
                    <li key={item._id}>{item.name}</li>
                ))}
            </ul>
        </div>
    );
}

export default App;
