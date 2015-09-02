function sum() {
  var total = 0;
  Array.prototype.forEach.call(arguments, function(el){
    total += el;
  });
  return total;
}



Function.prototype.myBind = function(context) {
  var fn = this;
  var args = Array.prototype.slice.call(arguments, 1);
  return function(){
    var call_args = Array.prototype.slice.call(arguments);
    return fn.apply(context, args.concat(call_args));
  }
}

function curriedSum(numArgs) {
  var numbers = [];
  function _curriedSum(value){
    numbers.push(value);
    if (numbers.length === numArgs) {
      var sum = 0;
      numbers.forEach(function(el) {
        sum += el;
      });
      return sum;
    } else {
      return _curriedSum;
    }
  }

  return _curriedSum;
}

// console.log(sum(1,2,3,4,5));
var sum = curriedSum(4);
console.log(sum(5)(30)(20)(1)); // => 56
console.log(curriedSum(2)(1)(2));
