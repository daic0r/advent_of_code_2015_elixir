"use strict";


const fs = require('fs');
const INPUT = fs.readFileSync('./input.txt', 'utf-8').split('\n').filter(l => l.length);

const result = INPUT.reduce((acc, line) => {
   const evaled = eval(line);
   console.log(evaled);
   return acc + (line.length - evaled.length);
}, 0);

console.log(result);

console.log(0x9C);
