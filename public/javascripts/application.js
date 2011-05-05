$(function() {
  $("#new_task #task_text").focus();

  $(".toggler input").live('change', function() {
    $(this).parent('form').submit();
  });

  $("#new_task input[type=image]").hover(function() {
    $(this).attr("src", "/images/add_button_reverse.png");
  }, function() {
    $(this).attr("src", "/images/add_button.png");
  });

  $(".task").live({mouseenter: function() {
    // $(this).children('.remover_placeholder').css('display', 'none');
    $(this).children('.remover').css('display', 'inline-block');
  }, mouseleave: function() {
    // $(this).children('.remover_placeholder').css('display', 'inline-block');
    $(this).children('.remover').css('display', 'none');
  }});
});