Array.prototype.myEach = function (callback) {
  for (var i = 0; i < this.length; i++) {
    callback(this[i]);
  }
}
// var arr = [1,2,3,4];
// arr.myEach( function (el) {
//   console.log(el);
// });


Array.prototype.myMap = function (callback) {
  var arr = [];
  this.myEach( function (el) {
    arr.push(callback(el));
  });
  return arr;

};

var arr = [1,2,3,4];
var map = arr.myMap( function (el) {
  return (el * el);
})
console.log(map);



Array.prototype.myInject = function (callback) {
  var answer = this[0];
  var theRest = this.slice(1, this.length);
  console.log(theRest);
  theRest.myEach( function (el) {
    answer = callback(answer, el);
  })
  return answer;
};

var inject = arr.myInject( function (sum, el) {
  return sum + el;
});

console.log(inject);
