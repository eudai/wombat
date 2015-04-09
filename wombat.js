
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
  wombox.addEventListener('keypress',womboxHandler);
  wombox.style.zIndex = '10000';
  wombox.style.position = 'fixed';
  wombox.style.width = '98%';
  wombox.style.margin = '5px';
  wombox.style.padding = '5px';
  wombox.style.borderRadius = '7px';
  wombox.style.boxShadow = '1px 1px 5px';
  wombox.style.textAlign = 'center';
  wombox.bottom = '1em';
  wombox.right = '1em';
  return wombox;
}

function womboxHandler(event){
  if (event.keyCode == '13'){
    var wombox = event.target;
    var command = wombox.value;
    wombox.placeholder = 'evaluating...';
    wombox.value = '';
    try {
      wombox.placeholder = eval(command);
    } catch(error){
      wombox.placeholder = error.message;
    }
  }
}