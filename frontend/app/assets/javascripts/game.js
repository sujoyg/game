$(function () {
  $(".game .play input[name='guess']").autocomplete({
    source: "/game/autocomplete",
    minLength: 2,

    // optional (if other layers overlap autocomplete list)
    open: function (event, ui) {
      $(".ui-autocomplete").css("z-index", 1000);
    }
  });

  $(".game button.next").click(function (e) {
    e.preventDefault();
    location.reload(true);
  });

  $(".game button.finish").click(function (e) {
    e.preventDefault();
    alert("going over to leaderboard.");
  });

  $(".game .play form").submit(function (e) {
    e.preventDefault();

    var $form = $(e.target);
    var data = $form.serialize();
    $.post($form.attr("action"), data).done(function (result) {
      $(".game .result .name").text(result["name"]);
      $(".game .result .guess").text(result["guess"]);

      if (result["over"]) {
        $(".game .next").hide();
        $(".game .finish").show();
      }

      if (result["hit"]) {
        $(".game .score").text(result["score"]);
        $(".game .miss").hide();
        $(".game .hit").show();
      } else {
        $(".game .miss").show();
        $(".game .hit").hide();
      }

      $(".game .play").hide();
      $(".game .result").show();
    });
  });
});