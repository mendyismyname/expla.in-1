(function(){
  
  window.autoFillBar = function( inputSelector ){
    var $backgroundInput,
        $mainInput,
        _this;

    _this = this;

    $mainInput = $( inputSelector ).css({
      zIndex: 1
    });

    $backgroundInput = $mainInput.clone().css({
      zIndex: -1,
      color: '#fff',
      position: 'absolute',
      top: 0,
      left: 0,
      background: 'rgba(0,0,0,0.7)'
      //fill
    }).addClass('auto-fill-background')
      .attr('id', '')
      .attr('name', '');

    $backgroundInput.attr('disabled', 'true');

    $mainInput.on('keydown', function( e ){

      if( e.keyCode === 9 && !e.shiftKey && $backgroundInput.val() !== '' ){
        //tab
        e.preventDefault();
        _this.complete();
      }
    });

    this.fill = function( value ){
      $backgroundInput.val( value );
    };

    this.complete = function(){
      $mainInput.val( $backgroundInput.val() );
    };

    $mainInput.after( $backgroundInput )
  };

}).call(this)