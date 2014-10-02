$(function () {
  $(".game .play input[name='guess']").autocomplete({
    source: "/game/autocomplete",
    minLength: 2,

    // optional (if other layers overlap autocomplete list)
    open: function (event, ui) {
      $(".ui-autocomplete").css("z-index", 1000);
    }
  });

  $(".game .play form").submit(function (e) {
    e.preventDefault();

    var $form = $(e.target);
    var data = $form.serialize();
    $.post($form.attr("action"), data).done(function (result) {
      if (result["hit"]) {
        alert("Success!");
      } else {
        alert("Failure!");
      }
    });

  });
});