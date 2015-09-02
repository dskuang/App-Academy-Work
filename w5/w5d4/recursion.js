// function range(start, end) {
//   if (start > end) {
//     return [];
//   }
//   var array = range(start + 1, end);
//   array.unshift(start);
//   return array;
// }
//
// console.log(range(1, 5));
//
// function sum(array) {
//   if (array.length === 1) {
//     return array[0];
//   }
//   var next = array.shift();
//   var total = sum(array);
//   return total + next;
// }
//
//
// console.log(sum([1, 2, 3]));
//
// function exponentiation(base, num) {
//   if (num === 0){
//     return 1;
//   }
//   return base * exponentiation(base, num - 1);
// }
//
// console.log(exponentiation(10, 5));
//
// function exponentiation2(base, num) {
//   if (num === 0){
//     return 1;
//   } else if (num === 1) {
//     return base;
//   }
//
//   if (num % 2 === 0) {
//     var expo = exponentiation2(base, num / 2);
//     return expo * expo;
//   } else {
//     var expo = (exponentiation2(base, (num - 1) / 2));
//     return base * expo * expo
//   }
// }
//
// console.log(exponentiation2(10, 5));
//
// function fibonnacci(num) {
//   if (num === 1) {
//     return [0];
//   } else if (num === 2) {
//     return [0, 1];
//   }
//
//   var fib = fibonnacci(num - 1);
//   fib.push(fib[fib.length - 1] + fib[fib.length - 2]);
//   return fib;
// }
//
// console.log(fibonnacci(5));
//
// function binarySearch(array, target) {
//   var pivot = Math.floor(array.length / 2);
//   if (array.length === 1 && target !== array[0]) {
//     return null;
//   } else if (target === array[pivot]) {
//     return pivot;
//   } else if (target < array[pivot]) {
//     return binarySearch(array.slice(0, pivot), target);
//   } else {
//     var partial = binarySearch(array.slice(pivot + 1), target)
//     if (partial === null) {
//       return partial;
//     }
//     return pivot + partial + 1;
//   }
// }
//
//
// console.log(binarySearch([1, 2, 3, 4, 5, 6, 7, 8, 9], 0));
//
// function makeChange(target, coins) {
//   var bestChange = [];
//   if (target === 0) {
//     return [];
//   }
//
//   coins.forEach( function (coin) {
//
//     if (target >= coin) {
//
//       var nextChange = makeChange(target - coin, coins);
//       nextChange.push(coin);
//       if(nextChange.length < bestChange.length || bestChange.length == 0){
//         bestChange = nextChange;
//       }
//     }
//   });
//
//   return bestChange;
//
// }
//
// console.log(makeChange(14,[10, 7, 1]));
//
//
// function mergeSort(array) {
//   if (array.length === 1) {
//     return array;
//   }
//   var pivot = Math.floor(array.length/2);
//   var left = mergeSort(array.slice(0, pivot));
//   var right = mergeSort(array.slice(pivot));
//   return merge(left, right);
//
// }
//
// function merge(left, right) {
//   var combined = [];
//
//   while(left.length !== 0 && right.length !== 0) {
//     if (left[0] < right[0]) {
//       combined.push(left.shift());
//     } else {
//       combined.push(right.shift());
//     }
//   }
//   return combined.concat(left, right)
// }
//
// var arr = [2, 1, 5, 7, 9, 13, 6]

// console.log(mergeSort(arr));

function subsets(array) {

  if (array.length === 0) {
    // var result = [array];
    return [array];
  }
  var el = array[0];
  var arrayMinusEl = array.slice(1);//, array.indexOf(el)).concat(array.slice(array.indexOf(el) + 1));
  var baserCase = subsets(arrayMinusEl);
  var additions = [];
  baserCase.forEach(function(base){
    // base.push(el);
    additions.push(base.concat([el]));
  });
  return baserCase.concat(additions);
  // return additions;

}

console.log(subsets([1, 2]));
