window.addEventListener("load", function () {
var selectEl = document.querySelector('select[name="description"]');
selectEl.addEventListener('change', function() {
  var formData = new FormData(document.querySelector('form'));
  console.log(formData);
  var xhr = new XMLHttpRequest();
  var link=document.getElementById('linkphp').value;
  xhr.open('POST', link, true); 
  xhr.onreadystatechange = function() {
    if (xhr.readyState === 4 && xhr.status === 200) {
      var input = document.getElementById('inputchange');
      console.log(xhr.responseText);
      input.type=xhr.responseText;
      input.name=xhr.responseText;
    }
  };
  xhr.send(formData);
})
});
