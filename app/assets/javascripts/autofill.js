(function(){
  
  window.autoFillBar = function( inputSelector ){
    var $backgroundInput,
        $mainInput,
        _this;

    _this = this;

    $mainInput = $( inputSelector ).css({
        zIndex: 1,
      });

    $backgroundInput = $( '<input>',{
      'class': 'auto-fill-background',
      css: {
        zIndex: -1
        //fill
      }
    });
    $backgroundInput.attr('disabled', 'true');

    $mainInput.on('keydown', function( e ){

      if( e.keyCode === 9 && !e.shiftKey ){
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