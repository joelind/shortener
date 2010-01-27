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
      setTimeout("$($('div#tag-autocompleter')[0]).hide()", 10);
      $(this).removeClass('highlight');
      this.value = $.trim(this.value);
      if(this.value == 'http://' || this.value=='https://')
        this.value = '';

      if(this.value=='' && $(this).parent('fieldset').hasClass('labels-inside'))
        $('label[for=' + this.id + ']').show();
    });
    $('fieldset#href-input, fieldset#taglist-input').addClass('labels-inside');
    $('input#url_href, input#url_tag_list').focus().blur();

    var lastSearchedTag = '';
    var tagSearches = {}; /* let's cache these */
    $('input#url_tag_list').keyup(function(){
        var parts = this.value.split(',');
        var lastTag = $.trim(parts[parts.length-1]);
        if(lastTag.length > 2){
          lastSearchedTag = lastTag;
          if(tagSearches[lastTag]){
            /* cache hit! */
            suggestTags(tagSearches[lastTag]);
          }
          else{
            $.getJSON('/tags.json', { 'text_like' : lastTag },
              function(data){
                tagSearches[lastSearchedTag] = data;
                suggestTags(data);
            });
          }
        }
        else
          getAutocompleter().hide();
    });

    function getAutocompleter(){
      return $($('div#tag-autocompleter')[0]);
    }

    function suggestTags(tagSearchResult){
      if(tagSearchResult.text_like != lastSearchedTag)
        return; // asynchronous processing, check to make
                // sure our response was for the most recent request
      var autocompleter = getAutocompleter();
      autocompleter.hide();
      if(tagSearchResult.tags.length < 1)
        return;

      var list = $(autocompleter.html('<ul/>').children('ul'))[0];
      jQuery.each(tagSearchResult.tags, function(){
        $('<li><a href="#">' + $('<div/>').text(this.tag.text).html() + '</a></li>').appendTo($(list));
      });
      autocompleter.fadeIn();
    }

    $('#tag-autocompleter a').live('click', function(event){
        var tagList = $('input#url_tag_list')[0].value;
        tagList = tagList.replace(new RegExp(lastSearchedTag + '$'), $(this).text());
        $('input#url_tag_list')[0].value = tagList;
        getAutocompleter().hide();
        $($('input#url_tag_list')[0]).focus();
        return false;
    });

});
