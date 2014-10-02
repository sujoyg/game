$(function () {
  $(".game input[name='guess']").autocomplete({
    source: "/game/autocomplete",
    minLength: 2,

    // optional (if other layers overlap autocomplete list)
    open: function (event, ui) {
      $(".ui-autocomplete").css("z-index", 1000);
    }
  });
});