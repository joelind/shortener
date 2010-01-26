$(document).ready(function() {
    $('input#url_href, input#url_tag_list').focus(function(){
      this.value = $.trim(this.value);
      if(this.value == '' && this.id=='url_href')
        this.value = 'http://'
      $(this).addClass('highlight');
      $('label[for=' + this.id + ']').hide();
    });
    $('input#url_href, input#url_tag_list').blur(function(){
      $(this).removeClass('highlight');
      this.value = $.trim(this.value);
      if(this.value == 'http://' || this.value=='https://')
        this.value = '';

      if(this.value=='')
        $('label[for=' + this.id + ']').show();
    });
    $('input#url_href, input#url_tag_list').focus().blur();
});
