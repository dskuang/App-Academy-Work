Array.prototype.bubble_sort = function () {
  var unsorted = true;
  while (unsorted) {
    unsorted = false;
    for (var i = 0; i < (this.length - 1); i++) {
      if (this[i + 1] < this[i]) {
        var temp = this[i];
        this[i] = this[i + 1];
        this[i + 1] = temp;
        unsorted = true;
      }
    }
  }
  return this;
}

var arr = [2, 5, 3, 1, 4];
console.log(arr.bubble_sort());


String.prototype.substrings = function () {
  var new_arr = [];
  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length + 1; j++) {
      var new_sub = this.slice(i, j);
      var unique = true;
      for (var k = 0; k < new_arr.length; k++) {
        if (new_arr[k] === new_sub) {
          unique = false;
        }
      }
      if (unique) {
        new_arr.push(new_sub);
      }
    }
  }
  return new_arr;
}

var sub = "apple";
console.log(sub.substrings());
