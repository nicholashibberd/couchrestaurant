$(function() {
  $('select#sitting').change(function(){
		$('.booking_reservation_form').addClass('js_form_initiated');
	  $(this).closest("form").submit();
  });
});

$(function(){
	$('.availability_timeslot').live('click', function() {
		$('.availability_timeslot.selected').removeClass('selected');
		$(this).addClass('selected')
		$(this).children("input[type=radio]").attr('checked', 'checked');
	});
});