const fs = require('fs');
const path = require('path');
const express = require('express');

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(function(req, res, next) {
  console.log(`Request Method: ${req.method}, Request URL: ${req.url}`);
  next();
});

app.get('/',function(req, res) {
  fs.readdir('./files', (err, files) => {
    if (err) {
      console.error('Error reading directory:', err);
      return res.status(500).send('Internal Server Error');
    }
    for(let i = 0; i < files.length; i++) {
        files[i] = files[i].split('_').join(' ');
      files[i] = files[i].replace('.txt', '');
    }
    res.json(files);
  });
});

app.post('/create', (req, res) => {
  fs.writeFile(`./files/${req.body.title.split(' ').join('_')}.txt`, req.body.content, (err) => {
    if (err) {
      console.error('Error creating file:', err);
      return res.status(500).send('Internal Server Error');
    }
    res.send('File created successfully');
  });
});

app.delete('/delete', (req, res) => {
  fs.unlink(`./files/${req.body.title.split(' ').join('_')}.txt`, (err) => {
    if (err) {
      console.error('Error deleting file:', err);
      return res.status(500).send('Internal Server Error');
    }
    res.send('File deleted successfully');
  });
});

app.get('/details/:title',function(req, res){
    const filePath = path.join(__dirname, 'files', req.params.title.split(' ').join('_') + '.txt');
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return res.status(500).send('Internal Server Error');
        }
        res.json({ content: data });
    });
});


app.listen(3000);