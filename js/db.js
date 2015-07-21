var db;
var request = indexedDB.open("Wombat",1);
request.onerror = function(event) {
  alert("Why didn't you allow wombat to use IndexedDB?!");
};
request.onsuccess = function(event) {
  db = event.target.result;
};

request.onupgradeneeded = function(event) {
  var db = event.target.result;
  db.onerror = function(event) {
    console.log('error loading database.');
  };
  var dictionary = db.createObjectStore("dictionary", { keyPath: "word" });
  dictionary.createIndex("word", "word", { unique: true });
  dictionary.createIndex("definition", "definition", { unique: false });


};