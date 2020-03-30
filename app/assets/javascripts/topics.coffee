$(document).on 'turbolinks:load', ->
  $('#topic-categories').tagit
    fieldName:   'category_list'
    singleField: true
    availableTags: Topic.all_category_list
  $('#topic-categories').tagit()
  category_string = $("#category_hidden").val()
  try
    category_list = category_string.split(',')
    for tag in category_list
      $('#topic-categories').tagit 'createTag', tag
  catch error