Wombat = {};

var request = indexedDB.open("Wombat",1.1);

request.onsuccess = function(event) {
  Wombat.database = event.target.result;
};

request.onupgradeneeded = function(event) {
  var db = event.target.result;
  var dictionary = db.createObjectStore("dictionary", { keyPath: "word" });
  dictionary.createIndex("word", "word", { unique: true });
  dictionary.createIndex("definition", "definition", { unique: false });
};

Wombat.createWombox = function(){
  var wombox = document.createElement('wombox');
  wombox.style.zIndex = '10000';
  wombox.style.position = 'absolute';
  wombox.style.top = '0';
  wombox.style.left = '0';
  wombox.style.margin = '5px';
  wombox.style.padding = '5px';
  wombox.style.borderRadius = '5px';
  wombox.style.boxShadow = '1px 1px 5px';
  wombox.style.backgroundColor = 'white';
  wombox.style.textAlign = 'center';
  wombox.style.overflow = 'auto';
  wombox.style.fontFamily = 'Calibri';
  wombox.style.fontSize = '12px';
  wombox.bottom = '1em';
  wombox.right = '1em';
  wombox.draggable = true;   
  wombox.ondragend = function(event){    
    wombox = event.target;   
    wombox.style.top = event.y - wombox.clientHeight+ 'px';    
    wombox.style.left = event.x + 'px';    
  };
  wombox.appendChild(this.createInput());
  wombox.appendChild(this.createTextArea());
  return wombox;
};

Wombat.createInput = function(){
  var input = document.createElement('input');
  input.onkeydown = this.inputHandler;
  input.placeholder = 'waiting for your command...';
  input.style.fontFamily = 'Calibri';
  input.style.fontSize = '14px';
  input.style.width = '300px';
  input.style.margin = '0 auto';
  input.style.padding = '5px';
  input.style.borderRadius = '7px';
  input.style.boxShadow = '0 0 1px inset';
  return input;
};

Wombat.createTextArea = function(){
  var textarea = document.createElement('textarea');
  textarea.style.fontFamily = 'Calibri';
  textarea.style.fontSize = '14px';
  textarea.style.width = '300px';
  textarea.style.height = '300px';
  textarea.style.margin = '0 auto';
  textarea.style.marginTop = '5px';
  textarea.style.padding = '5px';
  textarea.style.borderRadius = '7px';
  textarea.style.boxShadow = '0 0 1px inset';
  textarea.style.resize = 'vertical';
  textarea.style.display = 'none';
  return textarea;
};

Wombat.inputHandler = function(event){
  var wombox = event.target.parentNode;
  var input = wombox.querySelector('input');
  var textarea = wombox.querySelector('textarea');
  if (event.keyCode == 13){
    if (textarea.style.display == 'block'){
      Wombat.save(input.value,textarea.value,Wombat.saved);
    } else {
      Wombat.load(input.value,Wombat.execute);
    }
  } else if (event.keyCode == 17){
    if (textarea.style.display == 'none'){
      input.placeholder = 'name your command.';
      textarea.placeholder = 'define your command.';
      textarea.value = '';
      textarea.style.display = 'block';
      Wombat.load(input.value,function(response){
        if (response)
        document.querySelector('wombox textarea').value = response.definition;
      });
    } else {
      input.placeholder = 'waiting for your command...';
      textarea.style.display = 'none';
    }
  }
};

Wombat.save = function(key,value,callback){
  var transaction = Wombat.database.transaction(["dictionary"],"readwrite");
  var dictionary = transaction.objectStore("dictionary");
  var request = dictionary.add({word: key, definition: value});
  document.querySelector('wombox input').value = '';
  request.onsuccess = function(event){
    callback(event.target.result);
  };
  request.onerror = function(event){
    callback(event.target.result);
  };
};

Wombat.saved = function(string){
  var input = document.querySelector('wombox input');
  var textarea = document.querySelector('wombox textarea');
  textarea.style.display = 'none';
  textarea.value = '';
  input.value = '';
  if (string) {
    input.placeholder = string + ' saved.';
  } else {
    input.placeholder = 'failed to save.';
  }
};

Wombat.load = function(key,callback){
  var transaction = Wombat.database.transaction(["dictionary"],"readwrite");
  var dictionary = transaction.objectStore("dictionary");
  var request = dictionary.get(key);
  request.onsuccess = function(event){
    callback(event.target.result);
  };
  request.onerror = function(event){
    callback();
  };
};

Wombat.showDefinition = function(string){
  var textarea = document.querySelector('wombox textarea');
  textarea.value = string;
};

Wombat.execute = function(response){
  var input = document.querySelector('wombox input');
  var textarea = document.querySelector('wombox textarea');
  if (!response || !response.definition) {
    input.placeholder = 'name your command.';
    textarea.value = '';
    textarea.style.display = 'block';
    textarea.placeholder = 'define your command.'; 
  } else {
    try {
      input.placeholder = eval(response.definition);
    } catch(error){
      input.placeholder = error.message;
    }
    input.value = '';
  }
};


var wombox = document.querySelector('wombox');
if (wombox){
  wombox.remove();
} else {
  document.body.appendChild(Wombat.createWombox());
  document.querySelector('wombox input').focus();
}