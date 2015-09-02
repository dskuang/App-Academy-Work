Array.prototype.uniq = function () {
  var new_arr = [];

  for (var i = 0; i < this.length; i++) {
    var uniq = true;
    for(var k = 0; k < new_arr.length; k++) {
      if (new_arr[k] === this[i]) {
        uniq = false;
      }
    }
    if (uniq) {
      new_arr.push(this[i])
    }
  }
  return new_arr;
}

var array = [1,2,3,2];
console.log(array.uniq());

Array.prototype.two_sum = function () {
  var new_arr = [];
  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length; j++) {
      if ((this[i] + this[j]) == 0) {
        new_arr.push([i, j]);
      }
    }
  }
  return new_arr;

}

console.log([1, 2, -1, -2].two_sum());

Array.prototype.myTranspose = function () {
  var new_arr = [];
  for (var i = 0; i < this.length; i++) {
    var trans_arr = [];
    for (var j = 0; j < this.length; j++) {
        trans_arr.push(this[j][i]);

    }
    new_arr.push(trans_arr);
  }
  return new_arr;
}

var rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ];

  console.log(rows.myTranspose());

  Array.prototype.stockPicker = function () {
    var new_arr = [];
    var profit = 0;
    for (var i = 0; i < this.length; i++) {
      for (var j = i + 1; j < this.length; j++) {
        if (this[j] - this[i] > profit) {
          new_arr = [i, j];
          profit = this[j] - this[i];
        }
      }
    }
    return new_arr;
  }

var stocks = [ 1, 2, 3, 4 ];

console.log(stocks.stockPicker());
