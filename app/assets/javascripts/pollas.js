// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on( "click", ".rondas", function() {
  var max_teams = $(this).data('max-teams');
  if(max_teams < $('.rondas:checked').length){
    alert("Solo puede seleccionar "+max_teams+" equipos");
    $(this).prop('checked', false);
  }
});

$(document).on( "change", ".posiciones", function() {
  var selected = $(this).val();
  var count = 0;
  $(".posiciones").each(function(){
    if($(this).val() == selected){
      count += 1;
    }
  });
  if(count > 1) {
    alert("No puede seleccionar dos veces el mismo equipo");
    $(this).val("");
  }
});

$(document).on( "click", ".btn-wizard", function() {
  var href = '';
  var pollaid = $(this).data('pollaid');
  var step = $(this).data('step');
  if(pollaid == ""){
    href = '/pollas/new?step='+step;
  } else {
    href = '/pollas/'+pollaid+'/edit?step='+step;
  }
  window.location.href = href;
});
