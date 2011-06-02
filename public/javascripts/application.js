// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function pasteTagName(name) {
  var oPostTagNames = document.getElementById("post_tag_names");
  oPostTagNames.value = oPostTagNames.value.concat(name) + " ";
}
