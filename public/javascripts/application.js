$(document).ready(function() {
    $('input#url_href, input#url_tag_list').focus(function(){
      this.value = $.trim(this.value);
      $(this).addClass('highlight');

      if($(this).parent('fieldset').hasClass('labels-inside'))
        $('label[for=' + this.id + ']').hide();

      if(this.value == '' && this.id=='url_href')
        this.value = 'http://'
    });
    $('input#url_href, input#url_tag_list').blur(function(){
      $(this).removeClass('highlight');
      this.value = $.trim(this.value);
      if(this.value == 'http://' || this.value=='https://')
        this.value = '';

      if(this.value=='' && $(this).parent('fieldset').hasClass('labels-inside'))
        $('label[for=' + this.id + ']').show();
    });
    $('fieldset#href-input, fieldset#taglist-input').addClass('labels-inside');
    $('input#url_href, input#url_tag_list').focus().blur();
});
