$(document).ready(function() {
    $('input#url_href, input#url_tag_list').focus(function(){
      $('label[for=' + this.id + ']').hide();
    });
    $('input#url_href, input#url_tag_list').blur(function(){
      this.value = $.trim(this.value);
      if(this.value=='')
        $('label[for=' + this.id + ']').show();
    });
    $('input#url_href, input#url_tag_list').focus().blur();
});
