(function ($) {
    $.fn.ImageSliderControl = function (options) {
        var sliderConfiguration = {
            slidersteps: 0,
            slidernumImages: 2,
            sliderPrevId: "btn-prev",
            sliderPrevImage: "",
            sliderPrevHoverImage: "",
            sliderPrevIdsliderPrevShow: false,
            sliderNextId: "btn-next",
            sliderNextImage: "",
            sliderNextHoverImage: "",
            sliderwidth: 580,
            sliderheight:360,
            sliderbackgroundimage: "",
            sliderTittle: "",
            sliderShow: "",
            sliderName: "",
            sliderImgClose: "",
            sliderImgHoverClose: "",
            sliderData: null,
            sliderDataShort: null,
            sliderImageId :null,
            sliderIsprincipal: false,
            sliderPreviewControlId: null,
            sliderPreviewControlwidth:400,
            sliderPreviewImgwidth: 85,
            sliderPreviewImgheight: 60,
            sliderCheckBoxName: "Principal",
            sliderCameraImg: "",
            sliderControllerUpdate : null

        };

        var sliderOptions = $.extend(sliderConfiguration, options);
        var controlSlider = "#" + sliderOptions.sliderName + "-" + "slider-control";
        this.each(function () {
            var html = '<div id="' + sliderOptions.sliderName + "-" + 'slider-tittle"><h1 class="' + sliderOptions.sliderName + "-" + 'slider-tittle">' + sliderOptions.sliderTittle + '</h1><div class="' + sliderOptions.sliderName + "-" + 'btn_close"></div></div>' +
                '<div id="' + sliderOptions.sliderName + "-" + 'container-slider">';

            html = html + '<img id="' + sliderOptions.sliderName + "-" + 'slider-control" src="' + sliderOptions.sliderbackgroundimage + '" ImageId="' + sliderOptions.sliderImageId + '" isprincipal="' + sliderOptions.sliderIsprincipal + '" ><div id="' + sliderOptions.sliderName + "-" + 'Isprincipal"><img style="margin : 4px ;" src="' + sliderOptions.sliderCameraImg + '"/><span>Foto Principal</span></div></img>';

            html = html + '</div>';

            html = html +  '<div id="' + sliderOptions.sliderName + "-" + 'bnt-prev" class="' + sliderOptions.sliderName + "-" + sliderOptions.sliderPrevId + '"></div>' +
                '<div id="' + sliderOptions.sliderName + "-" + 'btn-next" class="' + sliderOptions.sliderName + "-" + sliderOptions.sliderNextId + '"></div>';

    
            $(this).html(html);

            var UlHtml = "";

            $.each(sliderOptions.sliderDataShort, function (index, result) {
                UlHtml = UlHtml + '<li>';
                UlHtml = UlHtml + '<a href="' + result.Idpadre + '" class="' + sliderOptions.sliderPreviewControlId + '">';
                UlHtml = UlHtml + '<img src="'+  result.Route  +'" width="'+ sliderOptions.sliderPreviewImgwidth  +'" height="' + sliderOptions.sliderPreviewImgheight +'" alt="" />';
                UlHtml = UlHtml + '</a><li>';
            });

            $("#" + sliderOptions.sliderPreviewControlId).html(UlHtml);

            LoadCssControl("#" + sliderOptions.sliderPreviewControlId, sliderOptions);

            $("." + sliderOptions.sliderPreviewControlId).live("click",function (e) {
                e.preventDefault();
                var idImg = parseInt($(this).attr("href"));
                var position = 0;
                $.each(sliderOptions.sliderData, function (index, result) {
                    if (idImg === result.Id)
                    {
                        $("#" + sliderOptions.sliderName).show();
                        $("." + sliderOptions.sliderName + "-" + "toggler2").show();
                        sliderOptions.slidersteps = position;
                         
                        $(controlSlider).attr("imageId", result.Id);
                        $(controlSlider).attr("isprincipal", result.Isprincipal);

                        $(controlSlider).attr("src", result.Route).animate("fast", function () {
                            constructorImage($(controlSlider), sliderOptions.sliderwidth, sliderOptions.sliderheight, sliderOptions.sliderName, "block", sliderOptions.sliderPrevHoverImage, sliderOptions.sliderPrevImage, sliderOptions.sliderNextHoverImage, sliderOptions.sliderNextImage);
                            if (result.Isprincipal) {
                                $("#" + sliderOptions.sliderName + "-" + "Isprincipal").show();
                                $("." + sliderOptions.sliderName + "-" + "slider-tittle").empty();

                            } else {

                                var infoSec = "<input type='checkbox' class='" + sliderOptions.sliderCheckBoxName + "' style='margin-right: 8px;'/>Seleccionar esta foto como principal";

                                $("." + sliderOptions.sliderName + "-" + "slider-tittle").html(infoSec);

                                $("#" + sliderOptions.sliderName + "-" + "Isprincipal").hide();
                            }                           

                            $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderPrevId).show();
                            $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderNextId).show();

                            if (sliderOptions.slidersteps === sliderOptions.slidernumImages) {
                                $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderNextId).hide();
                            }

                            if (sliderOptions.slidersteps === 0) {
                                $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderPrevId).hide();
                            }
                            return;
                        });

                    }

                    position = position + 1;
                });
            });
            
            $(".ChkPrincipal").live("click", function () {

                var idOld = 0;
                var idNew = parseInt($(controlSlider).attr("imageId"));


                $.each(sliderOptions.sliderData, function(index, result) {
                    if (result.Isprincipal) {
                        idOld = result.Id;
                        result.Isprincipal = false;
                    } else {
                        
                        if (result.Id === idNew) {
                            result.Isprincipal = true;
                        }
                            
                    }

                });

                $.each(sliderOptions.sliderDataShort, function (index, result) {
                    if (result.Isprincipal) {
                        idOld = result.Idpadre;
                        result.Isprincipal = false;
                    } else {

                        if (result.Idpadre === idNew) {
                            result.Isprincipal = true;
                        }

                    }

                });
                
                sliderOptions.sliderData.sort(function(a, b) {
                    return b.Isprincipal - a.Isprincipal;
                });

                sliderOptions.sliderDataShort.sort(function (a, b) {
                    return b.Isprincipal - a.Isprincipal;
                });

                var UlHtml = "";

                $.each(sliderOptions.sliderDataShort, function (index, result) {
                    UlHtml = UlHtml + '<li>';
                    UlHtml = UlHtml + '<a href="' + result.Idpadre + '" class="' + sliderOptions.sliderPreviewControlId + '">';
                    UlHtml = UlHtml + '<img src="' + result.Route + '" width="' + sliderOptions.sliderPreviewImgwidth + '" height="' + sliderOptions.sliderPreviewImgheight + '" alt="" />';
                    UlHtml = UlHtml + '</a><li>';
                });

                $("#" + sliderOptions.sliderPreviewControlId).html(UlHtml);

                LoadCssControl("#" + sliderOptions.sliderPreviewControlId, sliderOptions);

                $.ajax({
                    type: "POST",
                    url: sliderOptions.sliderControllerUpdate,
                    data: "{ IdOld : " + idOld + ", IdNew : " + idNew + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        sliderOptions.slidersteps = 0;

                        $(controlSlider).attr("imageId", sliderOptions.sliderData[0].Id);
                        $(controlSlider).attr("isprincipal", sliderOptions.sliderData[0].Isprincipal);


                       $(controlSlider).attr("src", sliderOptions.sliderData[0].Route).animate("slow", function () {
                           constructorImage($(controlSlider), sliderOptions.sliderwidth, sliderOptions.sliderheight, sliderOptions.sliderName, "block", sliderOptions.sliderPrevHoverImage, sliderOptions.sliderPrevImage, sliderOptions.sliderNextHoverImage, sliderOptions.sliderNextImage);
                           if (sliderOptions.sliderData[0].Isprincipal) {
                               $("#" + sliderOptions.sliderName + "-" + "Isprincipal").show();
                               $("." + sliderOptions.sliderName + "-" + "slider-tittle").empty();
                           } else {

                               var infoSec = "<input type='checkbox' class='" + sliderOptions.sliderCheckBoxName + "' style='margin-right: 8px;'/>Seleccionar esta foto como principal";

                               $("." + sliderOptions.sliderName + "-" + "slider-tittle").html(infoSec);

                               $("#" + sliderOptions.sliderName + "-" + "Isprincipal").hide();
                           }

                           $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderPrevId).hide();
                           $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderNextId).show();
                         
                       });
                      


                    }
                });
            });
           
            
            if ($("." + sliderOptions.sliderName + "-" + "toggler2").length===0) {
                $(this).after('<div class="' + sliderOptions.sliderName + "-" + 'toggler2"></div>');
            } 
           

            constructorImage($(controlSlider), sliderOptions.sliderwidth, sliderOptions.sliderheight, sliderOptions.sliderName, sliderOptions.sliderShow, sliderOptions.sliderPrevHoverImage, sliderOptions.sliderPrevImage, sliderOptions.sliderNextHoverImage, sliderOptions.sliderNextImage);


            $("." + sliderOptions.sliderName + "-" + "toggler2").css({            
                "position": "absolute",
                "top": 0,
                "left": 0,
                "z-index": "1000",
                "width": "100%",
                "height": "100%" ,
                "-khtml-opacity": "0.5",
                "opacity": "0.5",
                "-moz-opacity": "0.5",
                "-ms-filter": "progid:DXImageTransform.Microsoft.Alpha(Opacity=50)",
                "overflow": "hidden",
                "background-color": "#898989",
                "display": sliderOptions.sliderShow
            });


            $("#" + sliderOptions.sliderName + "-" + "Isprincipal").css({
                    "width": "150px",
                    "height": "30px",
                    "position": "absolute",
                    "z-index": "1000",
                    "border": "1px solid # 898989",
                    "margin-top": "-66px",
                    "color": "#898989",
                    "background": "#fff",
                    "border-top": "1px solid",
                    "border-right": "1px solid",
                    "border-bottom": "1px solid",
                    "border-color": "#898989",
                    "-khtml-opacity": "0.5",
                    "opacity": "0.5",
                    "-moz-opacity": "0.5",
                    "-ms-filter": "progid:DXImageTransform.Microsoft.Alpha(Opacity=50)",
            });
            
            $("#" + sliderOptions.sliderName + "-" + "Isprincipal").find('span').css({
                "color": "#858585",
                "margin": "5px 9px",
                "position": "absolute"
            });


            $("." + sliderOptions.sliderName + "-" + "btn_close").css({
                
                "float": "right",
                height: "21px",
                width : "21px",
                margin: "-30px 6px",
                padding: 0,
                position: "relative",
                "cursor": "pointer",
                "background-repeat": "no-repeat",
                "background-image": sliderOptions.sliderImgClose,

            });

            $("." + sliderOptions.sliderName + "-" + "slider-tittle").css(
                {
                    "color": "#727272",
                    "font-family": "trebuchet ms",
                    "font-size": "11pt",
                    "font-weight": "bold",
                    "margin": "8px 0 0 47px",
                    "height" : 29
                    
                });
          
            //validamos si el boton anterior se mostrara desde un principio
            if (sliderOptions.sliderPrevIdsliderPrevShow === false) {
                $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderPrevId).hide();
            }

            //Quitamos los eventos registrados para el boton siguiente y anterior
            $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderPrevId).unbind("click");
            $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderNextId).unbind("click");

            //evento click para el boton anteriror
            $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderPrevId).click(function (e) {
                e.preventDefault();
                if (sliderOptions.slidersteps >= 0) {
                    
                    $(controlSlider).attr("imageId", sliderOptions.sliderData[sliderOptions.slidersteps - 1].Id);
                    $(controlSlider).attr("isprincipal", sliderOptions.sliderData[sliderOptions.slidersteps - 1].Isprincipal);


                    $(controlSlider).attr("src", sliderOptions.sliderData[sliderOptions.slidersteps - 1].Route).animate("slow", function () {
                        constructorImage($(controlSlider), sliderOptions.sliderwidth, sliderOptions.sliderheight, sliderOptions.sliderName, "block", sliderOptions.sliderPrevHoverImage, sliderOptions.sliderPrevImage, sliderOptions.sliderNextHoverImage, sliderOptions.sliderNextImage);
                        if (sliderOptions.sliderData[sliderOptions.slidersteps - 1].Isprincipal) {
                            $("#" + sliderOptions.sliderName + "-" + "Isprincipal").show();
                            $("." + sliderOptions.sliderName + "-" + "slider-tittle").empty();
                        } else {
                            
                            var infoSec = "<input type='checkbox' class='" + sliderOptions.sliderCheckBoxName + "' style='margin-right: 8px;'/>Seleccionar esta foto como principal";

                            $("." + sliderOptions.sliderName + "-" + "slider-tittle").html(infoSec);

                            $("#" + sliderOptions.sliderName + "-" + "Isprincipal").hide();
                        }

                        $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderNextId).show();
                        sliderOptions.slidersteps = sliderOptions.slidersteps - 1;
                        if (sliderOptions.slidersteps === 0) {
                            $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderPrevId).hide();
                        }
                    });
                }

            });

            //evento click para el boton Siguiente 
            $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderNextId).click(function (e) {
                e.preventDefault();
                if (sliderOptions.slidersteps < sliderOptions.slidernumImages) {
                    $(controlSlider).attr("imageId", sliderOptions.sliderData[sliderOptions.slidersteps + 1].Id);
                    $(controlSlider).attr("isprincipal", sliderOptions.sliderData[sliderOptions.slidersteps + 1].Isprincipal);
                    $(controlSlider).attr("src", sliderOptions.sliderData[sliderOptions.slidersteps + 1].Route).animate("fast", function () {
                        constructorImage($(controlSlider), sliderOptions.sliderwidth, sliderOptions.sliderheight, sliderOptions.sliderName, "block", sliderOptions.sliderPrevHoverImage, sliderOptions.sliderPrevImage, sliderOptions.sliderNextHoverImage, sliderOptions.sliderNextImage);
                        if (sliderOptions.sliderData[sliderOptions.slidersteps + 1].Isprincipal) {
                            $("#" + sliderOptions.sliderName + "-" + "Isprincipal").show();
                            $("." + sliderOptions.sliderName + "-" + "slider-tittle").empty();

                        } else {
                            var infoSec = "<input type='checkbox' class='" + sliderOptions.sliderCheckBoxName + "' style='margin-right: 8px;'/>Seleccionar esta foto como principal";
                            
                            $("." + sliderOptions.sliderName + "-" + "slider-tittle").html(infoSec);
                            $("#" + sliderOptions.sliderName + "-" + "Isprincipal").hide();
                        }
                        sliderOptions.slidersteps = sliderOptions.slidersteps + 1;
                        $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderPrevId).show();
                        if (sliderOptions.slidersteps === sliderOptions.slidernumImages) {
                            $("." + sliderOptions.sliderName + "-" + sliderOptions.sliderNextId).hide();
                        }
                    });
                }

            });

            $("." + sliderOptions.sliderName + "-" + "btn_close").click(function () {
                $("." + sliderOptions.sliderName + "-" + "toggler2").hide();
                $("#" + sliderOptions.sliderName).hide(function () {
                  
                });
            });
        });



    };

})(jQuery);

