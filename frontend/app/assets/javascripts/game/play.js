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

    $(".game #button_enter").submit(function (e) {
        e.preventDefault();
        var $form = $(e.target);
        var data = $form.serialize();
        $.post($form.attr("action"), data).done(function (result) {
            console.log(result);
            $(".game .result .name").text(result["name"]);
            $(".game .result .guess").text(result["guess"]);

            $(".game .score").text(result["score"]);
            $(".game .remaining").text(result["remaining"]);

            if (result["remaining"] == 0) {
                $(".game .next").hide();
                $(".game .finish").show();
            }

            if (result["hit"]) {
                $(".game .miss").hide();
                $(".game .hit").show();
            } else {
                $(".game .miss").show();
                $(".game .hit").hide();
            }
            $(".game").find('.flipper').toggleClass('flipped');
        });
    });

});
