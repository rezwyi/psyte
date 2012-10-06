//= require jquery
//= require jquery_ujs
//= require_tree .

function pasteTagName(name) {
  var oPostTagNames = document.getElementById("post_tag_names");
  oPostTagNames.value = oPostTagNames.value.concat(name) + " ";
}
