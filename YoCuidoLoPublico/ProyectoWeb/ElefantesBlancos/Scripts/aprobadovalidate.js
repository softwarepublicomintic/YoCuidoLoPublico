$(function validarestadocosto() {
    $("input[name*='estado_costo']").click(function () {
        if (($('#costo').val() == "")||($('#costo').val() == "0")) {
            $('input:radio[name=estado_costo]').attr('checked', false);
            Validacionestadocosto();
        }

    });
});

function Validacionestadocosto() {
    $("#dialogo-costo").dialog({
        resizable: false,
        height: 240,
        modal: true,
        buttons: {
            "Aceptar": function () {
                $(this).dialog("close");

                return true;
            }

        }
    });
    return false;
}

$(function ValidarFoto() {
    $("input[name*='estado_imagen']").click(function () {
        var varimagen = $("input[name='estado_imagen']:checked").val();
        if (varimagen == "1") {
            $("#id_stra_razon_rechazo").prop('disabled', 'disabled');
            $("#comentario_rechazo").prop('disabled', 'disabled');
        }
        else {
            $("#id_stra_razon_rechazo").removeAttr("disabled");
            $("#comentario_rechazo").removeAttr("disabled");
        }
    });
});


$(function validarestadotiempo() {
    $("input[name*='estado_id_rango_tiempo']").click(function () {
        if ($('#id_stra_rango_tiempo').val() == "") {
            $('input:radio[name=estado_id_rango_tiempo]').attr('checked', false);
            Validacionestadotiempo();
        }

    });
});

function Validacionestadotiempo() {
    $("#dialogo-tiempo").dialog({
        resizable: false,
        height: 240,
        modal: true,
        buttons: {
            "Aceptar": function () {
                $(this).dialog("close");

                return true;
            }

        }
    });
    return false;
}

$(function validarestadocontratista() {
    $("input[name*='estado_contratista']").click(function () {
        if ($('#contratista').val() == "") {
            $('input:radio[name=estado_contratista]').attr('checked', false);
            Validacionestadocontratista();
        }

    });
});

function Validacionestadocontratista() {
    $("#dialogo-contratista").dialog({
        resizable: false,
        height: 240,
        modal: true,
        buttons: {
            "Aceptar": function () {
                $(this).dialog("close");

                return true;
            }

        }
    });
    return false;
}

$(function () {
    var varcosto = $("input[name='estado_costo']:checked").val();
    var vartiempo = $("input[name='estado_id_rango_tiempo']:checked").val();
    var varcontratista = $("input[name='estado_contratista']:checked").val();
    if (varcosto == "1") {
        $("input[name*='estado_costo']").prop('disabled', 'disabled');
    }
    else if (varcosto == "2") {
        $("input[name*='estado_costo']").prop('disabled', 'disabled');
    }

    if (vartiempo == "1") {
        $("input[name*='estado_id_rango_tiempo']").prop('disabled', 'disabled');
    }
    else if (vartiempo == "2") {
        $("input[name*='estado_id_rango_tiempo']").prop('disabled', 'disabled');
    }

    if (varcontratista == "1") {
        $("input[name*='estado_contratista']").prop('disabled', 'disabled');
    }
    else if (varcontratista == "2") {
        $("input[name*='estado_contratista']").prop('disabled', 'disabled');
    }
});



