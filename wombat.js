var wombox = document.querySelector('.wombox');
if (wombox){
  wombox.remove();
} else {
  var body = document.querySelector('body');
  body.insertBefore(getWombox('textarea'),body.firstChild);
}

function getWombox(type){
  var wombox = document.createElement('input');
  wombox.className = 'wombox';
  wombox.placeholder = 'waiting for your command...';
  wombox.style.zIndex = '10000';
  wombox.style.position = 'fixed';
  wombox.style.width = '33%';
  wombox.style.margin = '3px';
  wombox.style.padding = '8px';
  wombox.style.borderRadius = '5px';
  wombox.bottom = '1em';
  wombox.right = '1em';
  wombox.addEventListener('keypress',womboxHandler);
  return wombox;
}

function womboxHandler(event){
  if (event.keyCode == '13'){
    var wombox = event.target;
    var command = wombox.value;
    wombox.placeholder = 'evaluating...';
    wombox.value = '';
    if (getCommand(command)){
      command = getCommand(command);
    }
    try {
      wombox.placeholder = eval(command);
    } catch(error){
      wombox.placeholder = error.message;
    }
  }
}

function learn(){
  alert('learning!')

}

function help(){
  return 'I am here to help.'
}

function getCommand(string){
  if (string.toLowerCase = 'what can i do?'){
    return 'help()'
  }
  return false
}