function LoadCssControl(ControlId, sliderOptions)
{
    $(ControlId).css({
        "list-style": "none",
        "width": sliderOptions.sliderPreviewControlwidth
    });

    $(ControlId + " li").css({
        "display": "inline"
    });

    $(ControlId + " a").hover(function () {
        $(this).css({ "color": "#000000" });
    });

    $(ControlId + " a").hover(function () {
        $(this).find("img").css({ "color": "#000000" });
    });

    $("a:link").css({ "color": "#000000" });
    $("a:visited").css({ "color": "#000000" });
    $("a").hover(function () {
        $(this).css({ "color": "#000000" });
    });
}

function constructorImage(imagen, sliderwidth, sliderheight, sliderName, display, sliderPrevHoverImage, sliderPrevImage, sliderNextHoverImage, sliderNextImage) {


    imagen.removeAttr("width"); // quitamos el atributo width 
    imagen.removeAttr("height"); // quitamos el atributo height 
    var ctrolwidth;
    var ctrolheight;
    if (imagen.width() > imagen.height()) {
        ctrolwidth = sliderwidth;
        ctrolheight = sliderheight;
    }
    else {

        ctrolwidth = sliderheight;
        ctrolheight = sliderwidth - 50;
    }

    imagen.attr({ "width": (ctrolwidth + 100), "height": ctrolheight });
    
    $("#" + sliderName).css({
        'position': 'absolute',
        'left': '50%',
        'top': '50%',
        "background-color": "#fff",
        "border-radius": "5px",
        "border": "1px solid #bababa",
        "display": display,
        width: (ctrolwidth + 100) + "px",
        height: (ctrolheight + 100) + "px",
        "z-index": "20000"
        
    });
    $("#" + sliderName).css({
        'margin-left': -$("#" + sliderName).width() / 2 + 'px',
        'margin-top': -$("#" + sliderName).height() / 2 + 'px'
    });

    $("#" + sliderName + "-" + "container-slider").css(
   {
       "background-repeat": "no-repeat",
       width: (ctrolwidth + 100) + "px",
       height: ctrolheight + "px",
       "margin": "4px 0 0 0",
       padding: 0,
       "-moz-box-shadow": "0px 1px 4px 1px rgba(0,0,0,0.5)",
       "-webkit-box-shadow": "0px 1px 4px 1px rgba(0,0,0,0.5)",
       "box-shadow": "0px 1px 4px 1px rgba(0,0,0,0.5)",
       "overflow": "hidden"
   });



    $("#" + sliderName + "-" + "bnt-prev").css(
        {
            "padding": "0px",
            "width": "10px",
            "height": "40px",
            "z-index": "2000",
            "float": "left",
            "margin": 7,
            "background-image": sliderPrevImage,
            "background-repeat":"no-repeat",
            "cursor": "pointer"
        }).on("mouseenter", function () {
            $(this).css("background-image", sliderPrevHoverImage);
        }).on("mouseleave", function () {
            $(this).css("background-image", sliderPrevImage);
        });


    $("#" + sliderName + "-" + "btn-next").css(
    {
        "padding": "0px",
        "width": "10px",
        "height": "40px",
        "z-index": "2000",
        "float": "right",
        "margin": 7,
        "background-image": sliderNextImage,
        "background-repeat": "no-repeat",
        "cursor": "pointer"
    }).on("mouseenter", function () {
        $(this).css("background-image", sliderNextHoverImage);
    }).on("mouseleave", function () {
        $(this).css("background-image", sliderNextImage);
    });
};