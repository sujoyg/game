$(function () {
  $("[name='guess']").autocomplete({
    source: "/game/autocomplete",
    minLength: 2,

    // optional (if other layers overlap autocomplete list)
    open: function (event, ui) {
      $(".ui-autocomplete").css("z-index", 1000);
    }
  });

  $("#button_next").click(function (e) {
    e.preventDefault();
    location.reload(true);
  });

  $("#button_finish").click(function (e) {
    e.preventDefault();
    location.href = $(".game").data("finish");
  });

  $("form.game").submit(function (e) {
    e.preventDefault();
    var $form = $(e.target);
    var data = $form.serialize();
    $.post($form.attr("action"), data).done(function (result) {
      console.log(result);

      // Update scores
      $(".score--unit__correct .score--number").text(result["score"]);
      $(".score--unit__total .score--number").text(result["rounds"]);
      $(".score--unit__rounds .score--number").text(result["remaining"]);

      // Update user information
      $(".game .name").text(result["name"]);
      $(".game .guess").text(result["guess"]);
      $(".game a.email").text(result["email"]);
      $(".game a.email").attr("href", "mailto:" + result["email"]);

      if (result["remaining"] == 0) {
        $("#button_next").hide();
        $("#button_finish").show();
      }

      if (result["hit"]) {
        $(".game .status__correct").show();
        $(".game .status__incorrect").hide();
      } else {
        $(".game .status__correct").hide();
        $(".game .status__incorrect").show();
      }
      $(".game .flipper").toggleClass('flipped');
    });
  });
});
