function Wombat(){
  return this;
}

Wombat.prototype.createWombox = function(){
  var wombox = document.createElement('wombox');
  wombox.style.zIndex = '10000';
  wombox.style.position = 'fixed';
  wombox.style.top = '0';
  wombox.style.width = '30%';
  wombox.style.borderRadius = '5px';
  wombox.style.boxShadow = '1px 1px 5px';
  wombox.style.backgroundColor = 'white';
  wombox.style.textAlign = 'center';
  wombox.style.overflow = 'auto';
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

Wombat.prototype.createInput = function(){
  var input = document.createElement('input');
  input.style.width = '95%';
  input.style.margin = '5px auto';
  input.style.marginTop = '10px';
  input.style.marginBottom = '10px';
  input.style.padding = '5px';
  input.style.borderRadius = '7px';
  input.style.resize = 'both';
  input.boxShadow = '1px 1px 5px';
  input.onkeydown = this.inputHandler;
  input.placeholder = 'waiting for your command...';
  return input;
};

Wombat.prototype.createTextArea = function(){
  var textarea = document.createElement('textarea');
  textarea.style.width = '95%';
  textarea.style.margin = '5px auto';
  textarea.style.marginTop = '0';
  textarea.style.marginBottom = '10px';
  textarea.style.padding = '5px';
  textarea.style.borderRadius = '7px';
  textarea.style.boxShadow = '1px 1px 2px inset';
  textarea.style.resize = 'vertical';
  textarea.style.display = 'none';
  return textarea;
};

Wombat.prototype.inputHandler = function(event){
  var wombox = event.target.parentNode;
  var input = wombox.querySelector('input');
  var textarea = wombox.querySelector('textarea');
  if (event.keyCode == 13){
    if (textarea.style.display == 'block'){
      localStorage.setItem(input.value,textarea.value); 
      console.log('Saved:',input.value,textarea.value)
      input.value = '';
      textarea.value = '';
    } else {
      var command = localStorage.getItem(input.value);
      try {
        input.placeholder = eval(command);
      } catch(error){
        input.placeholder = error.message;
      }
    }
    input.value = '';
  } else if (event.keyCode == 17){
    if (textarea.style.display == 'none'){
      input.placeholder = 'name your command.';
      textarea.value = localStorage.getItem(input.value);
      textarea.style.display = 'block';
      textarea.placeholder = 'define your command.';
    } else {
      input.placeholder = 'waiting for your command...';
      textarea.style.display = 'none';
    }
  }
};

Wombat.prototype.save = function(key,value){
  localStorage.setItem(key,value);
};

Wombat.prototype.execute = function(string){
  var input = wombox.querySelector('wombox input');
  var command = localStorage.getItem(string);
  try {
    input.placeholder = eval(command);
  } catch(error){
    input.placeholder = error.message;
  }
};


var wombat = new Wombat();
var body = document.querySelector('body');
var wombox = document.querySelector('wombox');
if (wombox){
  wombox.remove();
} else {
  body.appendChild(wombat.createWombox());
  document.querySelector('wombox input').focus();
}