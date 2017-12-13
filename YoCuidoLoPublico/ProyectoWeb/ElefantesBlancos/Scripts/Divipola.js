
    //Departamento
    $('#DepartamentoSelector').click();
$(document).ready(function () {
    var selectedDep = $('#DepartamentoSelector').val();
    if (selectedDep != null && selectedDep != '') {
        $.getJSON('@Url.Action("GetMunicipio")', { departamento: selectedDep }, function (data) {
            var items = '';
            $.each(data, function (i, municipio) {
                items += "<option value='" + municipio.value + "'>" + municipio.text + "</option>";

            });
            $('#MunicipioSelector').empty();
            $('#MunicipioSelector').html(items);
            $('#MunicipioSelector').click();
            $('#MunicipioSelector').val('@ViewBag.MunicipioSelector');

        });

    }
    $('#DepartamentoSelector').change(function () {
        var selectedDep = $(this).val();
        //Cargo nuevamente los departamentos si selecciona el departamento 0
        if (selectedDep == '0') {
            $.getJSON('@Url.Action("GetDepartamentoTodos")', { departamento: selectedDep }, function (data) {
                var items = '';
                $.each(data, function (i, departamento) {
                    items += "<option value='" + departamento.value + "'>" + departamento.text + "</option>";

                });

                $('#DepartamentoSelector').empty();
                $('#DepartamentoSelector').html(items);
                $('#DepartamentoSelector').click();
                $('#DepartamentoSelector').val(selectedDep);
                $('#MunicipioSelector').val('@ViewBag.MunicipioSelector');

            });
        }

        if (selectedDep != null && selectedDep != '') {
            $.getJSON('@Url.Action("GetMunicipio")', { departamento: selectedDep }, function (data) {
                var items = '';
                $.each(data, function (i, municipio) {
                    items += "<option value='" + municipio.value + "'>" + municipio.text + "</option>";

                });

                $('#MunicipioSelector').empty();
                $('#MunicipioSelector').html(items);
                $('#MunicipioSelector').click();
                $('#MunicipioSelector').val('@ViewBag.MunicipioSelector');
            });


            $.getJSON('@Url.Action("GetRegion")', { departamento: selectedDep }, function (data) {
                var items = '';
                $('#RegionSelector').val(data);
                $('#MunicipioSelector').val('0');
                $('#DepartamentoSelector').val(selectedDep);
            });


        }
    });

});

//Regiones
$('#RegionSelector').click();
$(document).ready(function () {
    var selectedRegion = $('#RegionSelector').val();
    if (selectedRegion != null && selectedRegion != '') {
        $.getJSON('@Url.Action("GetDepartamentoPorRegion")', { region: selectedRegion }, function (data) {
            var items = '';
            $.each(data, function (i, departamento) {
                if (departamento.value == '@ViewBag.DepartamentoSelector') {
                    items += "<option selected=\"selected\" value='" + departamento.value + "'>" + departamento.text + "</option>";
                }
                else {
                    items += "<option value='" + departamento.value + "'>" + departamento.text + "</option>";
                }

            });
            $('#DepartamentoSelector').empty();
            $('#DepartamentoSelector').html(items);
            $('#DepartamentoSelector').click();
            $('#DepartamentoSelector').val('@ViewBag.DepartamentoSelector');
            $('#MunicipioSelector').val('@ViewBag.MunicipioSelector');
        });


    }
    $('#RegionSelector').change(function () {
        var selectedRegion = $(this).val();
        if (selectedRegion != null && selectedRegion != '') {
            $.getJSON('@Url.Action("GetDepartamentoPorRegion")', { region: selectedRegion }, function (data) {
                var items = '';
                $.each(data, function (i, departamento) {
                    items += "<option value='" + departamento.value + "'>" + departamento.text + "</option>";
                });
                $('#DepartamentoSelector').empty();
                $('#DepartamentoSelector').html(items);
                $('#DepartamentoSelector').click();
                $('#DepartamentoSelector').val('@ViewBag.DepartamentoSelector');
            });


            $.getJSON('@Url.Action("GetMunicipioPorRegion")', { region: selectedRegion }, function (data) {
                var items = '';
                $.each(data, function (i, municipio) {
                    items += "<option value='" + municipio.value + "'>" + municipio.text + "</option>";
                });
                $('#MunicipioSelector').empty();
                $('#MunicipioSelector').html(items);
                $('#MunicipioSelector').click();
                $('#MunicipioSelector').val('@ViewBag.MunicipioSelector');
            });
        }
    });

});


//Municipio
$('#MunicipioSelector').click();
$(document).ready(function () {
    var selectedMun = $('#MunicipioSelector').val();

    $('#MunicipioSelector').change(function () {
        var selectedMun = $(this).val();
        if (selectedMun != null && selectedMun != '') {
            $.getJSON('@Url.Action("GetRegionPorMunicipio")', { municipio: selectedMun }, function (data) {
                $('#RegionSelector').val(data);

            });

            $.getJSON('@Url.Action("GetDepartamentoPorMunicipio")', { municipio: selectedMun }, function (data) {
                $('#DepartamentoSelector').val(data);

            });

            $.getJSON('@Url.Action("GetMunicipioPorMunicipio")', { municipio: selectedMun }, function (data) {
                var items = '';
                $.each(data, function (i, municipio) {
                    items += "<option value='" + municipio.value + "'>" + municipio.text + "</option>";
                });
                $('#MunicipioSelector').empty();
                $('#MunicipioSelector').html(items);
                $('#MunicipioSelector').click();
                $('#MunicipioSelector').val(selectedMun);
            });
        }


    });

});


