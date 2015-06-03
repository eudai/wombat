function Wombat(){
  return this;
}

Wombat.prototype.createWombox = function(){
  var wombox = document.createElement('wombox');
  wombox.style.zIndex = '10000';
  wombox.style.position = 'fixed';
  wombox.style.top = '0';
  wombox.style.right = '0';
  // wombox.style.width = '30%';
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
  wombox.appendChild(this.createInput());
  wombox.appendChild(this.createTextArea());
  return wombox;
};

Wombat.prototype.createInput = function(){
  var input = document.createElement('input');
  input.style.fontFamily = 'Calibri';
  input.style.fontSize = '14px';
  input.style.width = '300px';
  input.style.margin = '0 auto';
  input.style.padding = '5px';
  input.style.borderRadius = '7px';
  input.style.boxShadow = '0 0 1px inset';
  input.style.resize = 'both';
  input.onkeydown = this.inputHandler;
  input.placeholder = 'waiting for your command...';
  return input;
};

Wombat.prototype.createTextArea = function(){
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
      if (!command) {
        input.placeholder = 'name your command.';
        textarea.value = localStorage.getItem(input.value);
        textarea.style.display = 'block';
        textarea.placeholder = 'define your command.'; 
      } else {lo
        try {
          input.placeholder = eval(command);
        } catch(error){
          input.placeholder = error.message;
        }
        input.value = '';
      }

    }
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