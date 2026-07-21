const fs = require('fs');
const path = require('path');

function walk(dir) {
  let results = [];
  const list = fs.readdirSync(dir);
  list.forEach(function(file) {
    file = path.join(dir, file);
    const stat = fs.statSync(file);
    if (stat && stat.isDirectory()) { 
      results = results.concat(walk(file));
    } else { 
      if (file.endsWith('.spec.ts')) results.push(file);
    }
  });
  return results;
}

const files = walk('./src/app');

files.forEach(file => {
  let content = fs.readFileSync(file, 'utf8');
  
  let newContent = content;
  
  if (!newContent.includes('import { provideHttpClient }') && !newContent.includes('import {provideHttpClient}')) {
      newContent = "import { provideHttpClient } from '@angular/common/http';\n" + newContent;
  }
  if (!newContent.includes('import { provideRouter }') && !newContent.includes('import {provideRouter}')) {
      newContent = "import { provideRouter } from '@angular/router';\n" + newContent;
  }
  
  if (!newContent.includes('provideHttpClient()')) {
      if (newContent.includes('providers: [')) {
         newContent = newContent.replace('providers: [', 'providers: [provideHttpClient(), provideRouter([]), ');
      } else if (newContent.includes('TestBed.configureTestingModule({')) {
         newContent = newContent.replace('TestBed.configureTestingModule({', 'TestBed.configureTestingModule({ providers: [provideHttpClient(), provideRouter([])], ');
      }
  }
  
  if (content !== newContent) {
      fs.writeFileSync(file, newContent);
      console.log('Patched', file);
  }
});
