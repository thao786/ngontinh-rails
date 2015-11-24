
$(document).ready(function(){
    $("#danhsachtruyen").addClass("active");
    $("tr:odd").addClass("warning");
    $(".list-group-item:even").addClass("list-group-item-warning");
    $(".list-group-item:odd").addClass("list-group-item-success");
});