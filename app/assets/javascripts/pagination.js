// basic paging logic to demo the buttons
var pr = document.querySelector( '.paginate.left' );
var pl = document.querySelector( '.paginate.right' );

$('.paginate.left').click(slide.bind( this, -1 ));
$('.paginate.right').click(slide.bind( this, 1 ));

var total = parseInt($('.counter').text().substring(2,3));
var index = parseInt($('.counter').text().substring(0,1)) - 1;

function slide(offset) {
  index = Math.min( Math.max( index + offset, 0 ), total - 1 );

  $('.counter').html(( index + 1 ) + ' / ' + total);

  pr.setAttribute( 'data-state', index === 0 ? 'disabled' : '' );
  pl.setAttribute( 'data-state', index === total - 1 ? 'disabled' : '' );
}

slide(0);
